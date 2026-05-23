@csrf
<div class="mb-3">
    <label>{{ __('app.forms.name') }}</label>
    <input type="text" name="name" value="{{ old('name', $user->name ?? '') }}" class="form-control" required>
    @error('name') <small class="text-danger">{{ $message }}</small> @enderror
</div>

<div class="mb-3">
    <label>{{ __('app.forms.email') }}</label>
    <input type="email" name="email" value="{{ old('email', $user->email ?? '') }}" class="form-control admin-ltr" dir="ltr" required>
    @error('email') <small class="text-danger">{{ $message }}</small> @enderror
</div>

<div class="mb-3">
    <label>{{ __('app.forms.password') }}</label>
    <input type="password" name="password" class="form-control">
    <small>{{ __('app.forms.password_keep_hint') }}</small>
    @error('password') <small class="text-danger">{{ $message }}</small> @enderror
</div>

<div class="row mb-3">
    <div class="col-md-4">
        <label>{{ __('app.forms.country_code') }}</label>
        <input type="text" name="country_code" value="{{ old('country_code', $user->country_code ?? '') }}"
            class="form-control admin-ltr" dir="ltr" maxlength="6" placeholder="+966">
        @error('country_code') <small class="text-danger">{{ $message }}</small> @enderror
    </div>
    <div class="col-md-8">
        <label>{{ __('app.forms.phone') }}</label>
        <input type="text" name="phone" value="{{ old('phone', $user->phone ?? '') }}"
            class="form-control admin-ltr" dir="ltr" maxlength="20">
        @error('phone') <small class="text-danger">{{ $message }}</small> @enderror
    </div>
</div>

<div class="mb-3">
    <label>{{ __('app.forms.role') }}</label>
    <select name="role" class="form-select" data-search="false">
        @php $r = old('role',$user->role ?? 'user'); @endphp
        <option value="admin" {{ $r=='admin'?'selected':'' }}>{{ __('app.forms.role_admin') }}</option>
        <option value="user" {{ $r=='user'?'selected':'' }}>{{ __('app.forms.role_user') }}</option>
    </select>
</div>

<div class="mb-3">
    <label>{{ __('app.forms.account_status') }}</label>
    <select name="status" class="form-select" data-search="false">
        @php $st = old('status', $user->status ?? 'active'); @endphp
        <option value="active" {{ $st === 'active' ? 'selected' : '' }}>{{ __('app.common.active') }}</option>
        <option value="inactive" {{ $st === 'inactive' ? 'selected' : '' }}>{{ __('app.common.inactive') }}</option>
    </select>
    <small class="text-muted">{{ __('app.forms.inactive_user_hint') }}</small>
    @error('status') <small class="text-danger d-block">{{ $message }}</small> @enderror
</div>
