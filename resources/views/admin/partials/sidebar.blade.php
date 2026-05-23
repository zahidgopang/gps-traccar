<!-- Premium Admin Sidebar - Working Version -->
<aside class="admin-sidebar is-open" id="adminSidebar" aria-label="{{ __('app.forms.toggle_sidebar') }}">
    <!-- Sidebar Header -->
    <div class="sidebar-header">
        <a href="{{ route('admin.dashboard') }}" class="sidebar-brand">
            <img src="{{ asset('images/logo.png') }}" alt="GPS Tracker Pro">
            <span>{{ __('app.brand') }}</span>
        </a>
    </div>

    <!-- Sidebar Navigation -->
    <nav class="sidebar-nav">
        <!-- Dashboard -->
        <div class="nav-group">
            <div class="nav-group-title">{{ __('app.admin.nav.main') }}</div>
            <a href="{{ route('admin.dashboard') }}"
               class="nav-link-premium {{ request()->routeIs('admin.dashboard') ? 'active' : '' }}">
                <i class="fas fa-tachometer-alt"></i>
                <span>{{ __('app.common.dashboard') }}</span>
            </a>
        </div>

        <!-- Tracking -->
        <div class="nav-group">
            <div class="nav-group-title">{{ __('app.admin.nav.tracking') }}</div>
            <a href="{{ route('admin.devices.index') }}"
               class="nav-link-premium {{ request()->routeIs('admin.devices.*') ? 'active' : '' }}">
                <i class="fas fa-satellite"></i>
                <span>{{ __('app.common.devices') }}</span>
            </a>

            <a href="{{ route('admin.locations.index') }}"
               class="nav-link-premium {{ request()->routeIs('admin.locations.*') || request()->routeIs('admin.device.map') ? 'active' : '' }}">
                <i class="fas fa-history"></i>
                <span>{{ __('app.admin.nav.location_history') }}</span>
            </a>
        </div>

        <!-- Management -->
        <div class="nav-group">
            <div class="nav-group-title">{{ __('app.admin.nav.management') }}</div>
            <a href="{{ route('admin.users.index') }}"
               class="nav-link-premium {{ request()->routeIs('admin.users.*') ? 'active' : '' }}">
                <i class="fas fa-users"></i>
                <span>{{ __('app.common.users') }}</span>
            </a>

            @if(Route::has('admin.subscriptions.index'))
                <a href="{{ route('admin.subscriptions.index') }}"
                   class="nav-link-premium {{ request()->routeIs('admin.subscriptions.*') ? 'active' : '' }}">
                    <i class="fas fa-credit-card"></i>
                    <span>{{ __('app.common.subscriptions') }}</span>
                </a>
            @else
                <a href="#" class="nav-link-premium" onclick="showComingSoon('Subscriptions')">
                    <i class="fas fa-credit-card"></i>
                    <span>{{ __('app.common.subscriptions') }}</span>
                    <span class="nav-badge">{{ __('app.common.soon') }}</span>
                </a>
            @endif
        </div>

        <!-- System -->
        <div class="nav-group">
            <div class="nav-group-title">{{ __('app.admin.nav.system') }}</div>
            @if(Route::has('admin.activity-log.index'))
                <a href="{{ route('admin.activity-log.index') }}"
                   class="nav-link-premium {{ request()->routeIs('admin.activity-log.*') ? 'active' : '' }}">
                    <i class="fas fa-clipboard-list"></i>
                    <span>{{ __('app.admin.nav.activity_log') }}</span>
                </a>
            @endif
            <a href="#" class="nav-link-premium" onclick="showComingSoon('Settings')">
                <i class="fas fa-cog"></i>
                <span>{{ __('app.admin.nav.settings') }}</span>
            </a>
            <a href="#" class="nav-link-premium" onclick="showComingSoon('Reports')">
                <i class="fas fa-chart-bar"></i>
                <span>{{ __('app.admin.nav.reports') }}</span>
            </a>
        </div>
    </nav>

    <!-- Sidebar Footer -->
    <div class="sidebar-footer p-3">
        <div class="text-center text-muted small">
            <div class="mb-1">{{ __('app.admin.nav.logged_in_as') }}</div>
            <div class="fw-semibold">{{ auth()->user()->name }}</div>
            <div class="mt-2">
                <i class="fas fa-circle text-success me-1" style="font-size: 0.5rem;"></i>
                <span>{{ __('app.admin.nav.system_online') }}</span>
            </div>
        </div>
    </div>
</aside>

<script>
    function showComingSoon(feature) {
        Swal.fire({
            title: 'Coming Soon!',
            text: feature + ' feature is currently under development.',
            icon: 'info',
            confirmButtonText: 'OK',
            background: 'var(--admin-card)',
            color: 'var(--admin-text)'
        });
    }
</script>

<style>
    .sidenav {
        display: none !important;
    }
</style>
