<?php

return [

    'name' => env('APP_BRAND_NAME', env('APP_NAME', 'FalconEyeGPS')),

    /** Horizontal logo — light backgrounds (navbar, auth on white). */
    'logo' => 'branding/web/logo-horizontal.png',

    /** White-text / light logo for dark nav, sidebar, splash. */
    'logo_dark' => 'branding/web/logo-horizontal-dark.png',

    /** Falcon pin only (no text). */
    'logo_icon' => 'branding/web/icon-pin.png',

    /** Splash / centered mobile intro. */
    'logo_splash' => 'branding/mobile/splash-logo-dark.png',

    /** App store / launcher master (1024×1024). */
    'app_icon' => 'branding/app-icon/icon-1024.png',

    'favicon' => 'branding/favicon/favicon.ico',

    'favicon_png' => 'branding/favicon/favicon-32x32.png',

    'apple_touch_icon' => 'branding/favicon/apple-touch-icon.png',

    'theme_color' => '#0A0F2D',

    'seo' => [
        'default_title' => 'FalconEyeGPS — Live GPS & Fleet Tracking',
        'default_description' => 'FalconEyeGPS delivers real-time GPS tracking, vehicle monitoring, fleet management, live location, route history, and geofencing for businesses and drivers.',
        'keywords' => 'GPS Tracking, Vehicle Tracking, Fleet Management, Live Tracking, FalconEyeGPS, Real-time GPS, Car Tracking, Fleet Monitoring',
        'admin_description' => 'FalconEyeGPS admin panel — manage users, devices, subscriptions, and monitor fleet tracking in real time.',
        'admin_keywords' => 'FalconEyeGPS Admin, Fleet Management, Vehicle Tracking System, GPS Device Management',
    ],

];
