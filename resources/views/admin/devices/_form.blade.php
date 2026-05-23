@csrf
<div class="mb-3">
    <label class="form-label">{{ __('app.admin.devices.imei') }}</label>
    <input type="text" name="imei" value="{{ old('imei', $device->imei ?? '') }}" class="form-control admin-ltr" dir="ltr" required>
    @error('imei') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.admin.devices.name') }}</label>
    <input type="text" name="name" value="{{ old('name', $device->name ?? '') }}" class="form-control">
    @error('name') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.forms.device_type') }} <span class="text-danger">*</span></label>
    <select name="device_type" class="form-select" required data-search="false" data-placeholder="{{ __('app.forms.select_device_type') }}">
        @php $deviceType = old('device_type', $device->device_type ?? ''); @endphp
        <option value="" disabled {{ $deviceType === '' ? 'selected' : '' }}>{{ __('app.forms.select_device_type') }}</option>
        <option value="car" {{ $deviceType === 'car' ? 'selected' : '' }}>{{ __('app.forms.device_type_car') }}</option>
        <option value="truck" {{ $deviceType === 'truck' ? 'selected' : '' }}>{{ __('app.forms.device_type_truck') }}</option>
        <option value="bike" {{ $deviceType === 'bike' ? 'selected' : '' }}>{{ __('app.forms.device_type_bike') }}</option>
        <option value="personal" {{ $deviceType === 'personal' ? 'selected' : '' }}>{{ __('app.forms.device_type_personal') }}</option>
        <option value="other" {{ $deviceType === 'other' ? 'selected' : '' }}>{{ __('app.forms.device_type_other') }}</option>
    </select>
    @error('device_type') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.forms.assign_user') }}</label>
    <select name="user_id" class="form-select" data-placeholder="{{ __('app.forms.assign_user') }}">
        <option value="">{{ __('app.forms.none_option') }}</option>
        @foreach($users as $u)
            <option value="{{ $u->id }}" {{ (old('user_id', $device->user_id ?? '') == $u->id) ? 'selected' : '' }}>
                {{ $u->name }} ({{ $u->email }})
            </option>
        @endforeach
    </select>
    @error('user_id') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>

<div class="mb-3">
    <label class="form-label">{{ __('app.common.status') }}</label>
    <select name="status" class="form-select" required data-search="false">
        @php $status = old('status', $device->status ?? 'inactive'); @endphp
        <option value="active" {{ $status=='active' ? 'selected':'' }}>{{ __('app.common.active') }}</option>
        <option value="inactive" {{ $status=='inactive' ? 'selected':'' }}>{{ __('app.common.inactive') }}</option>
        <option value="blocked" {{ $status=='blocked' ? 'selected':'' }}>{{ __('app.common.blocked') }}</option>
    </select>
    @error('status') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
</div>
