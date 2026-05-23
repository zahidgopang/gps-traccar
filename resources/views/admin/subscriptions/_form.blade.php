@csrf
<div class="mb-3">
    <label class="form-label">{{ __('app.forms.device') }}</label>
    <select name="device_id" class="form-select" required data-placeholder="{{ __('app.forms.select_device') }}">
        <option value="">{{ __('app.forms.select_device_option') }}</option>
        @foreach($devices as $d)
            <option value="{{ $d->id }}" {{ (old('device_id', $subscription->device_id ?? '') == $d->id) ? 'selected' : '' }}>
                {{ $d->name ?: __('app.admin.locations.unnamed') }} · IMEI {{ $d->imei }}
                @if($d->user) — {{ $d->user->name }}@endif
            </option>
        @endforeach
    </select>
    <small class="text-muted">{{ __('app.forms.subscription_device_hint') }}</small>
    @error('device_id') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.forms.plan') }}</label>
    <select name="plan" class="form-select" required data-placeholder="{{ __('app.forms.select_plan') }}">
        @php $plan = old('plan', $subscription->plan ?? 'Basic'); @endphp
        <option value="Basic" {{ $plan==='Basic'?'selected':'' }}>{{ __('app.forms.plan_basic') }}</option>
        <option value="Standard" {{ $plan==='Standard'?'selected':'' }}>{{ __('app.forms.plan_standard') }}</option>
        <option value="Premium" {{ $plan==='Premium'?'selected':'' }}>{{ __('app.forms.plan_premium') }}</option>
    </select>
    @error('plan') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.forms.starts_at') }}</label>
    <input type="text" name="starts_at"
           value="{{ old('starts_at', optional(optional($subscription)->starts_at)->toDateString()) }}"
           class="form-control js-date-picker" placeholder="{{ __('app.forms.select_start_date') }}" data-allow-future="true" autocomplete="off">
    @error('starts_at') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.forms.ends_at') }}</label>
    <input type="text" name="ends_at"
           value="{{ old('ends_at', optional(optional($subscription)->ends_at)->toDateString()) }}"
           class="form-control js-date-picker" placeholder="{{ __('app.forms.select_end_date') }}" data-allow-future="true" autocomplete="off">
    @error('ends_at') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.common.status') }}</label>
    @php $status = old('status', $subscription->status ?? 'active'); @endphp
    <select name="status" class="form-select" required data-search="false">
        <option value="active" {{ $status==='active'?'selected':'' }}>{{ __('app.common.active') }}</option>
        <option value="expired" {{ $status==='expired'?'selected':'' }}>{{ __('app.forms.expired') }}</option>
        <option value="cancelled" {{ $status==='cancelled'?'selected':'' }}>{{ __('app.forms.cancelled') }}</option>
    </select>
    @error('status') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>
