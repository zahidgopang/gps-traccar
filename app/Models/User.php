<?php

namespace App\Models;

use App\Models\Concerns\ScopesTraccarUserRole;
use App\Models\Concerns\UsesTcTable;
use App\Notifications\SendVerificationWithWelcome;
use App\Support\Traccar\TraccarAppFields;
use App\Support\Traccar\TraccarAttributes;
use App\Support\Traccar\TraccarSchema;
use App\Support\Traccar\TraccarUserPermissions;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

/**
 * Authenticated customer/admin — stored in tc_users (same table as Traccar).
 * Laravel-only fields live in the attributes JSON column.
 */
class User extends Authenticatable
{
    use HasApiTokens, HasFactory, LogsActivity, Notifiable, ScopesTraccarUserRole, UsesTcTable;

    public $timestamps = false;

    protected $guarded = [];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function getTable(): string
    {
        return config('traccar.tables.users', 'tc_users');
    }

    public function getAuthPassword(): string
    {
        return (string) TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_PASSWORD,
            ''
        );
    }

    public function getRememberToken(): ?string
    {
        return TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_REMEMBER
        );
    }

    public function setRememberToken($value): void
    {
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_REMEMBER => $value]);
    }

    public function getEmailVerifiedAtAttribute(): ?\Illuminate\Support\Carbon
    {
        $raw = TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_EMAIL_VERIFIED
        );

        return $raw ? \Illuminate\Support\Carbon::parse($raw) : null;
    }

    public function setEmailVerifiedAtAttribute($value): void
    {
        $this->patchTraccarAppAttributes([
            TraccarAppFields::KEY_EMAIL_VERIFIED => $value?->toDateTimeString(),
        ]);
    }

    public function getRoleAttribute(): string
    {
        if ((int) ($this->attributes['administrator'] ?? 0) === 1) {
            return 'admin';
        }

        return (string) TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_ROLE,
            'user'
        );
    }

    public function setRoleAttribute(string $value): void
    {
        $this->attributes['administrator'] = $value === 'admin' ? 1 : 0;
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_ROLE => $value]);
    }

    public function getStatusAttribute(): string
    {
        if ((int) ($this->attributes['disabled'] ?? 0) === 1) {
            return 'inactive';
        }

        return (string) TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_STATUS,
            'active'
        );
    }

    public function setStatusAttribute(string $value): void
    {
        $this->attributes['disabled'] = $value !== 'active' ? 1 : 0;
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_STATUS => $value]);
    }

    public function getPreferencesAttribute(): array
    {
        $prefs = TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_PREFERENCES,
            []
        );

        return is_array($prefs) ? $prefs : [];
    }

    public function setPreferencesAttribute($value): void
    {
        $this->patchTraccarAppAttributes([
            TraccarAppFields::KEY_PREFERENCES => is_array($value) ? $value : [],
        ]);
    }

    public function getCountryCodeAttribute(): ?string
    {
        return TraccarAppFields::get($this->getTraccarAttributesJson(), TraccarAppFields::KEY_COUNTRY);
    }

    public function setCountryCodeAttribute(?string $value): void
    {
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_COUNTRY => $value]);
    }

    public function getPhoneAttribute(): ?string
    {
        return TraccarAppFields::get($this->getTraccarAttributesJson(), TraccarAppFields::KEY_PHONE);
    }

    public function setPhoneAttribute(?string $value): void
    {
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_PHONE => $value]);
    }

    public function getCreatedAtAttribute(): ?\Illuminate\Support\Carbon
    {
        $raw = TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_CREATED_AT
        );

        if ($raw) {
            return \Illuminate\Support\Carbon::parse($raw);
        }

        $column = TraccarSchema::resolveColumn($this->getTable(), 'created_at');

        if ($column && ! empty($this->attributes[$column])) {
            return \Illuminate\Support\Carbon::parse($this->attributes[$column]);
        }

        return null;
    }

    public function getUpdatedAtAttribute(): ?\Illuminate\Support\Carbon
    {
        $raw = TraccarAppFields::get(
            $this->getTraccarAttributesJson(),
            TraccarAppFields::KEY_UPDATED_AT
        );

        if ($raw) {
            return \Illuminate\Support\Carbon::parse($raw);
        }

        return $this->created_at;
    }

    public function setPasswordAttribute($value): void
    {
        $hash = Hash::needsRehash($value) ? Hash::make($value) : $value;
        $this->patchTraccarAppAttributes([TraccarAppFields::KEY_PASSWORD => $hash]);
    }

    protected static function booted(): void
    {
        static::creating(function (User $user) {
            if (! TraccarAppFields::get($user->getTraccarAttributesJson(), TraccarAppFields::KEY_CREATED_AT)) {
                $user->patchTraccarAppAttributes([
                    TraccarAppFields::KEY_CREATED_AT => now()->toDateTimeString(),
                ]);
            }

            if (! config('auth.require_email_verification', false)
                && ! TraccarAppFields::get($user->getTraccarAttributesJson(), TraccarAppFields::KEY_EMAIL_VERIFIED)) {
                $user->patchTraccarAppAttributes([
                    TraccarAppFields::KEY_EMAIL_VERIFIED => now()->toDateTimeString(),
                ]);
            }
        });

        static::saving(function (User $user) {
            if (! isset($user->attributes['login']) && ! empty($user->attributes['email'])) {
                $user->attributes['login'] = strtolower((string) $user->attributes['email']);
            }

            TraccarUserPermissions::applyToModel($user);

            if (! TraccarSchema::hasColumn($user->getTable(), 'attributes')) {
                return;
            }

            if ($user->getTraccarAttributesJson() === null) {
                $user->setTraccarAttributesJson(TraccarAttributes::encode([]));
            }

            $user->patchTraccarAppAttributes([
                TraccarAppFields::KEY_UPDATED_AT => now()->toDateTimeString(),
            ]);
        });

        static::saved(function (User $user) {
            if ($user->pendingTraccarPlainPassword !== null) {
                app(\App\Services\Traccar\TraccarUserPasswordSync::class)
                    ->applyTraccarLoginPassword($user, $user->pendingTraccarPlainPassword);
                $user->pendingTraccarPlainPassword = null;
            }
        });

        static::deleting(function (User $user) {
            if (! $user->id) {
                return;
            }

            app(\App\Services\Traccar\TraccarUserDeviceLinker::class)->removeForUser((int) $user->id);

            $userGeofence = config('traccar.tables.user_geofence', 'tc_user_geofence');
            if (\Illuminate\Support\Facades\Schema::hasTable($userGeofence)) {
                $geofenceCol = TraccarSchema::resolveColumn($userGeofence, 'geofenceid') ?? 'geofenceid';
                $userCol = TraccarSchema::resolveColumn($userGeofence, 'userid') ?? 'userid';
                \Illuminate\Support\Facades\DB::table($userGeofence)->where($userCol, $user->id)->delete();
            }
        });
    }

    private ?string $pendingTraccarPlainPassword = null;

    public function setTraccarPlainPasswordForNextSave(?string $plain): void
    {
        $this->pendingTraccarPlainPassword = $plain;
    }

    public const MAP_TOUR_REPEAT = 'repeat';

    public const MAP_TOUR_DISMISS = 'dismiss';

    public function getMapTourPreference(): string
    {
        $mode = $this->preferences['map_tour'] ?? null;

        return in_array($mode, [self::MAP_TOUR_REPEAT, self::MAP_TOUR_DISMISS], true)
            ? $mode
            : self::MAP_TOUR_REPEAT;
    }

    public function setMapTourPreference(string $mode): void
    {
        $prefs = $this->preferences;
        $prefs['map_tour'] = $mode;
        $this->preferences = $prefs;
        $this->save();
    }

    public function shouldShowMapTourOnLoad(): bool
    {
        return $this->getMapTourPreference() !== self::MAP_TOUR_DISMISS;
    }

    /**
     * Legacy stored preference (not used for UI locale — language is session-scoped per browser).
     *
     * @deprecated Locale is session-only; do not use for rendering.
     */
    public function getLocalePreference(): string
    {
        $locale = $this->preferences['locale'] ?? 'en';

        return in_array($locale, ['en', 'ar'], true) ? $locale : 'en';
    }

    /**
     * @deprecated Locale is session-only; use LocaleController / session('locale') instead.
     */
    public function setLocalePreference(string $locale): void
    {
        $prefs = $this->preferences;
        $prefs['locale'] = in_array($locale, ['en', 'ar'], true) ? $locale : 'en';
        $this->preferences = $prefs;
        $this->save();
    }

    public function devices()
    {
        $keys = TraccarSchema::userDevicePivotKeys();

        return $this->belongsToMany(
            Device::class,
            $keys['table'],
            $keys['user'],
            $keys['device'],
        );
    }

    public function trackerDevicesQuery()
    {
        return app(\App\Services\Traccar\TraccarDeviceAccessService::class)->queryForUser($this);
    }

    public function trackableDevicesQuery()
    {
        return app(\App\Services\Traccar\TraccarDeviceAccessService::class)->queryTrackableForUser($this);
    }

    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['name', 'email', 'country_code', 'role', 'status'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs()
            ->setDescriptionForEvent(fn (string $eventName) => "User {$eventName}");
    }

    public function hasVerifiedEmail(): bool
    {
        if (! config('auth.require_email_verification', false)) {
            return true;
        }

        return $this->email_verified_at !== null;
    }

    public function sendEmailVerificationNotification(): void
    {
        if (! config('auth.require_email_verification', false)) {
            return;
        }

        $this->notify(new SendVerificationWithWelcome());
    }

    public function getEmailForVerification(): string
    {
        return strtolower((string) $this->email);
    }
}
