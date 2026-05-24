<!-- Premium Map Sidebar -->
<div class="filter-panel" id="filterPanel">
    <!-- Sidebar Header -->
    <!-- Sidebar Header -->
    <div class="sidebar-header">
        <a href="{{ ($isAdminMap ?? false) ? route('admin.locations.index') : route('user.devices.index') }}" class="sidebar-back-link" data-map-tour="sidebar-back">
            <i class="fas fa-arrow-left" aria-hidden="true"></i>
            <span>{{ ($isAdminMap ?? false) ? __('app.map.back_location_history') : __('app.map.back_devices') }}</span>
        </a>
        <button type="button" class="sidebar-close" id="closeSidebar" aria-label="{{ __('app.map.close_panel') }}">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <!-- Date Range -->
    <div class="filter-section" data-map-tour="date-range">
        <label class="form-label fw-semibold mb-2">
            <i class="fas fa-calendar-alt me-2"></i>{{ __('app.map.date_range') }}
        </label>
        <input id="dateRange" class="form-control form-control-premium mb-2 no-select2"
               placeholder="{{ __('app.map.date_placeholder') }}" readonly data-flatpickr-manual>
        <small class="text-muted d-block mb-3" style="font-size: 0.75rem;">
            {{ __('app.map.date_hint') }}
        </small>
    </div>

    <!-- Apply Filter -->
    <button id="applyFilter" class="btn btn-premium w-100 mb-4">
        <i class="fas fa-search me-2"></i>{{ __('app.map.search_history') }}
    </button>

    <!-- Device Summary Card -->
    <div class="premium-card mb-4" data-map-tour="device-summary">
        <div class="card-header">
            <h6 class="mb-0">
                <i class="fas fa-info-circle me-2"></i>{{ __('app.map.device_summary') }}
            </h6>
        </div>
        <div class="card-body">
            <div class="info-row">
                <div class="info-label">{{ __('app.map.device_name') }}</div>
                <div class="info-value">{{ $device->name }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.imei_number') }}</div>
                <div class="info-value">
                    <code class="bg-light p-1 rounded">{{ $device->imei }}</code>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.last_update') }}</div>
                <div class="info-value text-success" id="lastSeen">-</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.current_status') }}</div>
                <div class="info-value">
                    <span class="badge bg-secondary" id="curStatus">{{ __('app.map.dash') }}</span>
                </div>
            </div>
        </div>
    </div>


    <div class="premium-card mb-4">
        <div class="card-header"><h6 class="mb-0"><i class="fas fa-tachometer-alt me-2"></i>{{ __('app.map.live_telemetry') }}</h6></div>
        <div class="card-body">
            <div class="info-row"><div class="info-label">{{ __('app.map.speed') }}</div><div class="info-value" id="telemetrySpeed">{{ __('app.map.dash') }}</div></div>
            <div class="info-row"><div class="info-label">{{ __('app.map.heading') }}</div><div class="info-value" id="telemetryHeading">{{ __('app.map.dash') }}</div></div>
            <div class="info-row"><div class="info-label">{{ __('app.map.battery') }}</div><div class="info-value" id="telemetryBattery">{{ __('app.map.dash') }}</div></div>
            <div class="info-row"><div class="info-label">{{ __('app.map.ignition') }}</div><div class="info-value" id="telemetryIgnition">{{ __('app.map.dash') }}</div></div>
            <div class="info-row"><div class="info-label">{{ __('app.map.gsm_signal') }}</div><div class="info-value" id="telemetryGsm">{{ __('app.map.dash') }}</div></div>
            <div class="info-row"><div class="info-label">{{ __('app.map.satellites') }}</div><div class="info-value" id="telemetrySatellites">{{ __('app.map.dash') }}</div></div>
            <div class="info-row"><div class="info-label">{{ __('app.map.odometer') }}</div><div class="info-value" id="telemetryOdometer">{{ __('app.map.dash') }}</div></div>
        </div>
    </div>


    <!-- Route Summary Card -->
    <div class="premium-card mb-4" data-map-tour="route-summary">
        <div class="card-header">
            <h6 class="mb-0">
                <i class="fas fa-route me-2"></i>{{ __('app.map.route_summary') }}
            </h6>
        </div>
        <div class="card-body">
            <div class="info-row">
                <div class="info-label">{{ __('app.map.total_distance') }}</div>
                <div class="info-value" id="totalDistance">- km</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.duration') }}</div>
                <div class="info-value" id="routeDuration">-</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.average_speed') }}</div>
                <div class="info-value" id="avgSpeed">- km/h</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.max_speed') }}</div>
                <div class="info-value" id="maxSpeed">- km/h</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.moving_time') }}</div>
                <div class="info-value" id="movingTime">{{ __('app.map.dash') }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.stopped_time') }}</div>
                <div class="info-value" id="stoppedTime">{{ __('app.map.dash') }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.overspeed_events') }}</div>
                <div class="info-value" id="overspeedCount">0</div>
            </div>
        </div>
    </div>

    <div class="premium-card mb-4" data-map-tour="trip-events">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h6 class="mb-0"><i class="fas fa-list-ul me-2"></i>{{ __('app.map.trip_events') }}</h6>
            <small class="text-muted" id="tripEventsCount">0</small>
        </div>
        <div class="card-body p-0">
            <div class="trip-events-list" id="tripEventsList">
                <div class="trip-event-empty text-muted small text-center py-3">{{ __('app.map.load_history_stops') }}</div>
            </div>
        </div>
    </div>

    <div class="premium-card mb-4">
        <div class="card-header"><h6 class="mb-0"><i class="fas fa-file-export me-2"></i>{{ __('app.map.export') }}</h6></div>
        <div class="card-body d-grid gap-2">
            <button type="button" class="btn btn-outline-premium btn-sm" id="btnExportCsv"><i class="fas fa-file-csv me-2"></i>{{ __('app.map.export_csv') }}</button>
            <button type="button" class="btn btn-outline-premium btn-sm" id="btnExportGpx"><i class="fas fa-route me-2"></i>{{ __('app.map.export_gpx') }}</button>
        </div>
    </div>

    <!-- Idle Summary Card -->
    <div class="premium-card mb-4">
        <div class="card-header">
            <h6 class="mb-0">
                <i class="fas fa-clock me-2"></i>Idle Summary
            </h6>
        </div>
        <div class="card-body">
            <div class="info-row">
                <div class="info-label">{{ __('app.map.idle_events') }}</div>
                <div class="info-value" id="idleCount">0</div>
            </div>
            <div class="info-row">
                <div class="info-label">{{ __('app.map.total_idle_time') }}</div>
                <div class="info-value" id="idleTotal">0m</div>
            </div>
        </div>
    </div>

    <!-- Geofences Card -->
    <div class="premium-card mb-4" data-map-tour="geofence-list">
        <div class="card-header">
            <h6 class="mb-0">
                <i class="fas fa-draw-polygon me-2"></i>Geofences
            </h6>
        </div>
        <div class="card-body">
            <div class="geofence-list" id="geofenceList">
                <div class="text-center py-3">
                    <i class="fas fa-spinner fa-spin me-2"></i>
                    <span>{{ __('app.map.loading_geofences') }}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Address Lookup -->
    <div class="premium-card">
        <div class="card-header">
            <h6 class="mb-0">
                <i class="fas fa-map-marker-alt me-2"></i>Address Lookup
            </h6>
        </div>
        <div class="card-body">
            <div class="geofence-manage-list" id="geofenceManageList"></div>
            <button id="reverseBtn" class="btn btn-outline-premium w-100 mt-2">
                <i class="fas fa-search-location me-2"></i>{{ __('app.map.get_address') }}
            </button>
            <div id="addressBox" class="address-result mt-3 p-3 rounded"></div>
        </div>
    </div>
</div>

<style>
    /* Premium Map Sidebar Styles */
    .filter-panel {
        width: 380px;
        position: fixed;
        top: 70px;
        left: 0;
        right: auto;
        height: calc(100vh - 70px);
        background: var(--map-sidebar);
        border-inline-end: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 10px 0 25px rgba(0, 0, 0, 0.3);
        padding: 1.5rem;
        overflow-x: hidden;
        overflow-y: auto;
        transition: transform 0.35s ease;
        z-index: 1050;
        box-sizing: border-box;
    }

    html[dir="ltr"] .filter-panel#filterPanel:not(.show) {
        transform: translateX(-100%);
    }

    html[dir="rtl"] .filter-panel#filterPanel {
        left: auto !important;
        right: 0 !important;
        border-inline-end: none;
        border-inline-start: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: -8px 0 25px rgba(0, 0, 0, 0.3);
    }

    html[dir="rtl"] .filter-panel#filterPanel:not(.show) {
        transform: translateX(100%) !important;
    }

    .filter-panel#filterPanel.show {
        transform: translateX(0) !important;
    }

    /* Sidebar Header */
    .sidebar-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sidebar-back-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 0.8rem;
        font-weight: 600;
        color: rgba(255, 255, 255, 0.85);
        text-decoration: none;
        padding: 4px 0;
        transition: color 0.2s;
    }

    .sidebar-back-link:hover {
        color: #fff;
    }

    .sidebar-back-link i {
        font-size: 0.72rem;
    }

    .device-avatar {
        width: 48px;
        height: 48px;
        background: linear-gradient(135deg, var(--map-primary), #2196F3);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.25rem;
    }

    .sidebar-header h5 {
        color: white;
        font-weight: 600;
        margin: 0;
    }

    .sidebar-header small {
        color: rgba(255, 255, 255, 0.6);
        font-size: 0.8125rem;
    }

    .sidebar-close {
        width: 36px;
        height: 36px;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s ease;
        display: none;
    }

    .sidebar-close:hover {
        background: rgba(239, 68, 68, 0.2);
        transform: rotate(90deg);
    }

    /* Form Controls */
    .form-control-premium {
        background: rgba(255, 255, 255, 0.1);
        border: 1px solid rgba(255, 255, 255, 0.2);
        color: white;
        border-radius: 10px;
        padding: 0.75rem 1rem;
        transition: all 0.3s ease;
    }

    .form-control-premium:focus {
        background: rgba(255, 255, 255, 0.15);
        border-color: var(--map-primary);
        box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
        color: white;
    }

    .form-control-premium::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }

    /* Premium Cards */
    .premium-card {
        background: rgba(255, 255, 255, 0.95);
        border: 1px solid rgba(0, 0, 0, 0.08);
        border-radius: 16px;
        padding: 1.25rem;
        margin-bottom: 1.5rem;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }

    .premium-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        border-color: rgba(25, 118, 210, 0.3);
    }

    .premium-card .card-header {
        background: transparent;
        border-bottom: 1px solid rgba(0, 0, 0, 0.08);
        padding: 0 0 1rem 0;
        margin-bottom: 1rem;
    }

    .premium-card .card-header h6 {
        color: var(--map-text);
        font-weight: 600;
        font-size: 0.9375rem;
        margin: 0;
        display: flex;
        align-items: center;
    }

    /* Info Rows */
    .info-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.5rem 0;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }

    .info-row:last-child {
        border-bottom: none;
    }

    .info-label {
        color: var(--map-text-light);
        font-size: 0.8125rem;
        font-weight: 500;
    }

    .info-value {
        color: var(--map-text);
        font-weight: 500;
        text-align: right;
        font-size: 0.875rem;
    }

    .info-value code {
        background: rgba(0, 0, 0, 0.05);
        padding: 0.25rem 0.5rem;
        border-radius: 6px;
        font-size: 0.75rem;
    }

    /* Buttons */
    .btn-premium {
        background: linear-gradient(135deg, var(--map-primary), #2196F3);
        border: none;
        color: white;
        border-radius: 12px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-premium:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(25, 118, 210, 0.3);
        background: linear-gradient(135deg, #1565C0, #1976D2);
    }

    .btn-outline-premium {
        background: transparent;
        border: 2px solid var(--map-primary);
        color: var(--map-primary);
        border-radius: 12px;
        padding: 0.75rem 1.5rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-outline-premium:hover {
        background: var(--map-primary);
        color: white;
        transform: translateY(-2px);
    }

    /* Badges */
    .badge {
        font-size: 0.75rem;
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-weight: 500;
    }

    .badge.bg-success {
        background: var(--map-success) !important;
    }

    /* Lists */
    .geofence-list,
    .geofence-manage-list {
        max-height: 220px;
        overflow-y: auto;
        padding-right: 5px;
    }

    .geofence-list-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 8px;
        padding: 10px 0;
        border-bottom: 1px solid rgba(0, 0, 0, 0.06);
    }

    .geofence-list-item:last-child {
        border-bottom: none;
    }

    .geofence-list-item__info {
        display: flex;
        flex-direction: column;
        min-width: 0;
    }

    .geofence-list-item__info strong {
        font-size: 0.875rem;
        color: var(--map-text);
    }

    .geofence-list-item__info small {
        font-size: 0.75rem;
    }

    .geofence-list-item__actions {
        display: flex;
        gap: 6px;
        flex-shrink: 0;
    }

    .geofence-list-item__actions .btn {
        padding: 0.25rem 0.5rem;
        line-height: 1;
    }

    .geofence-list::-webkit-scrollbar,
    .geofence-manage-list::-webkit-scrollbar {
        width: 4px;
    }

    .geofence-list::-webkit-scrollbar-thumb,
    .geofence-manage-list::-webkit-scrollbar-thumb {
        background: rgba(0, 0, 0, 0.2);
        border-radius: 4px;
    }

    /* Address Result */
    .address-result {
        background: rgba(0, 0, 0, 0.05);
        border: 1px solid rgba(0, 0, 0, 0.1);
        color: var(--map-text);
        font-size: 0.8125rem;
        min-height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .address-result:empty {
        display: none;
    }


    .trip-events-list { max-height: 200px; overflow-y: auto; }
    .trip-event-item {
        padding: 10px 14px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.06);
        font-size: 0.8rem;
        cursor: pointer;
        transition: background 0.15s;
    }
    .trip-event-item:hover { background: rgba(25, 118, 210, 0.06); }
    .trip-event-item:last-child { border-bottom: none; }
    .trip-event-item strong { display: block; color: #0f172a; font-size: 0.82rem; }
    .trip-event-item span { color: #64748b; font-size: 0.72rem; }
    .trip-event-item--overspeed strong { color: #ea580c; }

    .alerts-list { max-height: 180px; overflow-y: auto; padding: 0.75rem; }
    .alert-log-item {
        padding: 0.5rem 0.75rem;
        margin-bottom: 0.5rem;
        border-radius: 8px;
        border-left: 3px solid #4285f4;
        background: rgba(0,0,0,0.04);
        font-size: 0.75rem;
    }
    .alert-log-item strong { display: block; font-size: 0.8125rem; }
    .alert-log-item span { color: #555; }
    .alert-log-item small { display: block; color: #888; margin-top: 2px; }
    .alert-log-item.alert-error { border-left-color: #ea4335; background: rgba(234,67,53,0.08); }
    .alert-log-item.alert-warning { border-left-color: #f59e0b; background: rgba(245,158,11,0.08); }
    .alert-log-item.alert-success { border-left-color: #34a853; }

    /* Responsive */
    @media (max-width: 768px) {
        html[dir="ltr"] .filter-panel#filterPanel {
            border-radius: 0 20px 20px 0;
        }

        html[dir="rtl"] .filter-panel#filterPanel {
            border-radius: 20px 0 0 20px;
        }

        .filter-panel#filterPanel {
            width: min(320px, 88vw);
            top: 70px;
            height: calc(100vh - 70px);
            z-index: 1001;
        }

        .sidebar-close {
            display: flex;
        }

        .premium-card {
            padding: 1rem;
        }

        .btn-premium,
        .btn-outline-premium {
            padding: 0.625rem 1rem;
            font-size: 0.875rem;
        }
    }

    @media (max-width: 576px) {
        .filter-panel {
            width: 90%;
            padding: 1rem;
        }

        .device-avatar {
            width: 40px;
            height: 40px;
            font-size: 1rem;
        }

        .sidebar-header h5 {
            font-size: 1rem;
        }

        .info-row {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.25rem;
        }

        .info-value {
            text-align: left;
            width: 100%;
        }
    }
</style>

