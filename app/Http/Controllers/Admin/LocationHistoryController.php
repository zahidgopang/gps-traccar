<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Device;
use App\Services\DeviceSubscriptionService;
use App\Services\Tracking\DevicePositionLoader;
use App\Services\UserDashboardService;
use Illuminate\Http\Request;

class LocationHistoryController extends Controller
{
    public function index(Request $request, UserDashboardService $dashboard, DeviceSubscriptionService $subscriptions)
    {
        $q = Device::inTracker()
            ->with(['user', 'subscription'])
            ->orderByDesc('id');

        if ($search = $request->query('q')) {
            $q->where(function ($w) use ($search) {
                $w->whereImeiLike("%{$search}%")
                    ->orWhere('name', 'like', "%{$search}%")
                    ->orWhereHas('user', fn ($u) => $u->where('name', 'like', "%{$search}%")->orWhere('email', 'like', "%{$search}%"));
            });
        }

        if ($request->filled('status')) {
            $q->whereAppStatus($request->status);
        }

        $devices = $q->paginate(20)->withQueryString();
        app(\App\Services\Tracking\DevicePositionLoader::class)->attachLatestToMany($devices->getCollection());
        $alertDeviceIds = $dashboard->alertDeviceIds($devices->getCollection());

        return view('admin.locations.index', [
            'devices' => $devices,
            'dashboardService' => $dashboard,
            'subscriptionService' => $subscriptions,
            'alertDeviceIds' => $alertDeviceIds,
            'stats' => $dashboard->getDevicePageStats($devices->getCollection()),
        ]);
    }

    public function liveJson(Request $request, UserDashboardService $dashboard)
    {
        $ids = collect(explode(',', (string) $request->query('ids', '')))
            ->map(fn ($id) => (int) $id)
            ->filter(fn ($id) => $id > 0)
            ->unique()
            ->values()
            ->take(50);

        if ($ids->isEmpty()) {
            return response()->json([
                'devices' => [],
                'stats' => null,
            ]);
        }

        $devices = Device::inTracker()
            ->whereIn('id', $ids)
            ->get()
            ->sortBy(fn (Device $d) => $ids->search($d->id))
            ->values();

        app(DevicePositionLoader::class)->attachLatestToMany($devices);
        $alertDeviceIds = $dashboard->alertDeviceIds($devices);

        $devicesPayload = $devices->map(function (Device $device) use ($dashboard, $alertDeviceIds) {
            $liveStatus = $dashboard->resolveDeviceStatus($device, $alertDeviceIds);
            $latest = $device->latestLocation;

            return [
                'id' => $device->id,
                'live_status' => $liveStatus,
                'lat' => $latest ? (float) $latest->lat : null,
                'lng' => $latest ? (float) $latest->lng : null,
                'speed' => $latest ? round((float) ($latest->speed ?? 0), 0) : null,
                'position_id' => $latest?->id,
                'recorded_at' => $latest?->recorded_at?->toIso8601String(),
                'recorded_at_human' => $latest?->recorded_at?->diffForHumans() ?? __('app.common.no_data'),
            ];
        })->values();

        return response()->json([
            'devices' => $devicesPayload,
            'stats' => $dashboard->getDevicePageStats($devices),
        ]);
    }
}
