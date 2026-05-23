<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Device;
use App\Models\User;
use App\Services\AdminAuditService;
use Illuminate\Http\Request;

class DeviceController extends Controller
{
    public function __construct(
        private AdminAuditService $audit,
    ) {}

    public function index(Request $request)
    {
        $q = Device::query()->with('user')->orderByDesc('id');

        if ($search = $request->query('q')) {
            $q->where(function ($w) use ($search) {
                $w->whereImeiLike("%{$search}%")
                    ->orWhere('name', 'like', "%{$search}%");
            });
        }

        $devices = $q->paginate(15)->withQueryString();
        app(\App\Services\Tracking\DevicePositionLoader::class)->attachLatestToMany($devices->getCollection());

        return view('admin.devices.index', compact('devices'));
    }

    public function create()
    {
        $users = User::orderBy('name')->get();

        return view('admin.devices.create', compact('users'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'imei' => 'required|string|unique:tc_devices,uniqueid',
            'name' => 'nullable|string|max:255',
            'user_id' => 'nullable|exists:tc_users,id',
            'device_type' => 'required|in:car,truck,bike,personal,other',
            'status' => 'required|in:active,inactive,blocked',
        ]);

        $device = Device::create([
            'uniqueid' => $data['imei'],
            'name' => $data['name'] ?: $data['imei'],
            'user_id' => $data['user_id'] ?? null,
            'device_type' => $data['device_type'],
            'status' => $data['status'],
        ]);

        $this->audit->logCreated($device, "device {$device->imei}", [
            'name' => $device->name,
            'device_type' => $device->device_type,
            'user_id' => $device->user_id,
            'status' => $device->status,
        ]);

        return redirect()->route('admin.devices.index')->with('success', 'Device created successfully.');
    }

    public function edit(Device $device)
    {
        $users = User::orderBy('name')->get();

        return view('admin.devices.edit', compact('device', 'users'));
    }

    public function update(Request $request, Device $device)
    {
        $data = $request->validate([
            'imei' => 'required|string|unique:tc_devices,uniqueid,' . $device->id,
            'name' => 'nullable|string|max:255',
            'user_id' => 'nullable|exists:tc_users,id',
            'device_type' => 'required|in:car,truck,bike,personal,other',
            'status' => 'required|in:active,inactive,blocked',
        ]);

        $device->update([
            'uniqueid' => $data['imei'],
            'name' => $data['name'] ?: $data['imei'],
            'user_id' => $data['user_id'] ?? null,
            'device_type' => $data['device_type'],
            'status' => $data['status'],
        ]);

        $this->audit->logUpdated($device, "device {$device->imei}", $data);

        return redirect()->route('admin.devices.index')->with('success', 'Device updated successfully.');
    }

    public function destroy(Device $device)
    {
        $imei = $device->imei;
        $device->delete();

        $this->audit->log('deleted', "Deleted device {$imei}");

        return redirect()->route('admin.devices.index')->with('success', 'Device deleted successfully.');
    }

    public function toggleStatus(Request $request, Device $device)
    {
        if ($device->status === 'blocked') {
            return response()->json([
                'success' => false,
                'message' => 'This device is blocked. Edit the device to change status.',
            ], 422);
        }

        $validated = $request->validate([
            'status' => 'required|in:active,inactive',
        ]);

        $device->update(['status' => $validated['status']]);

        $label = $validated['status'] === 'active' ? 'Active' : 'Inactive';

        $this->audit->logUpdated($device, "device {$device->imei} status", [
            'status' => $device->status,
        ]);

        return response()->json([
            'success' => true,
            'status' => $device->status,
            'label' => $label,
            'message' => "Device is now {$label}.",
        ]);
    }
}
