<?php

namespace App\Services\Traccar;

use App\Models\DeviceLocation;
use App\Support\Traccar\TraccarAttributes;
use App\Support\Traccar\TraccarSpeed;
use Carbon\Carbon;
use stdClass;

class TraccarPositionMapper
{
    public function toDeviceLocation(stdClass|array $row, int $laravelDeviceId): DeviceLocation
    {
        $data = is_array($row) ? $row : (array) $row;
        $attrs = TraccarAttributes::decode($data['attributes'] ?? null);
        $fields = TraccarAttributes::toPositionFields($attrs);
        $fixtime = $data['fixtime'] ?? $data['devicetime'] ?? $data['servertime'] ?? now();

        $location = new DeviceLocation([
            'device_id' => $laravelDeviceId,
            'lat' => (float) ($data['latitude'] ?? 0),
            'lng' => (float) ($data['longitude'] ?? 0),
            'speed' => TraccarSpeed::knotsToKmh((float) ($data['speed'] ?? 0)),
            'heading' => (float) ($data['course'] ?? 0),
            'battery_level' => $fields['battery_level'],
            'gps_fix' => $fields['gps_fix'],
            'recorded_at' => Carbon::parse($fixtime),
            'ignition' => $fields['ignition'],
            'acc' => $fields['acc'],
            'gsm_signal' => $fields['gsm_signal'],
            'gps_signal' => $fields['gps_signal'],
            'satellites' => $fields['satellites'],
            'odometer' => $fields['odometer'],
            'power_cut' => $fields['power_cut'],
            'panic' => $fields['panic'],
        ]);

        $location->id = (int) ($data['id'] ?? 0);
        $location->exists = true;

        return $location;
    }
}
