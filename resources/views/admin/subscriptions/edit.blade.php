@extends('admin.layouts.app')
@section('title','Edit Subscription')
@section('page-title','Edit Subscription')

@section('content')
    <div class="card p-3">
        <form action="{{ route('admin.subscriptions.update', $subscription) }}" method="POST">
            @method('PUT')
            @include('admin.subscriptions._form', ['subscription' => $subscription])
            <div class="d-flex gap-2 mt-2">
                <button class="btn btn-primary">Update</button>
                <a href="{{ route('admin.subscriptions.index') }}" class="btn btn-outline-secondary">{{ __('app.common.cancel') }}</a>
            </div>
        </form>
    </div>
@endsection
