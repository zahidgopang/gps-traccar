<?php

namespace App\Http\Controllers\Api\Mobile;

use App\Contracts\Geofences\GeofenceStoreInterface;
use App\Http\Controllers\Controller;
use App\Http\Concerns\ResolvesMobileDevice;
use App\Http\Concerns\RespondsWithMobileJson;
use App\Models\Geofence;
use App\Services\Traccar\TraccarGeofenceLinker;
use App\Services\Traccar\TraccarGeofenceManager;
use Illuminate\Http\Request;

class GeofenceController extends Controller
{
    use ResolvesMobileDevice;
    use RespondsWithMobileJson;

    private const GEOFENCE_CREATION_ENABLED = false;

    public function __construct(
        private GeofenceStoreInterface $geofenceStore,
        private TraccarGeofenceManager $geofences,
        private TraccarGeofenceLinker $linker,
    ) {}

    public function index(Request $request)
    {
        $user = $request->user();
        $devices = $user->trackableDevicesQuery()->get();
        $items = collect();

        foreach ($devices as $device) {
            foreach ($this->geofenceStore->forDevice($device) as $g) {
                $items->push($this->formatGeofence($g, $device->id));
            }
        }

        return $this->mobileSuccess($items->values());
    }

    public function store(Request $request)
    {
        if (! self::GEOFENCE_CREATION_ENABLED) {
            return $this->mobileError('Geofence creation is disabled', 403);
        }

        $validated = $request->validate([
            'device_id' => 'required|integer',
            'name' => 'required|string|max:255',
            'type' => 'required|in:polygon,circle',
            'coords' => 'required_if:type,polygon|array|min:3',
            'coords.*' => 'array|size:2',
            'center' => 'required_if:type,circle|array|size:2',
            'radius' => 'required_if:type,circle|integer|min:1',
        ]);

        $device = $this->findMobileDevice($request->user(), $validated['device_id']);

        try {
            $geofence = $this->geofences->create($device, $validated);
        } catch (\Throwable $e) {
            report($e);

            return $this->mobileError('Could not save geofence: ' . $e->getMessage(), 422);
        }

        return $this->mobileSuccess($this->formatGeofence($geofence, $device->id), 201);
    }

    public function destroy(Request $request, int $id)
    {
        $geofence = Geofence::with('device')->findOrFail($id);
        $device = $geofence->device;

        if (! $device) {
            return $this->mobileError('Geofence not found', 404);
        }

        $this->findMobileDevice($request->user(), $device->id);
        $this->geofences->delete($geofence);

        return $this->mobileSuccess(['message' => 'Geofence removed']);
    }

    public function assign(Request $request)
    {
        if (! self::GEOFENCE_CREATION_ENABLED) {
            return $this->mobileError('Geofence assignment is disabled', 403);
        }

        $validated = $request->validate([
            'geofence_id' => 'required|integer',
            'device_id' => 'required|integer',
        ]);

        $device = $this->findMobileDevice($request->user(), $validated['device_id']);
        $geofence = Geofence::findOrFail($validated['geofence_id']);

        $this->linker->link($geofence, $device);

        return $this->mobileSuccess([
            'message' => 'Geofence assigned to device',
            'geofence' => $this->formatGeofence($geofence->fresh(), $device->id),
        ]);
    }

    /**
     * @return array<string, mixed>
     */
    private function formatGeofence(Geofence $g, int $deviceId): array
    {
        return [
            'id' => $g->id,
            'device_id' => $deviceId,
            'name' => $g->name,
            'type' => $g->type,
            'coords' => is_string($g->coords ?? null) ? json_decode($g->coords, true) : ($g->coords ?? null),
            'center' => is_string($g->center ?? null) ? json_decode($g->center, true) : ($g->center ?? null),
            'radius' => $g->radius ?? null,
        ];
    }
}
