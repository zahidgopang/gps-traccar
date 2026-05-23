@extends('admin.layouts.app')
@section('title', __('app.common.users'))
@section('page-title', __('app.admin.users.page_title'))

@push('styles')
    <style>
        .skel-cell {
            display: table-cell;
            background: linear-gradient(90deg, #f3f3f3 25%, #ececec 37%, #f3f3f3 63%);
            background-size: 400% 100%;
            animation: sh 1.2s linear infinite;
            height: 42px; padding:15px;
        }
        @keyframes sh { 0%{background-position:200% 0}100%{background-position:-200% 0} }
        .device-status-toggle .form-check-input { cursor: pointer; width: 2.5em; height: 1.25em; }
        .device-status-toggle .form-check-input:disabled { cursor: not-allowed; }
    </style>
@endpush

@section('content')
    <div class="card p-3">

        <div class="d-flex justify-content-between mb-3">
            <h5>{{ __('app.admin.users.title') }}</h5>
            <a href="{{ route('admin.users.create') }}" class="btn btn-primary btn-sm">{{ __('app.forms.add_user') }}</a>
        </div>

        <form class="d-flex mb-3" method="GET">
            <input name="q" value="{{ request('q') }}" class="form-control me-2" placeholder="{{ __('app.forms.search_name_email') }}">
            <button class="btn btn-outline-secondary btn-sm">{{ __('app.common.search') }}</button>
        </form>

        <!-- Skeleton -->
        <div id="skeleton-area">
            @for($i=0;$i<6;$i++)
                <div style="display:flex; gap:10px; margin-bottom:10px;">
                    <div class="skel-cell" style="width:25%"></div>
                    <div class="skel-cell" style="width:25%"></div>
                    <div class="skel-cell" style="width:20%"></div>
                    <div class="skel-cell" style="width:15%"></div>
                    <div class="skel-cell" style="width:15%"></div>
                </div>
            @endfor
        </div>

        <!-- Real data -->
        <div id="real-area" style="display:none;">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>{{ __('app.forms.name') }}</th>
                    <th>{{ __('app.forms.email') }}</th>
                    <th>{{ __('app.forms.role') }}</th>
                    <th>{{ __('app.common.status') }}</th>
                    <th>{{ __('app.forms.joined') }}</th>
                    <th>{{ __('app.common.actions') }}</th>
                </tr>
                </thead>
                <tbody>
                @foreach ($users as $u)
                    <tr>
                        <td>{{ $u->name }}</td>
                        <td><x-admin.ltr>{{ $u->email }}</x-admin.ltr></td>
                        <td>{{ $u->role }}</td>
                        <td>
                            @include('partials.account-status-toggle', [
                                'user' => $u,
                                'toggleUrl' => route('admin.users.toggle-status', $u),
                                'toggleDisabled' => $u->id === auth()->id() || $u->email === 'admin@demo.test',
                            ])
                        </td>
                        <td><x-admin.ltr>{{ $u->created_at?->diffForHumans() ?? '—' }}</x-admin.ltr></td>
                        <td>
                            <a href="{{ route('admin.users.edit',$u) }}" class="btn btn-sm btn-outline-primary">{{ __('app.common.edit') }}</a>

                            <form method="POST" action="{{ route('admin.users.destroy',$u) }}" class="d-inline delete-form">
                                @csrf @method('DELETE')
                                <button type="button" class="btn btn-sm btn-danger btn-delete">{{ __('app.common.delete') }}</button>
                            </form>
                        </td>
                    </tr>
                @endforeach
                </tbody>
            </table>

            <div class="mt-3">
                {{ $users->links() }}
            </div>
        </div>

    </div>
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="{{ protected_js('device-status-toggle.js') }}"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function(){
            skeleton = document.getElementById('skeleton-area');
            real = document.getElementById('real-area');
            skeleton.style.display = 'none';
            real.style.display = '';

            document.querySelectorAll('.btn-delete').forEach(btn => {
                btn.addEventListener('click', function(){
                    const form = this.closest('form');
                    Swal.fire({
                        title: @json(__('app.forms.delete_user_confirm')),
                        text: @json(__('app.common.cannot_undo')),
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: @json(__('app.common.delete')),
                        cancelButtonText: @json(__('app.common.cancel')),
                    }).then((r)=>{
                        if(r.isConfirmed){ form.submit(); }
                    });
                });
            });

            @if(session('success'))
            Swal.fire({toast:true,position:@json(($htmlDir ?? 'ltr') === 'rtl' ? 'top-start' : 'top-end'),icon:'success',title:"{{ session('success') }}",showConfirmButton:false,timer:2000});
            @endif
        });
    </script>
@endpush
