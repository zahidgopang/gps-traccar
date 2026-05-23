@extends('admin.layouts.app')
@section('title', __('app.common.subscriptions'))
@section('page-title', __('app.admin.subscriptions.page_title'))

@push('styles')
    <style>
        .skel-cell {
            display: table-cell;
            background: linear-gradient(90deg, #f3f3f3 25%, #ececec 37%, #f3f3f3 63%);
            background-size: 400% 100%;
            animation: sh 1.2s linear infinite;
            height: 42px; padding:15px;
            border-radius:6px;
        }
        @keyframes sh { 0%{background-position:200% 0}100%{background-position:-200% 0} }

        .badge-status { padding:.35rem .6rem; border-radius:999px; display:inline-block; font-size:.85rem; }
        .badge-active { background:#dff7e0; color:#2f7d3a; }
        .badge-expired { background:#f8d7da; color:#7a1a1a; }
        .badge-cancelled { background:#fff3cd; color:#7a5a1a; }
        .history-count {
            position: absolute;
            top: -4px;
            right: -4px;
            font-size: 0.65rem;
            min-width: 1.1rem;
            height: 1.1rem;
            line-height: 1.1rem;
        }

        #renewSubscriptionModal .renew-date-wrap {
            position: relative;
        }

        #renewSubscriptionModal .renew-date-wrap .form-control {
            padding-inline-end: 2.5rem;
            cursor: pointer;
        }

        #renewSubscriptionModal .renew-date-wrap .date-picker-icon {
            position: absolute;
            top: 50%;
            inset-inline-end: 0.75rem;
            transform: translateY(-50%);
            color: #64748b;
            pointer-events: none;
        }

        #renewSubscriptionModal .flatpickr-input[readonly] {
            background-color: #fff !important;
            cursor: pointer;
        }
    </style>
@endpush

@section('content')
    <div class="card p-3">
        <div class="d-flex justify-content-between mb-3">
            <h5>{{ __('app.admin.subscriptions.title') }}</h5>
            <a href="{{ route('admin.subscriptions.create') }}" class="btn btn-primary btn-sm">{{ __('app.forms.add_subscription') }}</a>
        </div>

        <form class="d-flex mb-3" method="GET">
            <input name="q" value="{{ request('q') }}" class="form-control me-2" placeholder="{{ __('app.forms.search_plan_device_user') }}">
            <button class="btn btn-outline-secondary btn-sm">{{ __('app.common.search') }}</button>
        </form>

        <div id="skeleton-area">
            @for($i=0;$i<6;$i++)
                <div style="display:flex; gap:10px; margin-bottom:10px;">
                    <div class="skel-cell" style="width:20%"></div>
                    <div class="skel-cell" style="width:25%"></div>
                    <div class="skel-cell" style="width:20%"></div>
                    <div class="skel-cell" style="width:20%"></div>
                    <div class="skel-cell" style="width:15%"></div>
                </div>
            @endfor
        </div>

        <div id="real-area" style="display:none;">
            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>{{ __('app.forms.device') }}</th>
                    <th>{{ __('app.forms.plan') }}</th>
                    <th>{{ __('app.forms.owner') }}</th>
                    <th>{{ __('app.forms.starts') }}</th>
                    <th>{{ __('app.forms.ends') }}</th>
                    <th>{{ __('app.common.status') }}</th>
                    <th class="text-end">{{ __('app.common.actions') }}</th>
                </tr>
                </thead>
                <tbody>
                @foreach($subs as $s)
                    @php
                        $displayStatus = $s->status;
                        $canRenew = $displayStatus === 'expired';
                    @endphp
                    <tr data-subscription-id="{{ $s->id }}">
                        <td>
                            <strong>{{ $s->device?->name ?? '—' }}</strong>
                            <small class="d-block text-muted">{{ $s->device?->imei }}</small>
                        </td>
                        <td>{{ $s->plan }}</td>
                        <td>{{ $s->user?->name ?? '—' }}</td>
                        <td class="sub-starts">{{ optional($s->starts_at)->format('d M Y') ?? '—' }}</td>
                        <td class="sub-ends">{{ optional($s->ends_at)->format('d M Y') ?? '—' }}</td>
                        <td class="sub-status">
                            @if($displayStatus === 'active')
                                <span class="badge-status badge-active">{{ __('app.common.active') }}</span>
                            @elseif($displayStatus === 'expired')
                                <span class="badge-status badge-expired">{{ __('app.forms.expired') }}</span>
                            @else
                                <span class="badge-status badge-cancelled">{{ __('app.forms.cancelled') }}</span>
                            @endif
                        </td>
                        <td class="text-end">
                            <div class="d-inline-flex align-items-center gap-1 flex-wrap justify-content-end">
                                @if($canRenew)
                                    <button type="button"
                                            class="btn btn-sm btn-success btn-renew-sub"
                                            data-id="{{ $s->id }}"
                                            data-plan="{{ $s->plan }}"
                                            data-device="{{ $s->device?->name ?? 'Device' }}"
                                            data-renew-url="{{ route('admin.subscriptions.renew', $s) }}">
                                        <i class="fas fa-redo me-1"></i> {{ __('app.forms.renew') }}
                                    </button>
                                @endif

                                <button type="button"
                                        class="btn btn-sm btn-outline-secondary btn-history-sub position-relative"
                                        title="{{ __('app.forms.subscription_history') }}"
                                        data-id="{{ $s->id }}"
                                        data-history-url="{{ route('admin.subscriptions.histories', $s) }}">
                                    <i class="fas fa-history"></i>
                                    @if($s->histories_count > 0)
                                        <span class="badge rounded-pill bg-primary history-count">{{ $s->histories_count }}</span>
                                    @endif
                                </button>

                                <a href="{{ route('admin.subscriptions.edit', $s) }}" class="btn btn-sm btn-outline-primary">{{ __('app.common.edit') }}</a>

                                <form action="{{ route('admin.subscriptions.destroy', $s) }}" method="POST" class="d-inline delete-form">
                                    @csrf @method('DELETE')
                                    <button type="button" class="btn btn-sm btn-danger btn-delete">{{ __('app.common.delete') }}</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                @endforeach
                </tbody>
            </table>

            <div class="mt-3">
                {{ $subs->links() }}
            </div>
        </div>
    </div>

    {{-- Renew modal --}}
    <div class="modal fade" id="renewSubscriptionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="renewSubscriptionForm">
                    @csrf
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-redo me-2 text-success"></i> {{ __('app.forms.renew_subscription') }}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="{{ __('app.forms.close') }}"></button>
                    </div>
                    <div class="modal-body">
                        <p class="text-muted small mb-3" id="renewSubSummary"></p>
                        <p class="small mb-3">
                            {{ __('app.forms.renew_hint') }}
                        </p>
                        <div class="mb-3">
                            <label class="form-label" for="renewStartsAt">{{ __('app.forms.start_date') }} <span class="text-danger">*</span></label>
                            <div class="renew-date-wrap">
                                <input type="text" name="starts_at" id="renewStartsAt" class="form-control js-renew-date" required
                                       data-allow-future="true" autocomplete="off" placeholder="{{ __('app.forms.select_start_date') }}">
                                <i class="fas fa-calendar-alt date-picker-icon" aria-hidden="true"></i>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="renewEndsAt">{{ __('app.forms.end_date') }} <span class="text-danger">*</span></label>
                            <div class="renew-date-wrap">
                                <input type="text" name="ends_at" id="renewEndsAt" class="form-control js-renew-date" required
                                       data-allow-future="true" autocomplete="off" placeholder="{{ __('app.forms.select_end_date') }}">
                                <i class="fas fa-calendar-alt date-picker-icon" aria-hidden="true"></i>
                            </div>
                        </div>
                        <div id="renewFormError" class="alert alert-danger d-none small mb-0"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">{{ __('app.common.cancel') }}</button>
                        <button type="submit" class="btn btn-success" id="renewSubmitBtn">
                            <i class="fas fa-check me-1"></i> {{ __('app.forms.submit_renewal') }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    {{-- History modal --}}
    <div class="modal fade" id="subscriptionHistoryModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-history me-2"></i> Subscription history</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="historyLoading" class="text-center py-4 text-muted">
                        <i class="fas fa-spinner fa-spin me-2"></i> Loading history…
                    </div>
                    <div id="historyContent" class="d-none">
                        <div class="mb-3 p-3 bg-light rounded" id="historyCurrentBlock"></div>
                        <div class="table-responsive">
                            <table class="table table-sm table-hover mb-0">
                                <thead>
                                <tr>
                                    <th>Plan</th>
                                    <th>Starts</th>
                                    <th>Ends</th>
                                    <th>Status</th>
                                    <th>Archived</th>
                                    <th>By</th>
                                </tr>
                                </thead>
                                <tbody id="historyTableBody"></tbody>
                            </table>
                        </div>
                        <p id="historyEmpty" class="text-muted small mb-0 d-none">No previous subscription periods archived yet.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('skeleton-area').style.display = 'none';
            document.getElementById('real-area').style.display = '';

            const csrf = document.querySelector('meta[name="csrf-token"]')?.content || '';
            const renewModalEl = document.getElementById('renewSubscriptionModal');
            const renewModal = renewModalEl ? new bootstrap.Modal(renewModalEl) : null;
            const historyModalEl = document.getElementById('subscriptionHistoryModal');
            const historyModal = historyModalEl ? new bootstrap.Modal(historyModalEl) : null;

            let renewUrl = '';
            let renewDefaultDates = null;

            document.querySelectorAll('.btn-renew-sub').forEach((btn) => {
                btn.addEventListener('click', function () {
                    renewUrl = this.dataset.renewUrl;
                    document.getElementById('renewSubSummary').textContent =
                        `${this.dataset.plan} · ${this.dataset.device}`;
                    document.getElementById('renewFormError').classList.add('d-none');
                    document.getElementById('renewSubscriptionForm').reset();

                    const today = new Date();
                    const nextYear = new Date(today);
                    nextYear.setFullYear(nextYear.getFullYear() + 1);
                    renewDefaultDates = { start: today, end: nextYear };

                    renewModal?.show();
                });
            });

            function getRenewDateValue(id) {
                const el = document.getElementById(id);
                if (!el) return '';
                if (el._flatpickr) {
                    return el._flatpickr.input.value;
                }
                return el.value.trim();
            }

            function destroyRenewPickers() {
                renewModalEl?.querySelectorAll('.js-renew-date').forEach(function (el) {
                    if (el._flatpickr) {
                        el._flatpickr.destroy();
                    }
                });
            }

            function initRenewDatePickers() {
                if (!renewModalEl || typeof flatpickr === 'undefined') {
                    return;
                }
                destroyRenewPickers();

                const pickerConfig = {
                    dateFormat: 'Y-m-d',
                    altInput: true,
                    altFormat: 'M j, Y',
                    allowInput: true,
                    disableMobile: true,
                    clickOpens: true,
                    appendTo: document.body,
                };

                const startEl = document.getElementById('renewStartsAt');
                const endEl = document.getElementById('renewEndsAt');
                if (!startEl || !endEl) {
                    return;
                }

                flatpickr(startEl, {
                    ...pickerConfig,
                    defaultDate: renewDefaultDates?.start || 'today',
                    onChange: function (selectedDates) {
                        if (endEl._flatpickr && selectedDates[0]) {
                            endEl._flatpickr.set('minDate', selectedDates[0]);
                        }
                    },
                });

                flatpickr(endEl, {
                    ...pickerConfig,
                    defaultDate: renewDefaultDates?.end || null,
                    minDate: renewDefaultDates?.start || 'today',
                });
            }

            renewModalEl?.addEventListener('shown.bs.modal', initRenewDatePickers);

            renewModalEl?.addEventListener('hidden.bs.modal', destroyRenewPickers);

            document.body.addEventListener('show.bs.modal', function () {
                document.getElementById('sidebarOverlay')?.classList.remove('show');
            });

            document.getElementById('renewSubscriptionForm')?.addEventListener('submit', async function (e) {
                e.preventDefault();
                const errEl = document.getElementById('renewFormError');
                const submitBtn = document.getElementById('renewSubmitBtn');
                errEl.classList.add('d-none');
                submitBtn.disabled = true;

                try {
                    const res = await fetch(renewUrl, {
                        method: 'POST',
                        headers: {
                            'X-CSRF-TOKEN': csrf,
                            Accept: 'application/json',
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            starts_at: getRenewDateValue('renewStartsAt'),
                            ends_at: getRenewDateValue('renewEndsAt'),
                        }),
                    });
                    const data = await res.json();
                    if (!res.ok || !data.success) {
                        throw new Error(data.message || 'Renewal failed.');
                    }
                    renewModal?.hide();
                    Swal.fire({
                        toast: true,
                        position: 'top-end',
                        icon: 'success',
                        title: data.message,
                        showConfirmButton: false,
                        timer: 2200,
                    }).then(() => location.reload());
                } catch (err) {
                    errEl.textContent = err.message;
                    errEl.classList.remove('d-none');
                } finally {
                    submitBtn.disabled = false;
                }
            });

            document.querySelectorAll('.btn-history-sub').forEach((btn) => {
                btn.addEventListener('click', async function () {
                    const url = this.dataset.historyUrl;
                    document.getElementById('historyLoading').classList.remove('d-none');
                    document.getElementById('historyContent').classList.add('d-none');
                    historyModal?.show();

                    try {
                        const res = await fetch(url, { headers: { Accept: 'application/json' } });
                        const data = await res.json();
                        if (!res.ok) throw new Error('Could not load history.');

                        const sub = data.subscription;
                        document.getElementById('historyCurrentBlock').innerHTML = `
                            <strong>${sub.device?.name ?? 'Device'}</strong>
                            <small class="d-block text-muted">IMEI ${sub.device?.imei ?? '—'} · ${sub.user?.name ?? '—'}</small>
                            <div class="mt-2 small">
                                <span class="badge bg-primary me-1">Current</span>
                                <strong>${sub.plan}</strong> · ${sub.current.starts_at ?? '—'} → ${sub.current.ends_at ?? '—'}
                                · <span class="text-capitalize">${sub.current.status}</span>
                            </div>`;

                        const tbody = document.getElementById('historyTableBody');
                        tbody.innerHTML = '';
                        const empty = document.getElementById('historyEmpty');

                        if (!data.histories.length) {
                            empty.classList.remove('d-none');
                        } else {
                            empty.classList.add('d-none');
                            data.histories.forEach((h) => {
                                const tr = document.createElement('tr');
                                tr.innerHTML = `
                                    <td>${h.plan ?? '—'}</td>
                                    <td>${h.starts_at}</td>
                                    <td>${h.ends_at}</td>
                                    <td><span class="badge-status badge-${h.status === 'active' ? 'active' : (h.status === 'expired' ? 'expired' : 'cancelled')}">${h.status}</span></td>
                                    <td>${h.archived_at}</td>
                                    <td>${h.archived_by}</td>`;
                                tbody.appendChild(tr);
                            });
                        }

                        document.getElementById('historyLoading').classList.add('d-none');
                        document.getElementById('historyContent').classList.remove('d-none');
                    } catch (err) {
                        historyModal?.hide();
                        Swal.fire({ icon: 'error', title: 'Error', text: err.message });
                    }
                });
            });

            document.querySelectorAll('.btn-delete').forEach((btn) => {
                btn.addEventListener('click', function () {
                    const form = this.closest('form');
                    Swal.fire({
                        title: 'Delete subscription?',
                        text: 'This will delete the subscription record permanently.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Delete',
                    }).then((r) => {
                        if (r.isConfirmed) form.submit();
                    });
                });
            });

            @if(session('success'))
            Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: @json(session('success')), showConfirmButton: false, timer: 2000 });
            @endif
        });
    </script>
@endpush
