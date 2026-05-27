<?php

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withSchedule(function (Schedule $schedule): void {
        if (config('traccar.broadcast_positions', true)) {
            $schedule->command('traccar:broadcast-positions')
                ->everyFiveSeconds()
                ->withoutOverlapping(2);
        }
    })
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->alias([
            'map.access' => \App\Http\Middleware\EnsureMapAccess::class,
            'maps.tracking' => \App\Http\Middleware\EnsureMapTrackingAccess::class,
            'user.active' => \App\Http\Middleware\EnsureActiveUser::class,
            'tracker.access' => \App\Http\Middleware\EnsureTrackerAccess::class,
            'permission' => \App\Http\Middleware\EnsurePermission::class,
            'panel' => \App\Http\Middleware\EnsurePanelAccess::class,
        ]);

        $middleware->appendToGroup('web', [
            \App\Http\Middleware\SetLocale::class,
            \App\Http\Middleware\RestrictScrapers::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })
    ->withBroadcasting(
        channels: __DIR__ . '/../routes/channels.php'
    )
    ->create();
