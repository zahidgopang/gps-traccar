<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->alias([
            'map.access' => \App\Http\Middleware\EnsureMapAccess::class,
            'user.active' => \App\Http\Middleware\EnsureActiveUser::class,
            'tracker.access' => \App\Http\Middleware\EnsureTrackerAccess::class,
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
