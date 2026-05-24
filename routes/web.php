<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserDevicesController;
use App\Http\Controllers\GeofenceController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\DeviceController as AdminDeviceController;
use App\Http\Controllers\Admin\UserController as AdminUserController;
use App\Http\Controllers\Admin\SubscriptionController as AdminSubscriptionController;
use App\Http\Controllers\Admin\ActivityLogController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\MapController;
use App\Http\Controllers\MapAccessController;
use App\Http\Controllers\VehicleAlertController;
/*
|--------------------------------------------------------------------------
| Public Route
|--------------------------------------------------------------------------
*/
Route::get('/', function () {
    return view('welcome');
});

Route::get('/locale/{locale}', [\App\Http\Controllers\LocaleController::class, 'switch'])
    ->whereIn('locale', ['en', 'ar'])
    ->name('locale.switch');

/*
|--------------------------------------------------------------------------
| AUTHENTICATED ROUTES USER
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'user.active', 'tracker.access'])->group(function () {

    /*
    |--------------------------------------------------------------------------
    | User Dashboard Redirect Logic
    |--------------------------------------------------------------------------
    */

    Route::get('/dashboard', function () {
        // If admin → redirect to admin panel
        if (auth()->user()->role === 'admin') {
            return redirect()->route('admin.dashboard');
        }

        // If normal user → redirect to user dashboard
        return redirect()->route('user.dashboard');
    })->name('dashboard');

    /*
    |--------------------------------------------------------------------------
    | USER PANEL ROUTES
    |--------------------------------------------------------------------------
    */
    Route::get('/user/dashboard', [UserController::class, 'dashboard'])
        ->name('user.dashboard');

    Route::get('/user/alerts', [VehicleAlertController::class, 'index'])
        ->name('user.alerts.index');

    Route::post('/map-tour/preference', [\App\Http\Controllers\MapTourPreferenceController::class, 'update'])
        ->name('map.tour.preference');

    Route::post('/map-session/end', [\App\Http\Controllers\MapSessionController::class, 'end'])
        ->name('map.session.end');

    Route::get('/user/devices/{device}/launch-map', [MapAccessController::class, 'launchUserMap'])
        ->name('user.devices.launch-map');

    Route::middleware('map.access')->group(function () {
        Route::get('/user/device/{token}/map', [MapController::class, 'map'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.map');
        Route::get('/user/device/{token}/history-json', [MapController::class, 'historyJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.history.json');
        Route::get('/user/device/{token}/live-json', [MapController::class, 'liveJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.live.json');
        Route::get('/user/device/{token}/summary-json', [MapController::class, 'summaryJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.summary.json');
        Route::get('/user/device/{token}/alerts-json', [MapController::class, 'alertsJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.alerts.json');
        Route::get('/user/device/{token}/reverse-geocode', [MapController::class, 'reverseGeocode'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.reverse.geocode');

        Route::get('/user/device/{token}/geofences-json', [GeofenceController::class, 'indexJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.geofences.json');
        Route::post('/user/device/{token}/geofences-save', [GeofenceController::class, 'store'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('user.device.geofences.save');
    });

    // User Profile Apis
    Route::get('/user/profile', [UserController::class, 'profile'])->name('user.profile');
    Route::post('/user/profile/update', [UserController::class, 'updateProfile'])->name('user.profile.update');
    Route::get('/user/change-password', [UserController::class, 'changePassword'])->name('user.change.password');
    Route::post('/user/change-password/update', [UserController::class, 'updatePassword'])->name('user.password.update');

    Route::delete('/user/geofence/{id}', [GeofenceController::class, 'destroy']);
    Route::post('/user/geofence/{id}/update', [GeofenceController::class, 'update']);

    // User Devices Routes
    Route::prefix('user/devices')->name('user.devices.')->group(function () {
        Route::get('/', [UserDevicesController::class, 'index'])->name('index');
        Route::get('/live-json', [UserDevicesController::class, 'liveJson'])->name('live-json');
    });

    /*
    |--------------------------------------------------------------------------
    | USER PROFILE ROUTES
    |--------------------------------------------------------------------------
    */

    Route::get('/profile', [ProfileController::class, 'edit'])
        ->name('profile.edit');

    Route::patch('/profile', [ProfileController::class, 'update'])
        ->name('profile.update');

    Route::delete('/profile', [ProfileController::class, 'destroy'])
        ->name('profile.destroy');
});

/*
|--------------------------------------------------------------------------
| ADMIN PANEL ROUTES
|--------------------------------------------------------------------------
*/
Route::middleware(['auth', 'can:admin'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {

        Route::get('/', [DashboardController::class, 'index'])
            ->name('dashboard');

        Route::patch('users/{user}/toggle-status', [AdminUserController::class, 'toggleStatus'])
            ->name('users.toggle-status');
        Route::resource('users', AdminUserController::class);
        Route::post('subscriptions/{subscription}/renew', [AdminSubscriptionController::class, 'renew'])
            ->name('subscriptions.renew');
        Route::get('subscriptions/{subscription}/histories', [AdminSubscriptionController::class, 'histories'])
            ->name('subscriptions.histories');
        Route::resource('subscriptions', AdminSubscriptionController::class);
        Route::patch('devices/{device}/toggle-status', [AdminDeviceController::class, 'toggleStatus'])
            ->name('devices.toggle-status');
        Route::resource('devices', AdminDeviceController::class);

        Route::get('activity-log', [ActivityLogController::class, 'index'])
            ->name('activity-log.index');

        Route::get('locations', [\App\Http\Controllers\Admin\LocationHistoryController::class, 'index'])
            ->name('locations.index');

        Route::get('locations/live-json', [\App\Http\Controllers\Admin\LocationHistoryController::class, 'liveJson'])
            ->name('locations.live-json');

        Route::get('locations/device/{device}/launch-map', [MapAccessController::class, 'launchAdminMap'])
            ->name('locations.launch-map');

        Route::middleware('map.access')->group(function () {
        Route::get('device/{token}/map', [MapController::class, 'map'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.map');
        Route::get('device/{token}/history-json', [MapController::class, 'historyJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.history.json');
        Route::get('device/{token}/live-json', [MapController::class, 'liveJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.live.json');
        Route::get('device/{token}/summary-json', [MapController::class, 'summaryJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.summary.json');
        Route::get('device/{token}/alerts-json', [MapController::class, 'alertsJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.alerts.json');
        Route::get('device/{token}/reverse-geocode', [MapController::class, 'reverseGeocode'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.reverse.geocode');
        Route::get('device/{token}/geofences-json', [GeofenceController::class, 'indexJson'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.geofences.json');
        Route::post('device/{token}/geofences-save', [GeofenceController::class, 'store'])
            ->where('token', '[A-Za-z0-9_-]+')
            ->name('device.geofences.save');
        Route::delete('geofence/{id}', [GeofenceController::class, 'destroy'])->name('geofence.destroy');
        Route::post('geofence/{id}/update', [GeofenceController::class, 'update'])->name('geofence.update');
        });
    });

/*
|--------------------------------------------------------------------------
| Breeze Authentication Routes
|--------------------------------------------------------------------------
*/

Route::prefix('demo')->group(function () {

    Route::get('/login', function () {
        session(['demo' => true]);
        return redirect('/demo/dashboard');
    });

    Route::get('/dashboard', function () {
        abort_unless(session('demo'), 403);
        return view('demo.dashboard');
    });

    Route::get('/tracking', function () {
        abort_unless(session('demo'), 403);
        return view('demo.tracking');
    });

    Route::get('/history', function () {
        abort_unless(session('demo'), 403);
        return response()->json(
            json_decode(
                file_get_contents(storage_path('app/demo/history.json')),
                true
            )
        );
    });

    Route::get('/logout', function () {
        session()->forget('demo');
        return redirect('/');
    });

});

Route::get('/contact', [ContactController::class, 'show'])->name('contact');
Route::post('/contact/submit', [ContactController::class, 'submit'])->name('contact.submit');
Route::get('/contact/rate-limit', [ContactController::class, 'checkRateLimit'])
    ->name('contact.rate-limit');

// Company pages
Route::get('/company', [PageController::class, 'company'])->name('company');
Route::get('/about', [PageController::class, 'about'])->name('about');
Route::get('/careers', [PageController::class, 'careers'])->name('careers');
Route::get('/press', [PageController::class, 'press'])->name('press');
Route::get('/blog', [PageController::class, 'blog'])->name('blog');
Route::view('/pricing', 'pricing')->name('pricing');

// Support pages
Route::get('/help', [PageController::class, 'help'])->name('help');
Route::get('/docs', [PageController::class, 'docs'])->name('docs');
Route::get('/api', [PageController::class, 'api'])->name('api');
Route::get('/status', [PageController::class, 'status'])->name('status');

Route::get('/terms', [PageController::class, 'terms'])->name('terms');
Route::get('/privacy', [PageController::class, 'privacy'])->name('privacy');
Route::get('/security', [PageController::class, 'security'])->name('security');
Route::get('/cookies', [PageController::class, 'cookies'])->name('cookies');

//Laravel Breeze
require __DIR__ . '/auth.php';
