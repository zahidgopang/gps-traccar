<?php

namespace App\Services\Mobile;

use App\Models\Device;
use App\Models\DeviceLocation;
use App\Services\UserDashboardService;

/**
 * Matches public/js/device-map-tracker.js resolveVehicleStatus():
 * status from latest point metrics, not the 5-minute "online" cutoff.
 */
class MobileMapStatusResolver
{
    public const IDLE_SPEED_KMH = 0.5;

    /**
     * @return array{label: string, key: string}
     */
    public function resolve(?DeviceLocation $latest, Device $device): array
    {
        if ($device->status === 'blocked') {
            return [
                'label' => (string) __('app.common.blocked'),
                'key' => 'blocked',
            ];
        }

        if ($device->status === 'inactive') {
            return [
                'label' => (string) __('app.common.inactive'),
                'key' => 'offline',
            ];
        }

        if (! $latest) {
            return [
                'label' => (string) __('app.common.offline'),
                'key' => 'offline',
            ];
        }

        $speed = (float) ($latest->speed ?? 0);

        if ($latest->power_cut) {
            return [
                'label' => (string) __('app.map.status_power_cut'),
                'key' => 'alert',
            ];
        }

        if ($latest->panic) {
            return [
                'label' => (string) __('app.map.status_sos'),
                'key' => 'alert',
            ];
        }

        if ($speed > UserDashboardService::MOVING_SPEED_KMH) {
            return [
                'label' => (string) __('app.map.status_running'),
                'key' => 'moving',
            ];
        }

        if ($speed > self::IDLE_SPEED_KMH) {
            return [
                'label' => (string) __('app.user.devices.status_idle'),
                'key' => 'idle',
            ];
        }

        if ($latest->ignition) {
            return [
                'label' => (string) __('app.map.status_stopped'),
                'key' => 'stopped',
            ];
        }

        return [
            'label' => (string) __('app.map.status_parked'),
            'key' => 'parked',
        ];
    }

    public function isRecentlyOnline(?DeviceLocation $latest): bool
    {
        if (! $latest || ! $latest->recorded_at) {
            return false;
        }

        return $latest->recorded_at >= now()->subMinutes(UserDashboardService::ONLINE_MINUTES);
    }

    /**
     * Fleet counts aligned with web device map (status from last GPS, not 5-minute cutoff).
     *
     * @param  \Illuminate\Support\Collection<int, Device>  $devices
     * @return array{running: int, parked: int, idle: int, stopped: int, offline: int, alert: int, with_gps: int}
     */
    public function fleetCounts(\Illuminate\Support\Collection $devices): array
    {
        $counts = [
            'running' => 0,
            'parked' => 0,
            'idle' => 0,
            'stopped' => 0,
            'offline' => 0,
            'alert' => 0,
            'with_gps' => 0,
        ];

        foreach ($devices as $device) {
            $latest = $device->latestLocation;
            $map = $this->resolve($latest, $device);

            if ($map['key'] !== 'offline') {
                $counts['with_gps']++;
            }

            match ($map['key']) {
                'moving' => $counts['running']++,
                'parked' => $counts['parked']++,
                'idle' => $counts['idle']++,
                'stopped' => $counts['stopped']++,
                'alert' => $counts['alert']++,
                default => $counts['offline']++,
            };
        }

        return $counts;
    }
}
