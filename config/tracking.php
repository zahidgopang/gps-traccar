<?php

return [
    'stopped_speed_kmh' => (float) env('TRACKING_STOPPED_SPEED', 5),
    'slow_speed_max_kmh' => (float) env('TRACKING_SLOW_SPEED_MAX', 30),
    'overspeed_kmh' => (float) env('TRACKING_OVERSPEED', 80),
    'low_battery_percent' => (int) env('TRACKING_LOW_BATTERY', 20),
    'event_cooldown_seconds' => (int) env('TRACKING_EVENT_COOLDOWN', 300),

    /** Minutes with recent GPS before motion status is shown. */
    'recent_minutes' => (int) env('TRACKING_RECENT_MINUTES', 10),

    /** Minutes without GPS before a device is shown as offline in UI. */
    'offline_minutes' => (int) env('TRACKING_OFFLINE_MINUTES', 30),

    /** Minutes without GPS before a device is treated as offline for push alerts. */
    'online_minutes' => (int) env('TRACKING_ONLINE_MINUTES', 30),

    /** When false, rely on Traccar tc_events (geofenceEnter/Exit) only; when true, Laravel also detects zones on position updates. */
    'laravel_geofence_detection' => filter_var(env('TRACKING_LARAVEL_GEOFENCE', true), FILTER_VALIDATE_BOOL),

    /** GSM signal below this percentage triggers a weak-signal warning. */
    'gsm_weak_percent' => (int) env('TRACKING_GSM_WEAK_PERCENT', 25),

    /** GPS signal below this percentage triggers a weak-signal warning. */
    'gps_weak_percent' => (int) env('TRACKING_GPS_WEAK_PERCENT', 30),

    /** Satellite count below this triggers a GPS weak warning. */
    'gps_min_satellites' => (int) env('TRACKING_GPS_MIN_SATELLITES', 4),
];
