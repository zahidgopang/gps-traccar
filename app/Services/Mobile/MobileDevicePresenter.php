<?php

namespace App\Services\Mobile;

use App\Models\Device;
use App\Services\DeviceSubscriptionService;
use App\Services\UserDashboardService;

class MobileDevicePresenter
{
    public function __construct(
        private DeviceSubscriptionService $subscriptions,
        private UserDashboardService $dashboard,
    ) {}

    /**
     * @return array<string, mixed>
     */
    public function listItem(Device $device, ?\Illuminate\Support\Collection $alertDeviceIds = null): array
    {
        $latest = $device->latestLocation;
        $status = $this->dashboard->resolveDeviceStatus($device, $alertDeviceIds);
        $sub = $this->subscriptions->statusLabel($device);

        return [
            'id' => $device->id,
            'name' => $device->name,
            'imei' => $device->imei,
            'device_type' => $device->device_type,
            'vehicle_type' => $device->vehicle_type ?? null,
            'status' => $status['label'],
            'status_key' => $this->statusKey($status['label']),
            'live_status' => $status['label'],
            'speed' => $latest ? (float) ($latest->speed ?? 0) : null,
            'subscription_status' => $sub['label'],
            'subscription_active' => $sub['active'],
            'last_update' => $latest?->recorded_at?->toIso8601String(),
            'battery' => $latest?->battery_level,
        ];
    }

    /**
     * @return array<string, mixed>
     */
    public function detail(Device $device, ?\Illuminate\Support\Collection $alertDeviceIds = null): array
    {
        return array_merge($this->listItem($device, $alertDeviceIds), [
            'vehicle_name' => $device->vehicle_name ?? null,
            'vehicle_number' => $device->vehicle_number ?? null,
            'description' => $device->description,
        ]);
    }

    /**
     * @return array<string, mixed>|null
     */
    public function livePosition(Device $device): ?array
    {
        $latest = $device->latestLocation;

        if (! $latest) {
            return null;
        }

        $status = $this->dashboard->resolveDeviceStatus($device);

        return [
            'lat' => (float) $latest->lat,
            'lng' => (float) $latest->lng,
            'speed' => (float) ($latest->speed ?? 0),
            'ignition' => (bool) $latest->ignition,
            'heading' => (float) ($latest->heading ?? 0),
            'battery' => $latest->battery_level,
            'gsm_signal' => $latest->gsm_signal,
            'satellites' => $latest->satellites,
            'address' => null,
            'last_update' => $latest->recorded_at?->toIso8601String(),
            'status' => $status['label'],
            'status_key' => $this->statusKey($status['label']),
        ];
    }

    private function statusKey(string $label): string
    {
        $normalized = strtolower($label);

        return match (true) {
            str_contains($normalized, 'mov') => 'moving',
            str_contains($normalized, 'park') => 'parked',
            str_contains($normalized, 'idle') => 'idle',
            str_contains($normalized, 'offline') => 'offline',
            str_contains($normalized, 'alert') => 'alert',
            str_contains($normalized, 'block') => 'blocked',
            default => 'unknown',
        };
    }
}
