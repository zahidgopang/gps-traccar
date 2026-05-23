<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Services\AdminAuditService;
use Illuminate\Http\Request;
use Spatie\Activitylog\Models\Activity;

class ActivityLogController extends Controller
{
    public function index(Request $request)
    {
        $query = Activity::query()
            ->with(['causer', 'subject'])
            ->whereIn('log_name', [AdminAuditService::LOG_NAME, 'default'])
            ->orderByDesc('id');

        if ($request->filled('log_name')) {
            $query->where('log_name', $request->log_name);
        }

        if ($request->filled('event')) {
            $query->where('event', $request->event);
        }

        if ($request->filled('causer_id')) {
            $query->where('causer_id', $request->causer_id)
                ->where('causer_type', 'App\Models\User');
        }

        if ($request->filled('q')) {
            $q = $request->q;
            $query->where(function ($w) use ($q) {
                $w->where('description', 'like', "%{$q}%")
                    ->orWhere('properties', 'like', "%{$q}%");
            });
        }

        if ($request->filled('from')) {
            $query->whereDate('created_at', '>=', $request->from);
        }

        if ($request->filled('to')) {
            $query->whereDate('created_at', '<=', $request->to);
        }

        $logs = $query->paginate(30)->withQueryString();

        $admins = Activity::query()
            ->where('log_name', AdminAuditService::LOG_NAME)
            ->where('causer_type', 'App\Models\User')
            ->distinct()
            ->pluck('causer_id')
            ->filter();

        $causers = \App\Models\User::whereIn('id', $admins)->orderBy('name')->get(['id', 'name', 'email']);

        return view('admin.activity-log.index', compact('logs', 'causers'));
    }
}
