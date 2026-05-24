<?php

namespace App\Support\Tracking;

use App\Models\DeviceLocation;

final class DeviceLocationPayload
{
    public static function fromDeviceLocation(DeviceLocation $location): array
    {
        return [
            'lat' => (float) $location->lat,
            'lng' => (float) $location->lng,
            'speed' => (float) ($location->speed ?? 0),
            'heading' => (float) ($location->heading ?? 0),
            'battery' => $location->battery_level,
            'battery_level' => $location->battery_level,
            'ignition' => (bool) $location->ignition,
            'acc' => (bool) ($location->acc ?? false),
            'gsm_signal' => $location->gsm_signal,
            'gps_signal' => $location->gps_signal,
            'satellites' => $location->satellites,
            'odometer' => $location->odometer,
            'power_cut' => (bool) $location->power_cut,
            'panic' => (bool) $location->panic,
            'recorded_at' => $location->recorded_at?->toDateTimeString(),
            'timestamp' => $location->recorded_at?->toDateTimeString(),
            'position_id' => (int) ($location->id ?? 0),
            'online' => true,
        ];
    }
}
