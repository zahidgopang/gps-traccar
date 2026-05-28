<?php

namespace App\Services\Mobile;

use App\Models\Device;
use App\Services\DeviceSubscriptionService;

class MobileDevicePresenter
{
    public function __construct(
        private DeviceSubscriptionService $subscriptions,
        private MobileMapStatusResolver $mapStatus,
    ) {}

    /**
     * @return array<string, mixed>
     */
    public function listItem(Device $device, ?\Illuminate\Support\Collection $alertDeviceIds = null): array
    {
        $latest = $device->latestLocation;
        $map = $this->mapStatus->resolve($latest, $device);
        $sub = $this->subscriptions->statusLabel($device);

        return [
            'id' => $device->id,
            'name' => $device->name,
            'imei' => $device->imei,
            'device_type' => $device->device_type,
            'vehicle_type' => $device->vehicle_type ?? null,
            'status' => $map['label'],
            'status_key' => $map['key'],
            'live_status' => $map['label'],
            'is_online' => $this->mapStatus->isRecentlyOnline($latest),
            'speed' => $latest ? (float) ($latest->speed ?? 0) : null,
            'subscription_status' => $sub['label'],
            'subscription_active' => $sub['active'],
            'last_update' => app_datetime_api($latest?->recorded_at),
            'last_update_display' => app_datetime_format($latest?->recorded_at),
            'battery' => $latest?->battery_level,
            'gsm_signal' => $latest?->gsm_signal,
            'lat' => $latest ? (float) $latest->lat : null,
            'lng' => $latest ? (float) $latest->lng : null,
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

        $map = $this->mapStatus->resolve($latest, $device);

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
            'last_update' => app_datetime_api($latest->recorded_at),
            'last_update_display' => app_datetime_format($latest->recorded_at),
            'status' => $map['label'],
            'status_key' => $map['key'],
            'is_online' => $this->mapStatus->isRecentlyOnline($latest),
        ];
    }
}
