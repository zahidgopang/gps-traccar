<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Subscription extends Model
{
    protected $fillable = [
        'user_id',
        'device_id',
        'plan',
        'starts_at',
        'ends_at',
        'status',
    ];

    protected $casts = [
        'starts_at' => 'datetime',
        'ends_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function device()
    {
        return $this->belongsTo(Device::class);
    }

    public function histories()
    {
        return $this->hasMany(SubscriptionHistory::class)->orderByDesc('archived_at');
    }

    public function isEffectivelyExpired(): bool
    {
        if ($this->status === 'expired') {
            return true;
        }

        if ($this->status === 'active' && $this->ends_at) {
            return $this->ends_at->endOfDay()->isPast();
        }

        return false;
    }
}
