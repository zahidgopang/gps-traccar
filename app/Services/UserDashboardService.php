<?php

namespace App\Services;

use App\Contracts\Geofences\GeofenceStoreInterface;
use App\Contracts\Tracking\EventReaderInterface;
use App\Models\Device;
use App\Models\VehicleEvent;
use App\Models\User;
use App\Services\Tracking\DevicePositionLoader;
use App\Services\Tracking\TrackingMetricsService;
use App\Services\Traccar\TraccarTrackingGate;
use App\Services\Traccar\TraccarUserAccessService;
use Illuminate\Support\Collection;
use Spatie\Activitylog\Models\Activity;

class UserDashboardService
{
    public function __construct(
        private DevicePositionLoader $positionLoader,
        private TrackingMetricsService $metrics,
        private EventReaderInterface $events,
        private GeofenceStoreInterface $geofences,
        private TraccarUserAccessService $trackerUsers,
        private TraccarTrackingGate $trackingGate,
    ) {}

    public const ONLINE_MINUTES = 5;

    public const MOVING_SPEED_KMH = 5;

    public function getStats(User $user): array
    {
        if (! $this->trackerUsers->hasTrackerAccount($user)) {
            return $this->emptyTrackerStats();
        }

        $devices = $user->trackerDevicesQuery()->with(['subscription'])->get();
        $devices = $this->trackingGate->filterTrackable($user, $devices);
        $this->positionLoader->attachLatestToMany($devices);
        $deviceIds = $devices->pluck('id');

        $totalDevices = $devices->count();
        $activeDevices = $devices->where('status', 'active')->count();
        $totalDistanceKm = $this->metrics->calculateTotalDistanceKm($deviceIds);
        $activeAlerts = $deviceIds->isEmpty()
            ? 0
            : $this->events->countForDevices(
                $deviceIds,
                now()->subDays(7),
                [VehicleEvent::TYPE_GEOFENCE_EXIT, VehicleEvent::TYPE_OVERSPEED, VehicleEvent::TYPE_PANIC]
            );
        $onlineNow = $this->countOnlineDevices($devices);

        $vehicleStates = $this->getVehicleStateCounts($devices);
        $recentDevices = $devices->sortByDesc(fn (Device $d) => $d->latestLocation?->recorded_at)->take(5)->values();
        $activities = $this->getRecentActivities($deviceIds);

        return [
            'devices' => $devices,
            'totalDevices' => $totalDevices,
            'activeDevices' => $activeDevices,
            'totalDistanceKm' => round($totalDistanceKm),
            'activeAlerts' => $activeAlerts,
            'onlineNow' => $onlineNow,
            'vehicleStates' => $vehicleStates,
            'recentDevices' => $recentDevices,
            'activities' => $activities,
            'activePercent' => $totalDevices > 0 ? round(($activeDevices / $totalDevices) * 100) : 0,
            'onlinePercent' => $totalDevices > 0 ? round(($onlineNow / $totalDevices) * 100) : 0,
            'alertsPercent' => min(100, $activeAlerts * 20),
            'distancePercent' => min(100, (int) round($totalDistanceKm / 50)),
        ];
    }

    public function calculateTotalDistanceKm(Collection $deviceIds, int $days = 30): float
    {
        return $this->metrics->calculateTotalDistanceKm($deviceIds, $days);
    }

    public function countOnlineDevices(Collection $devices): int
    {
        $cutoff = now()->subMinutes(self::ONLINE_MINUTES);

        return $devices->filter(function (Device $device) use ($cutoff) {
            return $device->status === 'active'
                && $device->latestLocation
                && $device->latestLocation->recorded_at >= $cutoff;
        })->count();
    }

    public function getVehicleStateCounts(Collection $devices): array
    {
        $running = 0;
        $parked = 0;
        $maintenance = 0;
        $alerts = 0;

        $cutoff = now()->subMinutes(self::ONLINE_MINUTES);
        $alertDeviceIds = $this->alertDeviceIds($devices);

        foreach ($devices as $device) {
            if (in_array($device->status, ['inactive', 'blocked'], true)) {
                $maintenance++;
                continue;
            }

            $latest = $device->latestLocation;
            if (! $latest || $latest->recorded_at < $cutoff) {
                continue;
            }

            if ($alertDeviceIds->contains($device->id)) {
                $alerts++;
            }

            if ((float) ($latest->speed ?? 0) > self::MOVING_SPEED_KMH) {
                $running++;
            } else {
                $parked++;
            }
        }

        return compact('running', 'parked', 'maintenance', 'alerts');
    }

    public function getRecentActivities(Collection $deviceIds): Collection
    {
        if ($deviceIds->isEmpty()) {
            return collect();
        }

        $vehicleItems = $this->events->recentForDevices($deviceIds, 12)
            ->map(fn (VehicleEvent $event) => [
                'type' => 'vehicle',
                'title' => $event->title,
                'description' => $event->message,
                'time' => $event->occurred_at,
                'icon' => match ($event->type) {
                    VehicleEvent::TYPE_GEOFENCE_EXIT, VehicleEvent::TYPE_PANIC, VehicleEvent::TYPE_OVERSPEED => 'fa-exclamation-triangle',
                    VehicleEvent::TYPE_GEOFENCE_ENTER => 'fa-draw-polygon',
                    VehicleEvent::TYPE_STOPPED => 'fa-parking',
                    default => 'fa-car',
                },
                'gradient' => match ($event->severity()) {
                    'error' => 'linear-gradient(135deg, #EF4444, #DC2626)',
                    'warning' => 'linear-gradient(135deg, #F59E0B, #D97706)',
                    default => 'linear-gradient(135deg, var(--primary-blue), var(--secondary-blue))',
                },
            ]);

        $activityItems = Activity::where('log_name', 'device')
            ->where('subject_type', Device::class)
            ->whereIn('subject_id', $deviceIds)
            ->latest()
            ->limit(8)
            ->get()
            ->map(fn (Activity $activity) => [
                'type' => 'activity',
                'title' => $activity->description ?? 'Device activity',
                'description' => data_get($activity->properties, 'device_name') ?: ($activity->description ?? ''),
                'time' => $activity->created_at,
                'icon' => 'fa-satellite',
                'gradient' => 'linear-gradient(135deg, #10B981, #059669)',
            ]);

        return $vehicleItems
            ->concat($activityItems)
            ->sortByDesc('time')
            ->take(8)
            ->values();
    }

    public function alertDeviceIds(Collection $devices, int $hours = 24): Collection
    {
        $ids = $devices->pluck('id');

        if ($ids->isEmpty()) {
            return collect();
        }

        $alertIds = collect();

        foreach ($devices as $device) {
            $hasExit = $this->events
                ->forDevice($device, now()->subHours($hours), null, [VehicleEvent::TYPE_GEOFENCE_EXIT], 1)
                ->isNotEmpty();

            if ($hasExit) {
                $alertIds->push($device->id);
            }
        }

        return $alertIds;
    }

    /**
     * Tracker dashboard with no tc_users row — no devices, maps, or GPS metrics.
     *
     * @return array<string, mixed>
     */
    public function emptyTrackerStats(): array
    {
        return [
            'devices' => collect(),
            'totalDevices' => 0,
            'activeDevices' => 0,
            'totalDistanceKm' => 0,
            'activeAlerts' => 0,
            'onlineNow' => 0,
            'vehicleStates' => ['running' => 0, 'parked' => 0, 'maintenance' => 0, 'alerts' => 0],
            'recentDevices' => collect(),
            'activities' => collect(),
            'activePercent' => 0,
            'onlinePercent' => 0,
            'alertsPercent' => 0,
            'distancePercent' => 0,
        ];
    }

    public function getProfileStats(User $user): array
    {
        $stats = $this->getStats($user);
        $devices = $stats['devices'];
        $deviceIds = $devices->pluck('id');
        $pageStats = $this->getDevicePageStats($devices);

        $trackingDaysActive = $this->metrics->activeTrackingDays($deviceIds);

        $geofenceCount = 0;
        foreach ($devices as $device) {
            $geofenceCount += $this->geofences->forDevice($device)->count();
        }

        return array_merge($stats, $pageStats, [
            'trackingDaysActive' => $trackingDaysActive,
            'geofenceCount' => $geofenceCount,
            'memberDays' => max(1, $user->created_at?->diffInDays(now()) ?? 1),
        ]);
    }

    public function getDevicePageStats(Collection $devices): array
    {
        $vehicleStates = $this->getVehicleStateCounts($devices);

        $onlineNow = $this->countOnlineDevices($devices);
        $total = $devices->count();

        return [
            'totalDevices' => $total,
            'activeDevices' => $devices->where('status', 'active')->count(),
            'inactiveDevices' => $devices->where('status', 'inactive')->count(),
            'blockedDevices' => $devices->where('status', 'blocked')->count(),
            'onlineNow' => $onlineNow,
            'offlineNow' => max(0, $total - $onlineNow),
            'running' => $vehicleStates['running'],
            'parked' => $vehicleStates['parked'],
            'maintenance' => $vehicleStates['maintenance'],
            'alerts' => $vehicleStates['alerts'],
        ];
    }

    public function resolveDeviceStatus(Device $device, ?Collection $alertDeviceIds = null): array
    {
        $cutoff = now()->subMinutes(self::ONLINE_MINUTES);
        $latest = $device->latestLocation;

        if ($device->status === 'blocked') {
            return ['label' => __('app.common.blocked'), 'class' => 'bg-dark', 'dot' => 'bg-dark'];
        }

        if ($device->status === 'inactive') {
            return ['label' => __('app.common.inactive'), 'class' => 'bg-secondary', 'dot' => 'bg-secondary'];
        }

        if (! $latest || $latest->recorded_at < $cutoff) {
            return ['label' => __('app.common.offline'), 'class' => 'bg-secondary', 'dot' => 'bg-secondary'];
        }

        $hasAlert = $alertDeviceIds
            ? $alertDeviceIds->contains($device->id)
            : $this->events
                ->forDevice($device, now()->subDay(), null, [
                    VehicleEvent::TYPE_GEOFENCE_EXIT,
                    VehicleEvent::TYPE_OVERSPEED,
                    VehicleEvent::TYPE_PANIC,
                ], 1)
                ->isNotEmpty();

        if ($hasAlert) {
            return ['label' => __('app.user.devices.status_alert'), 'class' => 'bg-danger', 'dot' => 'bg-danger'];
        }

        if ((float) ($latest->speed ?? 0) > self::MOVING_SPEED_KMH) {
            return ['label' => __('app.common.moving'), 'class' => 'bg-success', 'dot' => 'bg-success'];
        }

        if ((float) ($latest->speed ?? 0) > 0) {
            return ['label' => __('app.user.devices.status_idle'), 'class' => 'bg-warning', 'dot' => 'bg-warning'];
        }

        return ['label' => __('app.user.devices.status_parked'), 'class' => 'bg-info', 'dot' => 'bg-info'];
    }

    private function haversineKm(float $lat1, float $lon1, float $lat2, float $lon2): float
    {
        $earthRadius = 6371;
        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);
        $a = sin($dLat / 2) ** 2
            + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLon / 2) ** 2;

        return $earthRadius * 2 * atan2(sqrt($a), sqrt(1 - $a));
    }
}
