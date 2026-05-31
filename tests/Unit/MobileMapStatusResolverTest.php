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

    public function test_offline_when_last_update_exceeds_thirty_minutes(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = new DeviceLocation([
            'speed' => 40,
            'ignition' => true,
            'recorded_at' => Carbon::now()->subMinutes(31),
        ]);

        $result = $this->resolver->resolve($latest, $device);

        $this->assertSame('offline', $result['key']);
        $this->assertSame('moving', $result['last_known_status_key']);
        $this->assertSame(40.0, $result['last_known_speed']);
        $this->assertTrue($result['last_known_ignition']);
    }

    public function test_delayed_between_ten_and_thirty_minutes(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = new DeviceLocation([
            'speed' => 40,
            'ignition' => true,
            'recorded_at' => Carbon::now()->subMinutes(15),
        ]);

        $result = $this->resolver->resolve($latest, $device);

        $this->assertSame('delayed', $result['key']);
        $this->assertSame('delayed', $result['connectivity_tier']);
        $this->assertSame('moving', $result['last_known_status_key']);
    }

    public function test_moving_when_speed_above_zero_within_recent_window(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = $this->freshLocation(['speed' => 3, 'ignition' => false]);

        $this->assertSame('moving', $this->resolver->resolve($latest, $device)['key']);
    }

    public function test_idle_when_speed_zero_and_ignition_on(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = $this->freshLocation(['speed' => 0, 'ignition' => true]);

        $this->assertSame('idle', $this->resolver->resolve($latest, $device)['key']);
    }

    public function test_stopped_when_speed_zero_and_ignition_off(): void
    {
        $device = new Device(['status' => 'active']);
        $latest = $this->freshLocation(['speed' => 0, 'ignition' => false]);

        $this->assertSame('stopped', $this->resolver->resolve($latest, $device)['key']);
    }

    private function freshLocation(array $overrides): DeviceLocation
    {
        return new DeviceLocation(array_merge([
            'recorded_at' => Carbon::now()->subMinute(),
        ], $overrides));
    }
}
