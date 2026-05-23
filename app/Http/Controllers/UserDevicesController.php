<?php

namespace App\Http\Controllers;

use App\Models\Device;
use App\Services\DeviceSubscriptionService;
use App\Services\Traccar\TraccarTrackingGate;
use App\Services\Tracking\DevicePositionLoader;
use App\Services\UserDashboardService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class UserDevicesController extends Controller
{
    /**
     * Display a listing of user devices.
     */
    public function index(UserDashboardService $dashboard)
    {
        try {
            $user = Auth::user();
            $devices = $user
                ->trackerDevicesQuery()
                ->with(['subscription'])
                ->orderByDesc('id')
                ->get();

            $devices = app(TraccarTrackingGate::class)->filterTrackable($user, $devices, requireSubscription: false);

            app(DevicePositionLoader::class)->attachLatestToMany($devices);

            $alertDeviceIds = $dashboard->alertDeviceIds($devices);

            return view('user.devices', array_merge(
                $dashboard->getDevicePageStats($devices),
                [
                    'devices' => $devices,
                    'alertDeviceIds' => $alertDeviceIds,
                    'dashboardService' => $dashboard,
                    'subscriptionService' => app(DeviceSubscriptionService::class),
                ]
            ));
        } catch (\Exception $e) {
            Log::error('Error loading devices: ' . $e->getMessage());

            return view('user.devices', [
                'devices' => collect(),
                'totalDevices' => 0,
                'activeDevices' => 0,
                'inactiveDevices' => 0,
                'blockedDevices' => 0,
                'onlineNow' => 0,
                'running' => 0,
                'parked' => 0,
                'alerts' => 0,
                'alertDeviceIds' => collect(),
                'dashboardService' => $dashboard,
            ]);
        }
    }

    /**
     * Update the specified device.
     */
    public function update(Request $request, Device $device)
    {
        Log::info('Update request for device: ' . $device->id, $request->all());

        if (! app(\App\Services\Traccar\TraccarDeviceAccessService::class)->userCanAccessDevice(Auth::user(), $device)) {
            // Log unauthorized update attempt
            activity('device')
                ->performedOn($device)
                ->causedBy(Auth::user())
                ->withProperties([
                    'action' => 'unauthorized_update_attempt',
                    'device_id' => $device->id,
                    'device_owner' => $device->user_id,
                    'attempted_by' => Auth::id(),
                    'ip' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                ])
                ->log('Unauthorized device update attempt');

            Log::warning('Unauthorized update attempt for device: ' . $device->id . ' by user: ' . Auth::id());
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized action.'
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:100',
            'device_type' => 'required|in:car,truck,bike,personal,other',
            'model' => 'nullable|string|max:50',
            'description' => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            Log::error('Update validation failed: ', $validator->errors()->toArray());

            // Log update validation failed
            activity('device')
                ->performedOn($device)
                ->causedBy(Auth::user())
                ->withProperties([
                    'action' => 'update_device_validation_failed',
                    'errors' => $validator->errors()->toArray(),
                    'device_id' => $device->id,
                    'ip' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                ])
                ->log('Device update validation failed');

            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Store old values for logging
            $oldValues = $device->only(['name', 'device_type', 'model', 'description']);

            $device->fill($request->only(['name', 'device_type', 'model', 'description']));
            $device->save();

            // Log successful update activity
            activity('device')
                ->performedOn($device)
                ->causedBy(Auth::user())
                ->withProperties([
                    'action' => 'update_device',
                    'device_id' => $device->id,
                    'old_values' => $oldValues,
                    'new_values' => $device->only(['name', 'device_type', 'model', 'description']),
                    'ip' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                ])
                ->log('User updated device: ' . $device->name);

            Log::info('Device updated successfully: ', $device->toArray());

            return response()->json([
                'success' => true,
                'message' => 'Device updated successfully!',
                'device' => $device
            ]);

        } catch (\Exception $e) {
            Log::error('Device update error: ' . $e->getMessage());

            // Log update error activity
            activity('device')
                ->performedOn($device)
                ->causedBy(Auth::user())
                ->withProperties([
                    'action' => 'update_device_error',
                    'error' => $e->getMessage(),
                    'device_id' => $device->id,
                    'ip' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                ])
                ->log('Failed to update device');

            return response()->json([
                'success' => false,
                'message' => 'Failed to update device. Please try again.'
            ], 500);
        }
    }

    /**
     * Get device details for edit modal.
     */
    public function getDevice(Device $device)
    {
        if ($device->user_id !== Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized action.'
            ], 403);
        }
        return response()->json([
            'success' => true,
            'device' => $device
        ]);
    }

}
