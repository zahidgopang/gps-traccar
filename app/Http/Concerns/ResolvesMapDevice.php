<?php

namespace App\Http\Concerns;

use App\Models\Device;
use App\Services\DeviceMapAccessService;
use Illuminate\Http\Request;

trait ResolvesMapDevice
{
    protected function isAdminMapRequest(?Request $request = null): bool
    {
        return app(DeviceMapAccessService::class)->isAdminMapRequest($request);
    }

    protected function findMapDevice(string $token): Device
    {
        return app(DeviceMapAccessService::class)->assertMapApiAccess($token, auth()->user());
    }

    /**
     * @return array<string, string>
     */
    protected function mapApiRoutes(Device $device, string $mapToken): array
    {
        $token = ['token' => $mapToken];

        if ($this->isAdminMapRequest()) {
            return [
                'live' => route('admin.device.live.json', $token),
                'history' => route('admin.device.history.json', $token),
                'summary' => route('admin.device.summary.json', $token),
                'alerts' => route('admin.device.alerts.json', $token),
                'reverseGeocode' => route('admin.device.reverse.geocode', $token),
                'geofences' => route('admin.device.geofences.json', $token),
                'geofencesSave' => route('admin.device.geofences.save', $token),
                'geofenceDestroy' => url('/admin/geofence'),
                'geofenceUpdate' => url('/admin/geofence'),
                'accessDeniedRedirect' => route('admin.locations.index'),
            ];
        }

        return [
            'live' => route('user.device.live.json', $token),
            'history' => route('user.device.history.json', $token),
            'summary' => route('user.device.summary.json', $token),
            'alerts' => route('user.device.alerts.json', $token),
            'reverseGeocode' => route('user.device.reverse.geocode', $token),
            'geofences' => route('user.device.geofences.json', $token),
            'geofencesSave' => route('user.device.geofences.save', $token),
            'geofenceDestroy' => url('/user/geofence'),
            'geofenceUpdate' => url('/user/geofence'),
            'accessDeniedRedirect' => route('user.devices.index'),
        ];
    }
}
