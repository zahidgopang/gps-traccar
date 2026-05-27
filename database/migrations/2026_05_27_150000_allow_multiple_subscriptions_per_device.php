<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('subscriptions', function (Blueprint $table) {
            // Allow creating a new subscription after expiry/cancellation.
            // We enforce "one active subscription per device" at the application layer.
            $table->dropUnique(['device_id']);
            $table->index('device_id');
        });
    }

    public function down(): void
    {
        Schema::table('subscriptions', function (Blueprint $table) {
            $table->dropIndex(['device_id']);
            $table->unique('device_id');
        });
    }
};

