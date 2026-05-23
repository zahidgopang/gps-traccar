<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Device;
use App\Services\DeviceSubscriptionService;
use App\Services\UserDashboardService;
use Illuminate\Http\Request;

class LocationHistoryController extends Controller
{
    public function index(Request $request, UserDashboardService $dashboard, DeviceSubscriptionService $subscriptions)
    {
        $q = Device::inTracker()
            ->with(['user', 'subscription'])
            ->orderByDesc('id');

        if ($search = $request->query('q')) {
            $q->where(function ($w) use ($search) {
                $w->whereImeiLike("%{$search}%")
                    ->orWhere('name', 'like', "%{$search}%")
                    ->orWhereHas('user', fn ($u) => $u->where('name', 'like', "%{$search}%")->orWhere('email', 'like', "%{$search}%"));
            });
        }

        if ($request->filled('status')) {
            $q->whereAppStatus($request->status);
        }

        $devices = $q->paginate(20)->withQueryString();
        app(\App\Services\Tracking\DevicePositionLoader::class)->attachLatestToMany($devices->getCollection());
        $alertDeviceIds = $dashboard->alertDeviceIds($devices->getCollection());

        return view('admin.locations.index', [
            'devices' => $devices,
            'dashboardService' => $dashboard,
            'subscriptionService' => $subscriptions,
            'alertDeviceIds' => $alertDeviceIds,
            'stats' => $dashboard->getDevicePageStats($devices->getCollection()),
        ]);
    }
}
