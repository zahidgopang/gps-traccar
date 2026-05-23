<?php

namespace App\Http\Concerns;

use Carbon\Carbon;
use Illuminate\Http\Request;

trait ResolvesHistoryDateRange
{
    /**
     * No dates → last 24 hours (no upper bound).
     * Y-m-d from/to → full calendar days in app timezone.
     *
     * @return array{from: Carbon, to: ?Carbon}
     */
    protected function resolveHistoryRange(Request $request): array
    {
        $fromInput = trim((string) ($request->query('from', $request->input('from', ''))));
        $toInput = trim((string) ($request->query('to', $request->input('to', ''))));

        if ($fromInput !== '') {
            $tz = config('app.timezone');
            $from = $this->parseHistoryDate($fromInput, $tz, true);
            $to = $toInput !== ''
                ? $this->parseHistoryDate($toInput, $tz, false)
                : $from->copy()->endOfDay();

            if ($to->lessThan($from)) {
                [$from, $to] = [
                    $this->parseHistoryDate($toInput ?: $fromInput, $tz, true),
                    $this->parseHistoryDate($fromInput, $tz, false),
                ];
            }

            return ['from' => $from, 'to' => $to];
        }

        return [
            'from' => now()->subHours(24),
            'to' => null,
        ];
    }

    protected function parseHistoryDate(string $value, string $tz, bool $start): Carbon
    {
        if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $value)) {
            $date = Carbon::createFromFormat('Y-m-d', $value, $tz);

            return $start ? $date->startOfDay() : $date->copy()->endOfDay();
        }

        $parsed = Carbon::parse($value, $tz);

        return $start ? $parsed->copy()->startOfDay() : $parsed->copy()->endOfDay();
    }

    protected function applyRecordedAtRange($query, array $range)
    {
        $query->where('recorded_at', '>=', $range['from']);

        if ($range['to'] !== null) {
            $query->where('recorded_at', '<=', $range['to']);
        }

        return $query;
    }
}
