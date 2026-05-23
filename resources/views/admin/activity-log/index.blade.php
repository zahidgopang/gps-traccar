@extends('admin.layouts.app')
@section('title', __('app.admin.activity_log.title'))
@section('page-title', __('app.admin.activity_log.page_title'))

@section('content')
    <div class="card p-3">
        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
            <div>
                <h5 class="mb-1">{{ __('app.admin.activity_log.heading') }}</h5>
                <p class="text-muted small mb-0">{{ __('app.admin.activity_log.subtitle') }}</p>
            </div>
        </div>

        <form method="GET" class="row g-2 mb-3">
            <div class="col-md-3">
                <input type="text" name="q" value="{{ request('q') }}" class="form-control form-control-sm"
                       placeholder="{{ __('app.forms.search_activity') }}">
            </div>
            <div class="col-md-2">
                <select name="event" class="form-select form-select-sm" data-search="false">
                    <option value="">{{ __('app.forms.all_events') }}</option>
                    @foreach(['created' => 'event_created', 'updated' => 'event_updated', 'deleted' => 'event_deleted'] as $ev => $key)
                        <option value="{{ $ev }}" @selected(request('event') === $ev)>{{ __('app.admin.activity_log.' . $key) }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <select name="causer_id" class="form-select form-select-sm">
                    <option value="">{{ __('app.forms.all_admins') }}</option>
                    @foreach($causers as $c)
                        <option value="{{ $c->id }}" @selected((string) request('causer_id') === (string) $c->id)>
                            {{ $c->name }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-2">
                <input type="date" name="from" value="{{ request('from') }}" class="form-control form-control-sm"
                       placeholder="{{ __('app.forms.date_from') }}">
            </div>
            <div class="col-md-2">
                <input type="date" name="to" value="{{ request('to') }}" class="form-control form-control-sm"
                       placeholder="{{ __('app.forms.date_to') }}">
            </div>
            <div class="col-md-1">
                <button type="submit" class="btn btn-primary btn-sm w-100">{{ __('app.common.filter') }}</button>
            </div>
        </form>

        <div class="table-responsive">
            <table class="table table-hover table-sm align-middle">
                <thead>
                <tr>
                    <th>{{ __('app.forms.when') }}</th>
                    <th>{{ __('app.forms.who') }}</th>
                    <th>{{ __('app.forms.event') }}</th>
                    <th>{{ __('app.forms.description') }}</th>
                    <th>{{ __('app.forms.subject') }}</th>
                    <th>{{ __('app.forms.details') }}</th>
                </tr>
                </thead>
                <tbody>
                @forelse($logs as $log)
                    @php
                        $props = $log->properties instanceof \Illuminate\Support\Collection
                            ? $log->properties->toArray()
                            : (array) ($log->properties ?? []);
                        $subjectLabel = '—';
                        if ($log->subject) {
                            $subjectLabel = class_basename($log->subject_type) . ' #' . $log->subject_id;
                            if (method_exists($log->subject, 'getAttribute')) {
                                $subjectLabel = $log->subject->name
                                    ?? $log->subject->email
                                    ?? $log->subject->imei
                                    ?? $subjectLabel;
                            }
                        }
                    @endphp
                    <tr>
                        <td class="text-nowrap">
                            <x-admin.ltr class="admin-ltr--block">
                                <span class="d-block">{{ $log->created_at->format('M d, Y') }}</span>
                                <small class="text-muted">{{ $log->created_at->format('H:i:s') }}</small>
                            </x-admin.ltr>
                        </td>
                        <td>
                            @if($log->causer)
                                <span class="fw-semibold">{{ $log->causer->name }}</span>
                                <small class="d-block text-muted"><x-admin.ltr>{{ $log->causer->email }}</x-admin.ltr></small>
                            @else
                                <span class="text-muted">{{ __('app.forms.system') }}</span>
                            @endif
                        </td>
                        <td>
                            @if($log->event)
                                <span class="badge bg-secondary">{{ $log->event }}</span>
                            @else
                                —
                            @endif
                        </td>
                        <td>{{ $log->description }}</td>
                        <td>
                            @if($log->subject_type)
                                <span class="badge bg-light text-dark border">
                                    {{ class_basename($log->subject_type) }}
                                </span>
                                <small class="d-block mt-1">{{ $subjectLabel }}</small>
                            @else
                                —
                            @endif
                        </td>
                        <td>
                            @if(!empty($props))
                                <button type="button" class="btn btn-outline-secondary btn-sm"
                                        data-bs-toggle="collapse" data-bs-target="#log-props-{{ $log->id }}">
                                    {{ __('app.forms.view') }}
                                </button>
                                <div class="collapse mt-2" id="log-props-{{ $log->id }}">
                                    <pre class="small mb-0 bg-light p-2 rounded admin-ltr" dir="ltr" style="max-height:120px;overflow:auto;text-align:left;">{{ json_encode($props, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) }}</pre>
                                </div>
                            @else
                                <span class="text-muted">—</span>
                            @endif
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="6" class="text-center text-muted py-4">{{ __('app.admin.activity_log.no_activity') }}</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>

        <div class="mt-3">
            {{ $logs->links() }}
        </div>
    </div>
@endsection
