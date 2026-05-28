<?php

namespace App\Http\Controllers\Api\Mobile;

use App\Contracts\Tracking\EventReaderInterface;
use App\Contracts\Tracking\PositionReaderInterface;
use App\Http\Controllers\Controller;
use App\Http\Concerns\ResolvesHistoryDateRange;
use App\Http\Concerns\ResolvesMobileDevice;
use App\Http\Concerns\RespondsWithMobileJson;
use App\Models\VehicleEvent;
use App\Services\Mobile\MobileDevicePresenter;
use App\Services\Mobile\MobileRouteAnalyticsService;
use App\Services\Tracking\DevicePositionLoader;
use App\Services\UserDashboardService;
use App\Services\VehicleEventService;
use Illuminate\Http\Request;

class DeviceController extends Controller
{
    use ResolvesHistoryDateRange;
    use ResolvesMobileDevice;
    use RespondsWithMobileJson;

    public function __construct(
        private MobileDevicePresenter $presenter,
        private DevicePositionLoader $positionLoader,
        private PositionReaderInterface $positions,
        private MobileRouteAnalyticsService $routeAnalytics,
        private EventReaderInterface $events,
        private UserDashboardService $dashboard,
    ) {}

    public function index(Request $request)
    {
        $user = $request->user();
        $devices = $user->trackableDevicesQuery()->with(['subscription'])->get();
        $this->positionLoader->attachLatestToMany($devices);
        $alertIds = $this->dashboard->alertDeviceIds($devices);

        return $this->mobileSuccess(
            $devices->map(fn ($d) => $this->presenter->listItem($d, $alertIds))->values()
        );
    }

    public function show(Request $request, int $id)
    {
        $device = $this->findMobileDevice($request->user(), $id);
        $this->positionLoader->attachLatest($device);
        $alertIds = $this->dashboard->alertDeviceIds(collect([$device]));

        return $this->mobileSuccess($this->presenter->detail($device, $alertIds));
    }

    public function live(Request $request, int $id)
    {
        $device = $this->findMobileDevice($request->user(), $id);
        $latest = $this->positions->latestForDevice($device);

        if ($latest && config('tracking.laravel_geofence_detection', true)) {
            app(VehicleEventService::class)->processGeofenceFromLocation(
                $device,
                (float) $latest->lat,
                (float) $latest->lng,
                $latest->recorded_at ?? now()
            );
        }

        $payload = $this->presenter->livePosition($device);

        if (! $payload) {
            return $this->mobileError('No live position available', 404, 'no_data');
        }

        return $this->mobileSuccess($payload);
    }

    public function history(Request $request, int $id)
    {
        $device = $this->findMobileDevice($request->user(), $id);
        $range = $this->resolveHistoryRange($request);

        $locations = $this->positions->historyForDevice(
            $device,
            $range['from'],
            $range['to'],
            'asc'
        );

        $points = $locations->map(fn ($loc) => [
            'lat' => (float) $loc->lat,
            'lng' => (float) $loc->lng,
            'speed' => (float) ($loc->speed ?? 0),
            'heading' => (float) ($loc->heading ?? 0),
            'ignition' => (bool) $loc->ignition,
            'battery' => $loc->battery_level,
            'recorded_at' => $loc->recorded_at?->toIso8601String(),
        ])->values();

        $stats = $this->routeAnalytics->analyze($locations);

        return $this->mobileSuccess([
            'polyline' => $points,
            'stops' => $stats['stops'],
            'moving_points' => $stats['moving_points'],
            'idle_points' => $stats['idle_points'],
            'from' => $range['from']->toIso8601String(),
            'to' => $range['to']?->toIso8601String(),
        ]);
    }

    public function routeSummary(Request $request, int $id)
    {
        $device = $this->findMobileDevice($request->user(), $id);
        $range = $this->resolveHistoryRange($request);

        $locations = $this->positions->historyForDevice(
            $device,
            $range['from'],
            $range['to'],
            'asc'
        );

        $stats = $this->routeAnalytics->analyze($locations);

        return $this->mobileSuccess([
            'total_distance_km' => $stats['total_distance_km'],
            'moving_time_seconds' => $stats['moving_time_seconds'],
            'stopped_time_seconds' => $stats['stopped_time_seconds'],
            'max_speed_kmh' => $stats['max_speed_kmh'],
            'average_speed_kmh' => $stats['average_speed_kmh'],
            'idle_time_seconds' => $stats['idle_time_seconds'],
        ]);
    }

    public function events(Request $request, int $id)
    {
        $device = $this->findMobileDevice($request->user(), $id);
        $range = $this->resolveHistoryRange($request);

        $types = [
            VehicleEvent::TYPE_IGNITION,
            VehicleEvent::TYPE_OVERSPEED,
            VehicleEvent::TYPE_STOPPED,
            VehicleEvent::TYPE_GEOFENCE_ENTER,
            VehicleEvent::TYPE_GEOFENCE_EXIT,
            VehicleEvent::TYPE_PANIC,
            VehicleEvent::TYPE_LOW_BATTERY,
            VehicleEvent::TYPE_POWER_CUT,
        ];

        $collection = $this->events->forDevice(
            $device,
            $range['from'],
            $range['to'],
            $types,
            min(200, max(1, (int) $request->query('limit', 100)))
        );

        return $this->mobileSuccess(
            $collection->map(fn (VehicleEvent $event) => $event->toAlertArray())->values()
        );
    }
}
