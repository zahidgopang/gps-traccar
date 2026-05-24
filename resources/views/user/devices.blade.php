@extends('user.layout_user')

@section('title', __('app.user.devices.title') . ' - ' . __('app.brand'))

@push('styles')
    <style>
        tr.device-row.row-updated { transition: background-color 0.4s ease; background-color: rgba(37, 99, 235, 0.06); }
        .stat-pulse { transition: transform 0.25s ease; transform: scale(1.06); }
    </style>
@endpush

@section('content')

    <div class="container dashboard-container">

        <!-- Header Section -->
        <div class="mb-4">
            <h4 class="fw-bold mb-2">
                <i class="fas fa-satellite me-2" style="color: var(--primary-blue);"></i>
                {{ __('app.user.devices.title') }}
            </h4>
            <p class="text-muted mb-0">{{ __('app.user.devices.subtitle') }}</p>
        </div>

        <!-- Stats Overview -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="premium-card">
                    <div class="d-flex align-items-center">
                        <div class="icon-box-sm me-3" style="background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));">
                            <i class="fas fa-satellite-dish text-white"></i>
                        </div>
                        <div>
                            <h5 class="mb-0" id="totalDevices">{{ $totalDevices }}</h5>
                            <small class="text-muted">{{ __('app.user.devices.total') }}</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="premium-card">
                    <div class="d-flex align-items-center">
                        <div class="icon-box-sm me-3" style="background: linear-gradient(135deg, #10B981, #059669);">
                            <i class="fas fa-signal text-white"></i>
                        </div>
                        <div>
                            <h5 class="mb-0" id="onlineDevices">{{ $onlineNow }}</h5>
                            <small class="text-muted">{{ __('app.user.devices.online_now') }}</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="premium-card">
                    <div class="d-flex align-items-center">
                        <div class="icon-box-sm me-3" style="background: linear-gradient(135deg, #F59E0B, #D97706);">
                            <i class="fas fa-car text-white"></i>
                        </div>
                        <div>
                            <h5 class="mb-0" id="runningDevices">{{ $running }}</h5>
                            <small class="text-muted">{{ __('app.user.devices.moving') }}</small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="premium-card">
                    <div class="d-flex align-items-center">
                        <div class="icon-box-sm me-3" style="background: linear-gradient(135deg, #EF4444, #DC2626);">
                            <i class="fas fa-parking text-white"></i>
                        </div>
                        <div>
                            <h5 class="mb-0" id="parkedDevices">{{ $parked }}</h5>
                            <small class="text-muted">{{ __('app.user.devices.parked_idle') }}</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        @if(($inactiveDevices ?? 0) > 0 || ($blockedDevices ?? 0) > 0 || ($alerts ?? 0) > 0)
            <div class="row mb-4">
                <div class="col-12">
                    <div class="d-flex flex-wrap gap-3 text-muted small">
                        <span><i class="fas fa-check-circle text-success me-1"></i> {{ $activeDevices }} {{ __('app.access.registered_active') }}</span>
                        @if($inactiveDevices > 0)
                            <span><i class="fas fa-clock me-1"></i> {{ __('app.access.inactive_count', ['count' => $inactiveDevices]) }}</span>
                        @endif
                        @if($blockedDevices > 0)
                            <span><i class="fas fa-ban text-danger me-1"></i> {{ __('app.access.blocked_count', ['count' => $blockedDevices]) }}</span>
                        @endif
                        @if($alerts > 0)
                            <span><i class="fas fa-exclamation-triangle text-danger me-1"></i> {{ trans_choice('app.access.geofence_alerts_today', $alerts, ['count' => $alerts]) }}</span>
                        @endif
                    </div>
                </div>
            </div>
        @endif

        @if(session('access_denied_message'))
            @php
                $denyReason = session('access_denied_reason', 'restricted');
                $isResubscribe = $denyReason === 'subscription_inactive';
            @endphp
            <div class="alert {{ $isResubscribe ? 'alert-warning' : 'alert-danger' }} d-flex align-items-start mb-4" role="alert">
                <i class="fas fa-{{ $isResubscribe ? 'credit-card' : 'ban' }} me-3 mt-1 fa-lg"></i>
                <div class="flex-grow-1">
                    <strong class="d-block mb-1">{{ session('access_denied_title', __('app.access.map_restricted')) }}</strong>
                    @if(session('subscription_device'))
                        <span class="d-block text-muted small mb-2">{{ __('app.access.device_label') }} <strong>{{ session('subscription_device') }}</strong></span>
                    @endif
                    <p class="mb-0">{{ session('access_denied_message') }}</p>
                    @if($isResubscribe)
                        <p class="small mb-0 mt-2">
                            <i class="fas fa-info-circle me-1"></i>
                        {{ __('app.access.resubscribe_hint') }}
                        </p>
                    @endif
                </div>
            </div>
        @endif

        <!-- Devices Table -->
        <div class="premium-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h5 class="mb-1">{{ __('app.user.devices.list_title') }}</h5>
                    <p class="text-muted mb-0">{{ __('app.user.devices.list_subtitle') }}</p>
                </div>
                <div class="d-flex">
                    <div class="input-group input-group-sm" style="width: 250px;">
                        <span class="input-group-text bg-transparent border-end-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control border-start-0" id="deviceSearch" placeholder="{{ __('app.user.devices.search_placeholder') }}">
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover" id="devicesTable">
                    <thead>
                    <tr>
                        <th>{{ __('app.user.devices.column_device') }}</th>
                        <th>{{ __('app.user.devices.column_imei') }}</th>
                        <th>{{ __('app.user.devices.column_type') }}</th>
                        <th>{{ __('app.user.devices.column_live_status') }}</th>
                        <th>{{ __('app.user.devices.column_speed') }}</th>
                        <th>{{ __('app.user.devices.column_last_update') }}</th>
                        <th>{{ __('app.user.devices.column_subscription') }}</th>
                        <th>{{ __('app.user.devices.column_device_status') }}</th>
                        <th class="text-end">{{ __('app.common.actions') }}</th>
                    </tr>
                    </thead>
                    <tbody id="deviceTableBody">
                    @forelse($devices as $d)
                        @php
                            $liveStatus = $dashboardService->resolveDeviceStatus($d, $alertDeviceIds);
                            $latest = $d->latestLocation;
                            $subStatus = $subscriptionService->statusLabel($d);
                            $accessCheck = app(\App\Services\DeviceAccessService::class)->evaluate(auth()->user(), $d);
                            $canTrack = $accessCheck['allowed'];
                            $lockTitle = $canTrack ? '' : ($accessCheck['title'] . ' — ' . $accessCheck['message']);
                        @endphp
                        <tr class="device-row" data-device-id="{{ $d->id }}" data-imei="{{ $d->imei }}"
                            data-search="{{ strtolower($d->name . ' ' . $d->imei . ' ' . $d->model) }}">
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="device-icon me-3">
                                        @if($d->device_type == 'car')
                                            <i class="fas fa-car fa-lg" style="color: var(--primary-blue);"></i>
                                        @elseif($d->device_type == 'truck')
                                            <i class="fas fa-truck fa-lg" style="color: var(--primary-blue);"></i>
                                        @elseif($d->device_type == 'bike')
                                            <i class="fas fa-motorcycle fa-lg" style="color: var(--primary-blue);"></i>
                                        @elseif($d->device_type == 'personal')
                                            <i class="fas fa-user fa-lg" style="color: var(--primary-blue);"></i>
                                        @else
                                            <i class="fas fa-satellite fa-lg" style="color: var(--primary-blue);"></i>
                                        @endif
                                    </div>
                                    <div>
                                        <h6 class="mb-1">{{ $d->name ?? __('app.user.devices.unnamed_device') }}</h6>
                                        <small class="text-muted">{{ $d->model ?? __('app.user.devices.gps_tracker') }}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <code class="bg-light p-2 rounded admin-ltr" dir="ltr">{{ $d->imei }}</code>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border">{{ $d->deviceTypeLabel() }}</span>
                            </td>
                            <td data-field="live-status">
                                <div class="d-flex align-items-center">
                                    <div class="status-indicator me-2 {{ $liveStatus['dot'] }}"></div>
                                    <span class="badge {{ $liveStatus['class'] }}">{{ $liveStatus['label'] }}</span>
                                </div>
                            </td>
                            <td data-field="speed">
                                @if($latest)
                                    {{ number_format((float) ($latest->speed ?? 0), 0) }} {{ __('app.map.kmh_unit') }}
                                @else
                                    <span class="text-muted">{{ __('app.map.dash') }}</span>
                                @endif
                            </td>
                            <td data-field="last-update">
                                <small class="text-muted d-block">
                                    {{ $latest?->recorded_at?->diffForHumans() ?? __('app.user.devices.no_data_yet') }}
                                </small>
                            </td>
                            <td>
                                <span class="badge {{ $subStatus['class'] }}">{{ $subStatus['label'] }}</span>
                            </td>
                            <td>
                                @include('partials.device-status-badge', ['device' => $d])
                            </td>
                            <td>
                                <div class="d-flex justify-content-end gap-2">
                                    @if($canTrack)
                                        <a href="{{ $d->launchMapRoute() }}" class="btn btn-premium btn-sm">
                                            <i class="fas fa-map-marked-alt me-1"></i> {{ __('app.user.devices.track') }}
                                        </a>
                                    @else
                                        <button type="button" class="btn btn-secondary btn-sm" disabled title="{{ $lockTitle }}">
                                            <i class="fas fa-lock me-1"></i> {{ __('app.user.devices.map_locked') }}
                                        </button>
                                    @endif
                                    <button class="btn btn-outline-primary btn-sm edit-device-btn" data-device-id="{{ $d->id }}">
                                        <i class="fas fa-edit me-1"></i> {{ __('app.common.edit') }}
                                    </button>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr id="noDevicesRow">
                            <td colspan="8">
                                <div class="text-center py-5">
                                    <div class="mb-3">
                                        <i class="fas fa-satellite fa-4x text-muted opacity-25"></i>
                                    </div>
                                    <h5 class="text-muted mb-3">{{ __('app.user.devices.no_devices') }}</h5>
                                    <p class="text-muted mb-0">{{ __('app.user.devices.no_devices_desc') }}</p>
                                </div>
                            </td>
                        </tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
        </div>

    </div>


    <!-- Edit Device Modal -->
    <div class="modal fade" id="editDeviceModal" tabindex="-1" aria-labelledby="editDeviceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editDeviceModalLabel">
                        <i class="fas fa-edit me-2"></i> {{ __('app.user.devices.edit_modal_title') }}
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{{ __('app.forms.close') }}"></button>
                </div>
                <form id="editDeviceForm">
                    @csrf
                    @method('PUT')
                    <input type="hidden" id="editDeviceId" name="device_id">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">{{ __('app.user.devices.imei_label') }}</label>
                            <input type="text" class="form-control admin-ltr" dir="ltr" id="editDeviceIMEI" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="editDeviceName" class="form-label">{{ __('app.user.devices.name_label') }} *</label>
                            <input type="text" class="form-control" id="editDeviceName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="editDeviceType" class="form-label">{{ __('app.user.devices.type_label') }} *</label>
                            <select class="form-select" id="editDeviceType" name="device_type" required data-placeholder="{{ __('app.user.devices.type_placeholder') }}">
                                <option value="car">{{ __('app.forms.device_type_car') }}</option>
                                <option value="truck">{{ __('app.forms.device_type_truck') }}</option>
                                <option value="bike">{{ __('app.forms.device_type_bike') }}</option>
                                <option value="personal">{{ __('app.forms.device_type_personal') }}</option>
                                <option value="other">{{ __('app.forms.device_type_other') }}</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="editDeviceModel" class="form-label">{{ __('app.user.devices.model_label') }}</label>
                            <input type="text" class="form-control" id="editDeviceModel" name="model">
                        </div>
                        <div class="mb-3">
                            <label for="editDeviceDescription" class="form-label">{{ __('app.user.devices.description_label') }}</label>
                            <textarea class="form-control" id="editDeviceDescription" name="description" rows="2"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-premium" data-bs-dismiss="modal">{{ __('app.common.cancel') }}</button>
                        <button type="submit" class="btn btn-premium" id="updateDevice">
                            <i class="fas fa-save me-2"></i> {{ __('app.user.devices.update_device') }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

@endsection

@push('scripts')
    <script>
        window.USER_DEVICES_LIVE = {
            pollUrl: @json(route('user.devices.live-json')),
            pollMs: 5000,
            dash: @json(__('app.map.dash')),
            noData: @json(__('app.user.devices.no_data_yet')),
            kmh: @json(__('app.map.kmh_unit')),
        };
    </script>
    <script src="{{ protected_js('user-devices-live.js') }}"></script>
    <script>
document.addEventListener('DOMContentLoaded', function() {
            const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

            const baseUrl = '{{ url("/") }}';

            const deviceSearch = document.getElementById('deviceSearch');
            if (deviceSearch) {
                deviceSearch.addEventListener('input', function() {
                    const query = this.value.trim().toLowerCase();
                    document.querySelectorAll('.device-row').forEach(row => {
                        const haystack = row.getAttribute('data-search') || '';
                        row.style.display = !query || haystack.includes(query) ? '' : 'none';
                    });
                });
            }

            // Simple toast function
            function showToast(message, type = 'success') {
                // Create toast element
                const toast = document.createElement('div');
                toast.className = `toast align-items-center text-white bg-${type === 'success' ? 'success' : 'danger'} border-0`;
                toast.setAttribute('role', 'alert');
                toast.innerHTML = `
            <div class="d-flex">
                <div class="toast-body">${message}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        `;

                // Add to container
                let container = document.querySelector('.toast-container');
                if (!container) {
                    container = document.createElement('div');
                    container.className = 'toast-container position-fixed bottom-0 end-0 p-3';
                    document.body.appendChild(container);
                }
                container.appendChild(toast);

                // Show toast
                const bsToast = new bootstrap.Toast(toast);
                bsToast.show();

                // Remove after hide
                toast.addEventListener('hidden.bs.toast', function() {
                    this.remove();
                });
            }

            // Edit Device
            document.addEventListener('click', function(e) {
                if (e.target.closest('.edit-device-btn')) {
                    e.preventDefault();
                    const deviceId = e.target.closest('.edit-device-btn').getAttribute('data-device-id');
                    loadDeviceForEdit(deviceId);
                }
            });

            // Load device for editing
            function loadDeviceForEdit(deviceId) {
                fetch(`${baseUrl}/user/devices/${deviceId}/edit`, {
                    headers: {
                        'X-CSRF-TOKEN': csrfToken,
                        'Accept': 'application/json'
                    }
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            const device = data.device;
                            document.getElementById('editDeviceId').value = device.id;
                            document.getElementById('editDeviceIMEI').value = device.imei;
                            document.getElementById('editDeviceName').value = device.name;
                            document.getElementById('editDeviceType').value = device.device_type;
                            document.getElementById('editDeviceModel').value = device.model || '';
                            document.getElementById('editDeviceDescription').value = device.description || '';

                            new bootstrap.Modal(document.getElementById('editDeviceModal')).show();
                        } else {
                            showToast(data.message, 'error');
                        }
                    })
                    .catch(error => {
                        showToast('Failed to load device data', 'error');
                        console.error('Error:', error);
                    });
            }

            // Edit Device Form
            const editDeviceForm = document.getElementById('editDeviceForm');
            if (editDeviceForm) {
                editDeviceForm.addEventListener('submit', function(e) {
                    e.preventDefault();

                    const updateBtn = document.getElementById('updateDevice');
                    const originalText = updateBtn.innerHTML;
                    updateBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> ' + @json(__('app.user.devices.updating'));
                    updateBtn.disabled = true;

                    const deviceId = document.getElementById('editDeviceId').value;
                    const formData = new FormData(this);

                    fetch(`${baseUrl}/user/devices/${deviceId}`, {
                        method: 'POST',
                        headers: {
                            'X-CSRF-TOKEN': csrfToken,
                            'Accept': 'application/json',
                            'X-HTTP-Method-Override': 'PUT'
                        },
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                showToast(data.message);
                                bootstrap.Modal.getInstance(document.getElementById('editDeviceModal')).hide();
                                location.reload(); // Reload page to show updated device
                            } else {
                                showToast(data.message || 'Error updating device', 'error');
                            }
                        })
                        .catch(error => {
                            showToast('An error occurred. Please try again.', 'error');
                            console.error('Error:', error);
                        })
                        .finally(() => {
                            updateBtn.innerHTML = originalText;
                            updateBtn.disabled = false;
                        });
                });
            }
        });
    </script>
@endpush
