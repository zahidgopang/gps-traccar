@extends('admin.layouts.app')
@section('title','Add Device')
@section('page-title','Add Device')

@section('content')
    <div class="card p-3">
        <form action="{{ route('admin.devices.store') }}" method="POST">
            @include('admin.devices._form', ['device' => null])
            <div class="d-flex gap-2">
                <button class="btn btn-primary" type="submit">{{ __('app.common.save') }}</button>
                <a href="{{ route('admin.devices.index') }}" class="btn btn-outline-secondary">{{ __('app.common.cancel') }}</a>
            </div>
        </form>
    </div>
@endsection
