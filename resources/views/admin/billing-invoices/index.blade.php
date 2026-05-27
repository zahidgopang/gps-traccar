@extends('admin.layouts.app')
@section('title', __('app.billing.invoices'))
@section('page-title', __('app.billing.invoices'))

@section('content')
    @php $panel = $panel ?? 'admin'; @endphp
    <div class="admin-filter-bar d-flex flex-wrap gap-2 mb-3 align-items-end">
        <form method="GET" class="d-flex flex-wrap gap-2 align-items-end">
            <div>
                <label class="form-label small mb-1">{{ __('app.billing.invoice_type') }}</label>
                <select name="type" class="form-select form-select-sm">
                    <option value="all" @selected($type === 'all')>{{ __('app.common.all') }}</option>
                    <option value="platform" @selected($type === 'platform')>{{ __('app.billing.invoice_type_platform') }}</option>
                    <option value="client" @selected($type === 'client')>{{ __('app.billing.invoice_type_client') }}</option>
                </select>
            </div>
            <div>
                <label class="form-label small mb-1">{{ __('app.common.status') }}</label>
                <select name="status" class="form-select form-select-sm">
                    <option value="">{{ __('app.common.all') }}</option>
                    @foreach(['unpaid','due','partial','paid','overdue','cancelled'] as $s)
                        <option value="{{ $s }}" @selected(request('status') === $s)>{{ __('app.billing.status_' . $s) }}</option>
                    @endforeach
                </select>
            </div>
            <input type="text" name="q" value="{{ request('q') }}" class="form-control form-control-sm" placeholder="{{ __('app.billing.invoice_no') }}…">
            <button type="submit" class="btn btn-sm btn-primary">{{ __('app.common.filter') }}</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-hover table-sm">
            <thead>
            <tr>
                <th>{{ __('app.billing.invoice_no') }}</th>
                <th>{{ __('app.billing.invoice_type') }}</th>
                <th>{{ __('app.forms.client_company') }}</th>
                <th>{{ __('app.common.total') }}</th>
                <th>{{ __('app.billing.balance_due') }}</th>
                <th>{{ __('app.common.status') }}</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            @forelse($invoices as $inv)
                <tr>
                    <td><code>{{ $inv->invoice_no }}</code></td>
                    <td>{{ $inv->typeEnum()->label() }}</td>
                    <td>{{ $inv->client?->name ?? '—' }}</td>
                    <td>{{ number_format((float) $inv->total, 2) }} {{ $inv->currency }}</td>
                    <td>{{ number_format((float) $inv->balance_due, 2) }}</td>
                    <td><span class="badge bg-{{ $inv->statusEnum()->badgeClass() }}">{{ $inv->statusEnum()->label() }}</span></td>
                    <td class="text-end">
                        <a href="{{ route($panel . '.billing-invoices.show', $inv) }}" class="btn btn-sm btn-outline-secondary">{{ __('app.common.view') }}</a>
                    </td>
                </tr>
            @empty
                <tr><td colspan="7" class="text-muted">{{ __('app.billing.no_invoices') }}</td></tr>
            @endforelse
            </tbody>
        </table>
    </div>
    {{ $invoices->links() }}
@endsection
