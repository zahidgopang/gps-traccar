<?php

return [
    'stopped_speed_kmh' => (float) env('TRACKING_STOPPED_SPEED', 5),
    'slow_speed_max_kmh' => (float) env('TRACKING_SLOW_SPEED_MAX', 30),
    'overspeed_kmh' => (float) env('TRACKING_OVERSPEED', 80),
    'low_battery_percent' => (int) env('TRACKING_LOW_BATTERY', 20),
    'event_cooldown_seconds' => (int) env('TRACKING_EVENT_COOLDOWN', 300),

    /** Minutes without GPS before a device is treated as offline for push alerts. */
    'online_minutes' => (int) env('TRACKING_ONLINE_MINUTES', 5),

    /** When false, rely on Traccar tc_events (geofenceEnter/Exit) only; when true, Laravel also detects zones on position updates. */
    'laravel_geofence_detection' => filter_var(env('TRACKING_LARAVEL_GEOFENCE', true), FILTER_VALIDATE_BOOL),
];
