<?php

namespace App\Http\Controllers\Api\Mobile;

use App\Contracts\Tracking\EventReaderInterface;
use App\Http\Controllers\Controller;
use App\Http\Concerns\RespondsWithMobileJson;
use App\Models\Device;
use App\Models\VehicleEvent;
use App\Models\VehicleEventRead;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AlertController extends Controller
{
    use RespondsWithMobileJson;

    public function __construct(
        private EventReaderInterface $events,
    ) {}

    public function index(Request $request)
    {
        $user = $request->user();
        $devices = $user->trackableDevicesQuery()->get();
        $deviceIds = $devices->pluck('id');

        if ($deviceIds->isEmpty()) {
            return $this->mobileSuccess([]);
        }

        $readIds = $this->readEventIds($user->id);

        $query = VehicleEvent::query()
            ->with([Device::eagerListRelation(), 'geofence:id,name'])
            ->whereIn('device_id', $deviceIds)
            ->orderByDesc('occurred_at');

        if ($request->filled('device_id')) {
            $query->where('device_id', (int) $request->device_id);
        }

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->from);
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->to);
        }

        $limit = min(100, max(1, (int) $request->query('limit', 50)));
        $events = $query->limit($limit)->get();

        return $this->mobileSuccess(
            $events->map(fn (VehicleEvent $e) => $this->formatAlert($e, $readIds))->values()
        );
    }

    public function unread(Request $request)
    {
        $user = $request->user();
        $deviceIds = $user->trackableDevicesQuery()->pluck('id');

        if ($deviceIds->isEmpty()) {
            return $this->mobileSuccess(['count' => 0, 'alerts' => []]);
        }

        $readIds = $this->readEventIds($user->id);

        $events = VehicleEvent::query()
            ->with([Device::eagerListRelation(), 'geofence:id,name'])
            ->whereIn('device_id', $deviceIds)
            ->when($readIds !== [], fn ($q) => $q->whereNotIn('id', $readIds))
            ->orderByDesc('occurred_at')
            ->limit(50)
            ->get();

        return $this->mobileSuccess([
            'count' => $events->count(),
            'alerts' => $events->map(fn (VehicleEvent $e) => $this->formatAlert($e, $readIds))->values(),
        ]);
    }

    public function markRead(Request $request)
    {
        $validated = $request->validate([
            'alert_ids' => 'required|array|min:1',
            'alert_ids.*' => 'integer',
        ]);

        $user = $request->user();
        $deviceIds = $user->trackableDevicesQuery()->pluck('id');

        $validIds = VehicleEvent::query()
            ->whereIn('device_id', $deviceIds)
            ->whereIn('id', $validated['alert_ids'])
            ->pluck('id');

        $now = now();
        $rows = $validIds->map(fn ($id) => [
            'user_id' => $user->id,
            'vehicle_event_id' => $id,
            'read_at' => $now,
        ])->all();

        if ($rows !== []) {
            DB::table('vehicle_event_reads')->upsert(
                $rows,
                ['user_id', 'vehicle_event_id'],
                ['read_at']
            );
        }

        return $this->mobileSuccess([
            'marked' => $validIds->count(),
            'message' => 'Alerts marked as read',
        ]);
    }

    /**
     * @param  list<int>  $readIds
     * @return array<string, mixed>
     */
    private function formatAlert(VehicleEvent $event, array $readIds): array
    {
        return array_merge($event->toAlertArray(), [
            'device_id' => $event->device_id,
            'device_name' => $event->device?->name,
            'read' => in_array($event->id, $readIds, true),
        ]);
    }

    /**
     * @return list<int>
     */
    private function readEventIds(int $userId): array
    {
        if (! \Illuminate\Support\Facades\Schema::hasTable('vehicle_event_reads')) {
            return [];
        }

        return VehicleEventRead::query()
            ->where('user_id', $userId)
            ->pluck('vehicle_event_id')
            ->all();
    }
}
