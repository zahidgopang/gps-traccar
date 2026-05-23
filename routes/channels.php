<?php

use Illuminate\Support\Facades\Broadcast;
use App\Models\Device;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

Broadcast::channel('device.{deviceId}', function ($user, $deviceId) {
    // TEMP: allow all authenticated users (useful during dev)
    // return true;

    // Recommended: allow only the owner of the device to listen.
    // Uncomment below and ensure Device model has user_id or owner relationship.
    //
    // $device = Device::find($deviceId);
    // return $device && $user->id === $device->user_id;

    // If you use a relationship method: $user->devices()->where('id', $deviceId)->exists()
    return true;
});
