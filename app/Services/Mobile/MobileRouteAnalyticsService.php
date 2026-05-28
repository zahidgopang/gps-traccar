<?php

namespace App\Services\Mobile;

use App\Models\DeviceLocation;
use App\Services\UserDashboardService;
use Carbon\Carbon;
use Illuminate\Support\Collection;

class MobileRouteAnalyticsService
{
    public const STOP_SPEED_KMH = 2;

    public const IDLE_SPEED_KMH = 0.5;

    public const STOP_MIN_SECONDS = 120;

    public const OVERSPEED_KMH = 120;

    /**
     * @param  Collection<int, DeviceLocation|object>  $points
     * @return array<string, mixed>
     */
    public function analyze(Collection $points): array
    {
        $data = $points->values()->all();

        if ($data === []) {
            return $this->emptyStats();
        }

        $dist = 0.0;
        $maxSpeed = 0.0;
        $overspeedEvents = 0;
        $movingSec = 0;
        $stoppedSec = 0;
        $stops = [];
        $stopRun = [];
        $movingPoints = [];
        $idlePoints = [];

        $flushStop = function () use (&$stopRun, &$stops): void {
            if (count($stopRun) < 2) {
                $stopRun = [];

                return;
            }

            $t0 = $this->pointTime($stopRun[0]);
            $t1 = $this->pointTime($stopRun[count($stopRun) - 1]);

            if (! $t0 || ! $t1) {
                $stopRun = [];

                return;
            }

            $dur = $t1->diffInSeconds($t0);

            if ($dur >= self::STOP_MIN_SECONDS) {
                $mid = $stopRun[(int) floor(count($stopRun) / 2)];
                $stops[] = [
                    'lat' => (float) $mid->lat,
                    'lng' => (float) $mid->lng,
                    'duration_seconds' => $dur,
                    'start' => $t0->toIso8601String(),
                    'end' => $t1->toIso8601String(),
                ];
            }

            $stopRun = [];
        };

        for ($i = 1, $n = count($data); $i < $n; $i++) {
            $a = $data[$i - 1];
            $b = $data[$i];

            $dist += $this->haversineKm(
                (float) $a->lat,
                (float) $a->lng,
                (float) $b->lat,
                (float) $b->lng
            );

            $spd = (float) ($b->speed ?? 0);

            if ($spd > $maxSpeed) {
                $maxSpeed = $spd;
            }

            if ($spd > self::OVERSPEED_KMH) {
                $overspeedEvents++;
            }

            $t0 = $this->pointTime($a);
            $t1 = $this->pointTime($b);
            $dt = ($t0 && $t1 && $t1->greaterThan($t0)) ? $t1->diffInSeconds($t0) : 0;

            if ($spd > UserDashboardService::MOVING_SPEED_KMH) {
                $movingSec += $dt;
                $movingPoints[] = $this->pointPayload($b);
                $flushStop();
            } elseif ($spd < self::STOP_SPEED_KMH) {
                $stoppedSec += $dt;
                $stopRun[] = $b;

                if ($spd <= self::IDLE_SPEED_KMH) {
                    $idlePoints[] = $this->pointPayload($b);
                }
            } else {
                $movingSec += $dt;
                $flushStop();
            }
        }

        $flushStop();

        $tStart = $this->pointTime($data[0]);
        $tEnd = $this->pointTime($data[count($data) - 1]);
        $totalSec = ($tStart && $tEnd && $tEnd->greaterThan($tStart))
            ? $tEnd->diffInSeconds($tStart)
            : 0;

        $avgSpeed = $movingSec > 0 ? ($dist / ($movingSec / 3600)) : 0;

        return [
            'total_distance_km' => round($dist, 2),
            'moving_time_seconds' => $movingSec,
            'stopped_time_seconds' => $stoppedSec,
            'idle_time_seconds' => $stoppedSec,
            'max_speed_kmh' => round($maxSpeed, 1),
            'average_speed_kmh' => round($avgSpeed, 1),
            'overspeed_events' => $overspeedEvents,
            'total_duration_seconds' => $totalSec,
            'stops' => $stops,
            'moving_points' => $movingPoints,
            'idle_points' => $idlePoints,
        ];
    }

    /**
     * @return array<string, mixed>
     */
    private function emptyStats(): array
    {
        return [
            'total_distance_km' => 0,
            'moving_time_seconds' => 0,
            'stopped_time_seconds' => 0,
            'idle_time_seconds' => 0,
            'max_speed_kmh' => 0,
            'average_speed_kmh' => 0,
            'overspeed_events' => 0,
            'total_duration_seconds' => 0,
            'stops' => [],
            'moving_points' => [],
            'idle_points' => [],
        ];
    }

    /**
     * @return array{lat: float, lng: float, speed: float, recorded_at: ?string}
     */
    private function pointPayload(object $point): array
    {
        $at = $this->pointTime($point);

        return [
            'lat' => (float) $point->lat,
            'lng' => (float) $point->lng,
            'speed' => (float) ($point->speed ?? 0),
            'recorded_at' => $at?->toIso8601String(),
        ];
    }

    private function pointTime(object $point): ?Carbon
    {
        if (! isset($point->recorded_at)) {
            return null;
        }

        return $point->recorded_at instanceof Carbon
            ? $point->recorded_at
            : Carbon::parse($point->recorded_at);
    }

    private function haversineKm(float $lat1, float $lon1, float $lat2, float $lon2): float
    {
        $r = 6371;
        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);
        $a = sin($dLat / 2) ** 2 + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin($dLon / 2) ** 2;

        return $r * 2 * asin(sqrt($a));
    }
}
