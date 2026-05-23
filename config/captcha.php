<?php

return [
    'secret' => env('NOCAPTCHA_SECRET'),
    'sitekey' => env('NOCAPTCHA_SITEKEY'),

    // Optional: Default settings
    'options' => [
        'timeout' => 30,
        'score_threshold' => 0.5,
    ],

    // For JavaScript usage
    'v3' => [
        'action' => 'register', // Default action name
        'sitekey' => env('NOCAPTCHA_SITEKEY'),
    ],
];
