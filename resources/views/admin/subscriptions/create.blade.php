@extends('admin.layouts.app')
@section('title','Add Subscription')
@section('page-title','Add Subscription')

@section('content')
    <div class="card p-3">
        <form action="{{ route('admin.subscriptions.store') }}" method="POST">
            @include('admin.subscriptions._form', ['subscription' => null])
            <div class="d-flex gap-2 mt-2">
                <button class="btn btn-primary">{{ __('app.common.save') }}</button>
                <a href="{{ route('admin.subscriptions.index') }}" class="btn btn-outline-secondary">{{ __('app.common.cancel') }}</a>
            </div>
        </form>
    </div>
@endsection
