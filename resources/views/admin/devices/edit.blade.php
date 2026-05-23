@extends('admin.layouts.app')
@section('title','Edit Device')
@section('page-title','Edit Device')

@section('content')
    <div class="card p-3">
        <form action="{{ route('admin.devices.update', $device) }}" method="POST">
            @method('PUT')
            @include('admin.devices._form', ['device' => $device])
            <div class="d-flex gap-2">
                <button class="btn btn-primary" type="submit">Update</button>
                <a href="{{ route('admin.devices.index') }}" class="btn btn-outline-secondary">{{ __('app.common.cancel') }}</a>
            </div>
        </form>
    </div>
@endsection
