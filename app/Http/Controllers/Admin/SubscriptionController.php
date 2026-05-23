<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Device;
use App\Models\Subscription;
use App\Services\AdminAuditService;
use App\Services\DeviceSubscriptionService;
use App\Services\SubscriptionRenewalService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use InvalidArgumentException;

class SubscriptionController extends Controller
{
    public function __construct(
        private AdminAuditService $audit,
        private DeviceSubscriptionService $subscriptions,
        private SubscriptionRenewalService $renewals
    ) {}

    public function index(Request $request)
    {
        $q = Subscription::with(['user', 'device'])->withCount('histories');

        if ($search = $request->query('q')) {
            $q->where(function ($query) use ($search) {
                $query->where('plan', 'like', "%{$search}%")
                    ->orWhereHas('device', fn ($d) => $d->where('name', 'like', "%{$search}%")->whereImeiLike("%{$search}%"))
                    ->orWhereHas('user', fn ($u) => $u->where('name', 'like', "%{$search}%")->orWhere('email', 'like', "%{$search}%"));
            });
        }

        $subs = $q->orderByDesc('created_at')->paginate(15)->withQueryString();

        $subs->getCollection()->transform(function (Subscription $subscription) {
            return $this->renewals->syncExpiredStatus($subscription);
        });

        return view('admin.subscriptions.index', compact('subs'));
    }

    public function create()
    {
        $devices = Device::query()->where('disabled', 0)->orderBy('name')->get();

        return view('admin.subscriptions.create', compact('devices'));
    }

    public function store(Request $request)
    {
        $data = $this->validated($request);

        $subscription = Subscription::create($data);

        $this->audit->logCreated($subscription, "subscription for device #{$subscription->device_id}", [
            'plan' => $subscription->plan,
            'status' => $subscription->status,
            'ends_at' => $subscription->ends_at?->toDateString(),
        ]);

        return redirect()->route('admin.subscriptions.index')->with('success', 'Device subscription created.');
    }

    public function edit(Subscription $subscription)
    {
        $subscription->load(['user', 'device']);
        $devices = Device::query()->where('disabled', 0)->orderBy('name')->get();

        return view('admin.subscriptions.edit', compact('subscription', 'devices'));
    }

    public function update(Request $request, Subscription $subscription)
    {
        $data = $this->validated($request, $subscription);

        $subscription->update($data);

        $this->audit->logUpdated($subscription, "subscription for device #{$subscription->device_id}", [
            'plan' => $subscription->plan,
            'status' => $subscription->status,
            'ends_at' => $subscription->ends_at?->toDateString(),
        ]);

        return redirect()->route('admin.subscriptions.index')->with('success', 'Device subscription updated.');
    }

    public function destroy(Subscription $subscription)
    {
        $deviceId = $subscription->device_id;
        $subscription->delete();

        $this->audit->log('deleted', "Deleted subscription for device #{$deviceId}");

        return redirect()->route('admin.subscriptions.index')->with('success', 'Deleted.');
    }

    public function renew(Request $request, Subscription $subscription)
    {
        $data = $request->validate([
            'starts_at' => 'required|date',
            'ends_at' => 'required|date|after_or_equal:starts_at',
        ]);

        try {
            $renewed = $this->renewals->renew(
                $subscription,
                Carbon::parse($data['starts_at']),
                Carbon::parse($data['ends_at']),
                $request->user()
            );
        } catch (InvalidArgumentException $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $this->audit->log('renewed', "Renewed subscription for device #{$renewed->device_id}", $renewed, [
            'plan' => $renewed->plan,
            'starts_at' => $renewed->starts_at?->toDateString(),
            'ends_at' => $renewed->ends_at?->toDateString(),
            'status' => $renewed->status,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Subscription renewed successfully.',
            'subscription' => [
                'id' => $renewed->id,
                'status' => $renewed->status,
                'starts_at' => $renewed->starts_at?->format('d M Y'),
                'ends_at' => $renewed->ends_at?->format('d M Y'),
            ],
        ]);
    }

    public function histories(Subscription $subscription)
    {
        $subscription->load(['device', 'user']);
        $histories = $subscription->histories()
            ->with('archivedByUser:id,name,email')
            ->get();

        return response()->json([
            'subscription' => [
                'id' => $subscription->id,
                'plan' => $subscription->plan,
                'device' => $subscription->device ? [
                    'id' => $subscription->device->id,
                    'name' => $subscription->device->name,
                    'imei' => $subscription->device->imei,
                ] : null,
                'user' => $subscription->user?->only(['id', 'name', 'email']),
                'current' => [
                    'starts_at' => $subscription->starts_at?->format('d M Y'),
                    'ends_at' => $subscription->ends_at?->format('d M Y'),
                    'status' => $subscription->status,
                ],
            ],
            'histories' => $histories->map(fn ($h) => [
                'id' => $h->id,
                'plan' => $h->plan,
                'starts_at' => $h->starts_at?->format('d M Y') ?? '—',
                'ends_at' => $h->ends_at?->format('d M Y') ?? '—',
                'status' => $h->status,
                'archived_at' => $h->archived_at?->format('d M Y H:i'),
                'archived_by' => $h->archivedByUser?->name ?? 'System',
            ]),
        ]);
    }

    private function validated(Request $request, ?Subscription $subscription = null): array
    {
        $data = $request->validate([
            'device_id' => [
                'required',
                'exists:tc_devices,id',
                Rule::unique('subscriptions', 'device_id')->ignore($subscription?->id),
            ],
            'plan' => 'required|string|max:255',
            'starts_at' => 'nullable|date',
            'ends_at' => 'nullable|date|after_or_equal:starts_at',
            'status' => 'required|in:active,expired,cancelled',
        ]);

        $device = Device::findOrFail($data['device_id']);
        $data['user_id'] = $device->user_id;

        if (
            ($data['status'] ?? '') === 'active'
            && ! empty($data['ends_at'])
            && Carbon::parse($data['ends_at'])->endOfDay()->isPast()
        ) {
            $data['status'] = 'expired';
        }

        return $data;
    }
}
