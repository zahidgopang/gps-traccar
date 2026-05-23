@php
    $appI18n = [
        'areYouSure' => __('app.common.are_you_sure'),
        'cannotUndo' => __('app.common.cannot_undo'),
        'yesDelete' => __('app.common.yes_delete'),
        'cancel' => __('app.common.cancel'),
        'delete' => __('app.common.delete'),
        'save' => __('app.common.save'),
        'noData' => __('app.common.no_data'),
        'deleteUserConfirm' => __('app.forms.delete_user_confirm'),
        'searchPlaceholder' => __('app.forms.search_placeholder_datatable'),
        'recordsPerPage' => __('app.forms.records_per_page'),
        'darkModeEnabled' => __('app.forms.dark_mode_enabled'),
        'darkModeDisabled' => __('app.forms.dark_mode_disabled'),
        'on' => __('app.forms.on'),
        'beta' => __('app.forms.beta'),
        'online' => __('app.admin.navbar.online'),
        'users' => __('app.admin.navbar.users_stat'),
        'devices' => __('app.admin.navbar.devices_stat'),
        'isRtl' => ($htmlDir ?? 'ltr') === 'rtl',
        'adding' => __('app.user.devices.adding'),
        'updating' => __('app.user.devices.updating'),
        'close' => __('app.forms.close'),
    ];
@endphp
<script>
window.APP_I18N = @json($appI18n);
if (window.APP_I18N.isRtl) {
    document.documentElement.setAttribute('dir', 'rtl');
    document.documentElement.setAttribute('lang', @json($htmlLang ?? 'ar'));
}
</script>
