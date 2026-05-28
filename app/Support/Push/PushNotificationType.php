<?php

namespace App\Support\Push;

/**
 * FCM data.type values consumed by the Flutter app.
 */
final class PushNotificationType
{
    public const VEHICLE_STARTED = 'vehicle_started';

    public const VEHICLE_STOPPED = 'vehicle_stopped';

    public const VEHICLE_MOVING = 'vehicle_moving';

    public const VEHICLE_PARKED = 'vehicle_parked';

    public const GEOFENCE_ENTER = 'geofence_enter';

    public const GEOFENCE_EXIT = 'geofence_exit';

    public const OVERSPEED = 'overspeed';

    public const DEVICE_OFFLINE = 'device_offline';

    public const DEVICE_ONLINE = 'device_online';

    /** @return array<int, string> */
    public static function all(): array
    {
        return [
            self::VEHICLE_STARTED,
            self::VEHICLE_STOPPED,
            self::VEHICLE_MOVING,
            self::VEHICLE_PARKED,
            self::GEOFENCE_ENTER,
            self::GEOFENCE_EXIT,
            self::OVERSPEED,
            self::DEVICE_OFFLINE,
            self::DEVICE_ONLINE,
        ];
    }

    public static function title(string $type): string
    {
        return match ($type) {
            self::VEHICLE_STARTED => 'Vehicle started',
            self::VEHICLE_STOPPED => 'Vehicle stopped',
            self::VEHICLE_MOVING => 'Vehicle moving',
            self::VEHICLE_PARKED => 'Vehicle parked',
            self::GEOFENCE_ENTER => 'Geofence enter',
            self::GEOFENCE_EXIT => 'Geofence exit',
            self::OVERSPEED => 'Overspeed',
            self::DEVICE_OFFLINE => 'Device offline',
            self::DEVICE_ONLINE => 'Device online',
            default => 'Fleet alert',
        };
    }
}
