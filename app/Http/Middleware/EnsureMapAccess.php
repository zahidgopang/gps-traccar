<?php

namespace App\Http\Middleware;

use App\Services\DeviceMapAccessService;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureMapAccess
{
    public function __construct(
        private DeviceMapAccessService $mapAccess
    ) {}

    public function handle(Request $request, Closure $next): Response
    {
        $token = $request->route('token');

        if (! $token || ! $request->user()) {
            abort(404);
        }

        if ($request->routeIs('user.device.map') || $request->routeIs('admin.device.map')) {
            $this->mapAccess->activateMapPage($token, $request->user());
        } else {
            $this->mapAccess->assertMapApiAccess($token, $request->user());
        }

        return $next($request);
    }
}
