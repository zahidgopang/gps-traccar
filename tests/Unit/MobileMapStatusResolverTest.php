<?php

namespace Tests\Unit;

use App\Models\Device;
use App\Models\DeviceLocation;
use App\Services\Mobile\MobileMapStatusResolver;
use Carbon\Carbon;
use Tests\TestCase;

class MobileMapStatusResolverTest extends TestCase
{
    private MobileMapStatusResolver $resolver;

    protected function setUp(): void
    {
        parent::setUp();
        Carbon::setTestNow(Carbon::parse('2026-05-29 12:00:00', 'Asia/Karachi'));
        $this->resolver = new MobileMapStatusResolver;
    }

    public function test_offline_when_no_location(): void
    {
        $device = new Device(['status' => 'active']);

        $result = $this->resolver->resolve(null, $device);

        $this->assertSame('offline', $result['key']);
        $this->assertSame('offline', $result['connectivity_tier']);
    }

    public function test_offline_when_last_update_exceeds_two_minutes(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = new DeviceLocation([
            'lat' => 25.46,
            'lng' => 68.78,
            'speed' => 89,
            'ignition' => true,
            'recorded_at' => Carbon::now()->subSeconds(121),
        ]);

        $result = $this->resolver->resolve($latest, $device);

        $this->assertSame('offline', $result['key']);
        $this->assertSame('moving', $result['last_known_status_key']);
        $this->assertSame(89.0, $result['last_known_speed']);
    }

    public function test_offline_when_fix_is_between_sixty_and_one_twenty_seconds(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = new DeviceLocation([
            'lat' => 25.46,
            'lng' => 68.78,
            'speed' => 40,
            'ignition' => true,
            'recorded_at' => Carbon::now()->subSeconds(90),
        ]);

        $result = $this->resolver->resolve($latest, $device);

        $this->assertSame('offline', $result['key']);
        $this->assertSame('offline', $result['connectivity_tier']);
        $this->assertSame('moving', $result['last_known_status_key']);
    }

    public function test_moving_when_speed_above_threshold_within_recent_window(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = $this->freshLocation(['speed' => 10, 'ignition' => true]);

        $this->assertSame('moving', $this->resolver->resolve($latest, $device)['key']);
    }

    public function test_idle_when_speed_low_and_ignition_on(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = $this->freshLocation(['speed' => 0, 'ignition' => true]);

        $this->assertSame('idle', $this->resolver->resolve($latest, $device)['key']);
    }

    public function test_ignition_off_when_ignition_is_off(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = $this->freshLocation(['speed' => 0, 'ignition' => false]);

        $this->assertSame('ignition_off', $this->resolver->resolve($latest, $device)['key']);
    }

    private function freshLocation(array $overrides): DeviceLocation
    {
        return new DeviceLocation(array_merge([
            'lat' => 25.46,
            'lng' => 68.78,
            'recorded_at' => Carbon::now()->subSeconds(30),
        ], $overrides));
    }
}
