<?php

namespace App\Http\Controllers;

use App\Http\Concerns\ResolvesMapDevice;
use App\Contracts\Geofences\GeofenceStoreInterface;
use App\Models\Device;
use App\Models\Geofence;
use App\Services\DeviceAccessService;
use App\Services\Traccar\TraccarGeofenceManager;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GeofenceController extends Controller
{
    use ResolvesMapDevice;

    public function __construct(
        private DeviceAccessService $access,
        private GeofenceStoreInterface $geofenceStore,
        private TraccarGeofenceManager $geofences,
    ) {}

    private function authorizeDevice(string $deviceToken): Device
    {
        if ($this->isAdminMapRequest()) {
            return $this->findMapDevice($deviceToken);
        }

        $device = $this->findMapDevice($deviceToken);

        $check = $this->access->evaluate(Auth::user(), $device);

        if (! $check['allowed']) {
            abort(403, $check['message']);
        }

        return $device;
    }

    private function authorizeGeofence(int $id): Geofence
    {
        $geofence = Geofence::with(['device.subscription', 'device.user'])->findOrFail($id);

        if ($this->isAdminMapRequest()) {
            return $geofence;
        }

        if ($geofence->device?->user_id !== Auth::id()) {
            abort(403, 'Unauthorized');
        }

        $check = $this->access->evaluate(Auth::user(), $geofence->device);

        if (! $check['allowed']) {
            abort(403, $check['message']);
        }

        return $geofence;
    }

    public function indexJson(string $token)
    {
        $device = $this->authorizeDevice($token);

        return $this->geofenceStore->forDevice($device)->map(function ($g) {
            return [
                'id' => $g->id,
                'name' => $g->name,
                'type' => $g->type,
                'coords' => is_string($g->coords ?? null) ? json_decode($g->coords, true) : ($g->coords ?? null),
                'center' => is_string($g->center ?? null) ? json_decode($g->center, true) : ($g->center ?? null),
                'radius' => $g->radius ?? null,
            ];
        });
    }

    public function store(Request $req, string $token)
    {
        $device = $this->authorizeDevice($token);

        $validated = $req->validate([
            'name' => 'required|string|max:255',
            'type' => 'required|in:polygon,circle',
            'coords' => 'required_if:type,polygon|array|min:3',
            'coords.*' => 'array|size:2',
            'center' => 'required_if:type,circle|array|size:2',
            'radius' => 'required_if:type,circle|integer|min:1',
        ]);

        try {
            $geofence = $this->geofences->create($device, $validated);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Could not save geofence: '.$e->getMessage(),
            ], 422);
        }

        return response()->json([
            'success' => true,
            'id' => $geofence->id,
            'name' => $geofence->name,
            'type' => $geofence->type,
            'coords' => $geofence->coords ? json_decode($geofence->coords, true) : null,
            'center' => $geofence->center ? json_decode($geofence->center, true) : null,
            'radius' => $geofence->radius,
        ]);
    }

    public function destroy($id)
    {
        $geofence = $this->authorizeGeofence($id);
        $this->geofences->delete($geofence);

        return response()->json(['success' => true, 'message' => 'Geofence removed']);
    }

    public function update(Request $req, $id)
    {
        $g = $this->authorizeGeofence($id);

        $this->geofences->update($g, [
            'name' => $req->name ?? '',
            'center' => $req->center ?? null,
            'radius' => $req->radius ?? null,
            'coords' => $req->coords ?? null,
        ]);

        return response()->json(['success' => true]);
    }
}
