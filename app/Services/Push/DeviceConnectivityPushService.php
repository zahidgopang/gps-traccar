<?php

namespace App\Services\Push;

use App\Contracts\Tracking\PositionReaderInterface;
use App\Models\Device;
use App\Support\Push\PushNotificationType;
use Carbon\Carbon;

class DeviceConnectivityPushService
{
    public function __construct(
        private PositionReaderInterface $positions,
        private PushNotificationDispatcher $dispatcher,
    ) {}

    public function onPositionReceived(Device $device): void
    {
        $cacheKey = $this->cacheKey($device->id);
        $wasOnline = (bool) cache()->get($cacheKey, false);

        if (! $wasOnline) {
            $this->dispatcher->forConnectivity(
                $device,
                PushNotificationType::DEVICE_ONLINE,
                sprintf('%s is back online and reporting GPS.', $device->name),
            );
        }

        cache()->put($cacheKey, true, now()->addHours(24));
    }

    public function checkDevice(Device $device): void
    {
        $onlineMinutes = (int) config('tracking.online_minutes', 5);
        $latest = $this->positions->latestForDevice($device);
        $isOnline = $latest?->recorded_at instanceof Carbon
            && $latest->recorded_at->greaterThan(now()->subMinutes($onlineMinutes));

        $cacheKey = $this->cacheKey($device->id);
        $wasOnline = (bool) cache()->get($cacheKey, false);

        if ($wasOnline && ! $isOnline) {
            $this->dispatcher->forConnectivity(
                $device,
                PushNotificationType::DEVICE_OFFLINE,
                sprintf('%s has not reported GPS for %d minutes.', $device->name, $onlineMinutes),
            );
            cache()->put($cacheKey, false, now()->addHours(24));

            return;
        }

        if ($isOnline) {
            cache()->put($cacheKey, true, now()->addHours(24));
        }
    }

    private function cacheKey(int $deviceId): string
    {
        return "device.{$deviceId}.push_connectivity";
    }
}
