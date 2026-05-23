<?php

namespace App\Models;

use App\Models\Concerns\HasTraccarUserAssignment;
use App\Models\Concerns\UsesTcTable;
use App\Services\Traccar\TraccarDeviceAccessService;
use App\Support\Traccar\TraccarAppFields;
use App\Support\Traccar\TraccarSchema;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

/**
 * GPS device — tc_devices (same table as Traccar).
 */
class Device extends Model
{
    use HasFactory, HasTraccarUserAssignment, UsesTcTable;

    public $timestamps = false;

    public const DEVICE_TYPES = [
        'car' => 'Car',
        'truck' => 'Truck',
        'bike' => 'Motorcycle',
        'personal' => 'Personal Tracker',
        'other' => 'Other',
    ];

    protected $guarded = [];

    public function getTable(): string
    {
        return config('traccar.tables.devices', 'tc_devices');
    }

    public function getImeiAttribute(): ?string
    {
        return $this->attributes['uniqueid'] ?? null;
    }

    public function setImeiAttribute(?string $value): void
    {
        $this->attributes['uniqueid'] = $value;
    }

    public function getDeviceTypeAttribute(): ?string
    {
        return $this->attributes['category']
            ?? TraccarAppFields::get($this->getTraccarAttributesJson(), TraccarAppFields::KEY_DEVICE_TYPE);
    }

    public function setDeviceTypeAttribute(?string $value): void
    {
        $this->attributes['category'] = $value;
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_DEVICE_TYPE => $value]);
    }

    public function getDescriptionAttribute(): ?string
    {
        return $this->attributes['contact']
            ?? TraccarAppFields::get($this->getTraccarAttributesJson(), TraccarAppFields::KEY_DEVICE_DESC);
    }

    public function setDescriptionAttribute(?string $value): void
    {
        $this->attributes['contact'] = $value;
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_DEVICE_DESC => $value]);
    }

    public function getStatusAttribute(): string
    {
        return (string) TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_DEVICE_STATUS,
            ((int) ($this->attributes['disabled'] ?? 0) === 1) ? 'blocked' : 'active'
        );
    }

    public function setStatusAttribute(string $value): void
    {
        $this->attributes['disabled'] = in_array($value, ['blocked', 'inactive'], true) ? 1 : 0;
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_DEVICE_STATUS => $value]);
    }

    public function getUserIdAttribute(): ?int
    {
        return $this->resolveTraccarOwnerUserId();
    }

    public function setUserIdAttribute(?int $userId): void
    {
        $this->pendingUserId = $userId;
    }

    private ?int $pendingUserId = null;

    protected static function booted(): void
    {
        static::saved(function (Device $device) {
            if ($device->pendingUserId === null || ! $device->id) {
                return;
            }

            $linker = app(\App\Services\Traccar\TraccarUserDeviceLinker::class);
            $linker->removeForDevice((int) $device->id);

            if ($device->pendingUserId) {
                $linker->upsert((int) $device->pendingUserId, (int) $device->id);
            }

            $device->pendingUserId = null;
        });

        static::deleting(function (Device $device) {
            if (! $device->id) {
                return;
            }

            app(\App\Services\Traccar\TraccarUserDeviceLinker::class)->removeForDevice((int) $device->id);

            $deviceGeofence = config('traccar.tables.device_geofence', 'tc_device_geofence');
            if (\Illuminate\Support\Facades\Schema::hasTable($deviceGeofence)) {
                $geofenceCol = \App\Support\Traccar\TraccarSchema::resolveColumn($deviceGeofence, 'geofenceid') ?? 'geofenceid';
                $deviceCol = \App\Support\Traccar\TraccarSchema::resolveColumn($deviceGeofence, 'deviceid') ?? 'deviceid';
                DB::table($deviceGeofence)->where($deviceCol, $device->id)->delete();
            }
        });
    }

    public function latestLocation()
    {
        return $this->hasOne(DeviceLocation::class)->latestOfMany('recorded_at');
    }

    public function subscription()
    {
        return $this->hasOne(Subscription::class, 'device_id');
    }

    public function deviceTypeLabel(): string
    {
        if (! $this->device_type) {
            return '—';
        }

        $key = 'app.forms.device_type_' . $this->device_type;

        return __($key) !== $key ? __($key) : (self::DEVICE_TYPES[$this->device_type] ?? ucfirst($this->device_type));
    }

    public function isAccountActive(): bool
    {
        return $this->status === 'active';
    }

    public function scopeForTrackerUser(Builder $query, User $user): Builder
    {
        return app(TraccarDeviceAccessService::class)->queryForUser($user);
    }

    /** Devices the user may see on maps/dashboards (tc_user_device + enabled + subscription). */
    public function scopeTrackableFor(Builder $query, User $user): Builder
    {
        return app(TraccarDeviceAccessService::class)->queryTrackableForUser($user);
    }

    public function scopeInTracker(Builder $query): Builder
    {
        return app(TraccarDeviceAccessService::class)->queryInTracker();
    }

    /** Match Traccar IMEI column (`uniqueid` on tc_devices). */
    public function scopeWhereImei(Builder $query, string $imei): Builder
    {
        $column = TraccarSchema::resolveColumn($query->getModel()->getTable(), 'uniqueid') ?? 'uniqueid';

        return $query->where($column, $imei);
    }

    public function scopeWhereImeiLike(Builder $query, string $pattern): Builder
    {
        $column = TraccarSchema::resolveColumn($query->getModel()->getTable(), 'uniqueid') ?? 'uniqueid';

        return $query->where($column, 'like', $pattern);
    }

    /** id, name, and Traccar IMEI column for list/detail queries (use $device->imei in views). */
    public static function listSelectColumns(): array
    {
        $table = (new static)->getTable();
        $uniqueid = TraccarSchema::resolveColumn($table, 'uniqueid') ?? 'uniqueid';

        return ['id', 'name', $uniqueid];
    }

    public static function eagerListRelation(): string
    {
        return 'device:'.implode(',', static::listSelectColumns());
    }

    public function launchMapRoute(bool $admin = false): string
    {
        if ($admin) {
            return route('admin.locations.launch-map', $this);
        }

        return route('user.devices.launch-map', $this);
    }
}
