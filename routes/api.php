<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\DeviceDataController;
use App\Http\Controllers\Api\UserDeviceController;

Route::post('/device/data', [DeviceDataController::class, 'receive']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/my/devices', [UserDeviceController::class, 'list']);
    Route::get('/device/{imei}/latest', [UserDeviceController::class, 'latest']);
    Route::get('/device/{imei}/history', [UserDeviceController::class, 'history']);
});
