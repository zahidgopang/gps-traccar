<?php

namespace App\Http\Controllers\Api\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Concerns\RespondsWithMobileJson;
use App\Models\VehicleEvent;
use App\Services\Mobile\MobileDevicePresenter;
use App\Services\UserDashboardService;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    use RespondsWithMobileJson;

    public function __construct(
        private UserDashboardService $dashboard,
        private MobileDevicePresenter $presenter,
    ) {}

    public function summary(Request $request)
    {
        $user = $request->user();
        $stats = $this->dashboard->getStats($user);
        $page = $this->dashboard->getDevicePageStats($stats['devices']);
        $states = $stats['vehicleStates'];

        $geofenceAlerts = 0;
        if ($stats['devices']->isNotEmpty()) {
            $deviceIds = $stats['devices']->pluck('id');
            $geofenceAlerts = app(\App\Contracts\Tracking\EventReaderInterface::class)->countForDevices(
                $deviceIds,
                now()->subDays(7),
                [VehicleEvent::TYPE_GEOFENCE_ENTER, VehicleEvent::TYPE_GEOFENCE_EXIT]
            );
        }

        return $this->mobileSuccess([
            'total_devices' => $stats['totalDevices'],
            'online_devices' => $stats['onlineNow'],
            'offline_devices' => $page['offlineNow'],
            'moving_devices' => $states['running'] ?? 0,
            'parked_devices' => $states['parked'] ?? 0,
            'alerts_count' => $stats['activeAlerts'],
            'total_distance_km' => $stats['totalDistanceKm'],
            'geofence_alerts' => $geofenceAlerts,
        ]);
    }

    public function activity(Request $request)
    {
        $user = $request->user();
        $stats = $this->dashboard->getStats($user);
        $deviceIds = $stats['devices']->pluck('id');

        $activities = $this->dashboard->getRecentActivities($deviceIds)
            ->map(fn (array $item) => [
                'type' => $item['type'],
                'title' => $item['title'],
                'description' => $item['description'],
                'time' => $item['time']?->toIso8601String(),
                'icon' => $item['icon'],
            ])
            ->values();

        return $this->mobileSuccess($activities);
    }

    public function recentVehicles(Request $request)
    {
        $user = $request->user();
        $stats = $this->dashboard->getStats($user);
        $alertIds = $this->dashboard->alertDeviceIds($stats['devices']);

        $items = $stats['recentDevices']->map(
            fn ($device) => $this->presenter->listItem($device, $alertIds)
        )->values();

        return $this->mobileSuccess($items);
    }
}
