<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if ($this->hasUniqueOnColumn('subscriptions', 'device_id')) {
            Schema::table('subscriptions', function (Blueprint $table) {
                $table->dropUnique(['device_id']);
            });
        }

        // Non-unique index may already exist from 2026_05_17_100000 (device_id was added with ->index()).
        if (! $this->hasNonUniqueIndexOnColumn('subscriptions', 'device_id')) {
            Schema::table('subscriptions', function (Blueprint $table) {
                $table->index('device_id');
            });
        }
    }

    public function down(): void
    {
        if ($this->hasNonUniqueIndexOnColumn('subscriptions', 'device_id')
            && ! $this->hasUniqueOnColumn('subscriptions', 'device_id')) {
            Schema::table('subscriptions', function (Blueprint $table) {
                $table->dropIndex(['device_id']);
            });
        }

        if (! $this->hasUniqueOnColumn('subscriptions', 'device_id')) {
            Schema::table('subscriptions', function (Blueprint $table) {
                $table->unique('device_id');
            });
        }
    }

    private function hasUniqueOnColumn(string $table, string $column): bool
    {
        return $this->indexQuery($table, $column, uniqueOnly: true) !== null;
    }

    private function hasNonUniqueIndexOnColumn(string $table, string $column): bool
    {
        return $this->indexQuery($table, $column, uniqueOnly: false) !== null;
    }

    /**
     * @return object{index_name: string}|null
     */
    private function indexQuery(string $table, string $column, bool $uniqueOnly): ?object
    {
        $database = Schema::getConnection()->getDatabaseName();

        $rows = DB::select(
            'SELECT index_name, non_unique
             FROM information_schema.statistics
             WHERE table_schema = ?
               AND table_name = ?
               AND column_name = ?
             ORDER BY index_name',
            [$database, $table, $column]
        );

        foreach ($rows as $row) {
            $isUnique = (int) $row->non_unique === 0;
            if ($uniqueOnly && $isUnique) {
                return $row;
            }
            if (! $uniqueOnly && ! $isUnique) {
                return $row;
            }
        }

        return null;
    }
};
