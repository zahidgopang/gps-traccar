@extends('admin.layouts.app')
@section('title','Add User')
@section('page-title','Add User')

@section('content')
    <div class="card p-3">
        <form method="POST" action="{{ route('admin.users.store') }}">
            @include('admin.users._form',['user'=>null])
            <button class="btn btn-primary">{{ __('app.common.save') }}</button>
            <a href="{{ route('admin.users.index') }}" class="btn btn-outline-secondary">{{ __('app.common.cancel') }}</a>
        </form>
    </div>
@endsection
