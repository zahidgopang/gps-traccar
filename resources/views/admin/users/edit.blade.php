@extends('admin.layouts.app')
@section('title','Edit User')
@section('page-title','Edit User')

@section('content')
    <div class="card p-3">
        <form method="POST" action="{{ route('admin.users.update', $user) }}">
            @method('PUT')
            @include('admin.users._form',['user'=>$user])
            <button class="btn btn-primary">Update</button>
            <a href="{{ route('admin.users.index') }}" class="btn btn-outline-secondary">{{ __('app.common.cancel') }}</a>
        </form>
    </div>
@endsection
