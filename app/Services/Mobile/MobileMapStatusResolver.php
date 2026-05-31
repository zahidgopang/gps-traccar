<?php

namespace App\Services\Mobile;

use App\Models\Device;
use App\Models\DeviceLocation;

/**
 * Canonical vehicle status for mobile API, web live map, and fleet lists.
 *
 * Connectivity tiers (from last GPS fix):
 * - 0–10 min: show motion status (Running / Idle / Stopped)
 * - 10–30 min: Delayed / No Recent Data
 * - >30 min or no GPS: Offline (with last-known telemetry)
 */
class MobileMapStatusResolver
{
    public const RECENT_MINUTES = 10;

    public const OFFLINE_MINUTES = 30;

    /**
     * @return array{
     *     label: string,
     *     key: string,
     *     connectivity_tier: string,
     *     last_known_status_key: ?string,
     *     last_known_status: ?string,
     *     last_known_speed: ?float,
     *     last_known_ignition: ?bool
     * }
     */
    public function resolve(?DeviceLocation $latest, Device $device): array
    {
        $lastKnown = $this->motionStatus($latest);

        if ($device->status === 'blocked') {
            return $this->pack(
                key: 'blocked',
                label: (string) __('app.common.blocked'),
                tier: 'offline',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        if ($device->status === 'inactive') {
            return $this->pack(
                key: 'offline',
                label: (string) __('app.common.inactive'),
                tier: 'offline',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        if (! $latest || ! $latest->recorded_at) {
            return $this->pack(
                key: 'offline',
                label: (string) __('app.map.status_offline'),
                tier: 'offline',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        $minutes = $this->minutesSinceUpdate($latest);

        if ($minutes > self::OFFLINE_MINUTES) {
            return $this->pack(
                key: 'offline',
                label: (string) __('app.map.status_offline'),
                tier: 'offline',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        if ($minutes > self::RECENT_MINUTES) {
            return $this->pack(
                key: 'delayed',
                label: (string) __('app.map.status_delayed'),
                tier: 'delayed',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        if ($latest->power_cut) {
            return $this->pack(
                key: 'alert',
                label: (string) __('app.map.status_power_cut'),
                tier: 'recent',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        if ($latest->panic) {
            return $this->pack(
                key: 'alert',
                label: (string) __('app.map.status_sos'),
                tier: 'recent',
                lastKnown: $lastKnown,
                latest: $latest,
            );
        }

        return $this->pack(
            key: $lastKnown['key'],
            label: $lastKnown['label'],
            tier: 'recent',
            lastKnown: $lastKnown,
            latest: $latest,
        );
    }

    /**
     * Motion status from the last GPS fix (ignores connectivity age).
     *
     * @return array{key: string, label: string}|null
     */
    public function motionStatus(?DeviceLocation $latest): ?array
    {
        if (! $latest) {
            return null;
        }

        $speed = (float) ($latest->speed ?? 0);

        if ($speed > 0) {
            return [
                'key' => 'moving',
                'label' => (string) __('app.map.status_running'),
            ];
        }

        if ($latest->ignition) {
            return [
                'key' => 'idle',
                'label' => (string) __('app.user.devices.status_idle'),
            ];
        }

        return [
            'key' => 'stopped',
            'label' => (string) __('app.map.status_stopped'),
        ];
    }

    public function isRecentlyOnline(?DeviceLocation $latest): bool
    {
        if (! $latest || ! $latest->recorded_at) {
            return false;
        }

        return $this->minutesSinceUpdate($latest) <= self::RECENT_MINUTES;
    }

    public function minutesSinceUpdate(?DeviceLocation $latest): ?int
    {
        if (! $latest?->recorded_at) {
            return null;
        }

        return (int) $latest->recorded_at->diffInMinutes(now());
    }

    /**
     * @param  \Illuminate\Support\Collection<int, Device>  $devices
     * @return array{running: int, parked: int, idle: int, stopped: int, delayed: int, offline: int, alert: int, with_gps: int}
     */
    public function fleetCounts(\Illuminate\Support\Collection $devices): array
    {
        $counts = [
            'running' => 0,
            'parked' => 0,
            'idle' => 0,
            'stopped' => 0,
            'delayed' => 0,
            'offline' => 0,
            'alert' => 0,
            'with_gps' => 0,
        ];

        foreach ($devices as $device) {
            $latest = $device->latestLocation;
            $map = $this->resolve($latest, $device);

            if ($latest) {
                $counts['with_gps']++;
            }

            match ($map['key']) {
                'moving' => $counts['running']++,
                'idle' => $counts['idle']++,
                'stopped' => $counts['stopped']++,
                'delayed' => $counts['delayed']++,
                'alert' => $counts['alert']++,
                default => $counts['offline']++,
            };
        }

        return $counts;
    }

    /**
     * @param  array{key: string, label: string}|null  $lastKnown
     * @return array{
     *     label: string,
     *     key: string,
     *     connectivity_tier: string,
     *     last_known_status_key: ?string,
     *     last_known_status: ?string,
     *     last_known_speed: ?float,
     *     last_known_ignition: ?bool
     * }
     */
    private function pack(
        string $key,
        string $label,
        string $tier,
        ?array $lastKnown,
        ?DeviceLocation $latest,
    ): array {
        return [
            'key' => $key,
            'label' => $label,
            'connectivity_tier' => $tier,
            'last_known_status_key' => $lastKnown['key'] ?? null,
            'last_known_status' => $lastKnown['label'] ?? null,
            'last_known_speed' => $latest !== null ? (float) ($latest->speed ?? 0) : null,
            'last_known_ignition' => $latest !== null ? (bool) $latest->ignition : null,
        ];
    }
}
