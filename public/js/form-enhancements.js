/**
 * Global Select2 + Flatpickr for admin & user forms.
 */
(function (window, $) {
    'use strict';

    function shouldSkipSelect(el) {
        return el.classList.contains('no-select2')
            || el.id === 'dateRange'
            || el.closest('#dateRange');
    }

    function shouldSkipDate(el) {
        return el.classList.contains('no-flatpickr')
            || el.id === 'dateRange'
            || el.dataset.flatpickrManual !== undefined;
    }

    function isGlobalInitScope(root) {
        return !root || root === document || root === document.documentElement;
    }

    function initSelect2(root) {
        if (typeof $ === 'undefined' || !$.fn.select2) {
            return;
        }

        const $root = root ? $(root) : $(document);
        $root.find('select').each(function () {
            const el = this;
            const $el = $(el);

            if (shouldSkipSelect(el) || $el.hasClass('select2-hidden-accessible')) {
                return;
            }

            const placeholder = el.getAttribute('data-placeholder')
                || $el.find('option[value=""]').first().text()
                || 'Select an option';

            const options = {
                theme: 'bootstrap-5',
                width: '100%',
                placeholder: (placeholder || 'Select…').trim(),
                allowClear: !el.required,
                dropdownParent: $el.closest('.modal').length ? $el.closest('.modal') : $(document.body),
            };

            if (document.documentElement.getAttribute('dir') === 'rtl') {
                options.dir = 'rtl';
            }

            if (el.getAttribute('data-search') === 'false') {
                options.minimumResultsForSearch = Infinity;
            }

            try {
                $el.select2(options);
            } catch (e) {
                console.warn('Select2 init failed', e);
            }
        });
    }

    function initDatePickers(root) {
        if (typeof flatpickr === 'undefined') {
            return;
        }

        const scope = root || document;
        const globalScope = isGlobalInitScope(root);

        scope.querySelectorAll('input[type="date"], .js-date-picker').forEach((el) => {
            if (shouldSkipDate(el) || el._flatpickr) {
                return;
            }

            if (globalScope && el.closest('.modal')) {
                return;
            }

            const config = {
                dateFormat: 'Y-m-d',
                altInput: true,
                altFormat: 'M j, Y',
                allowInput: true,
                disableMobile: true,
                clickOpens: true,
            };

            if (el.dataset.mode === 'range') {
                config.mode = 'range';
                delete config.altInput;
                delete config.altFormat;
            }

            if (el.dataset.maxDate) {
                config.maxDate = el.dataset.maxDate;
            } else if (el.dataset.allowFuture !== 'true') {
                config.maxDate = 'today';
            }

            if (el.dataset.minDate) {
                config.minDate = el.dataset.minDate;
            }

            const modal = el.closest('.modal');
            if (modal) {
                config.appendTo = document.body;
            }

            try {
                flatpickr(el, config);
            } catch (e) {
                console.warn('Flatpickr init failed', e);
            }
        });
    }

    function init(root) {
        initSelect2(root);
        initDatePickers(root);
    }

    window.FormEnhancements = { init, initSelect2, initDatePickers };

    $(document).ready(function () {
        init();

        document.querySelectorAll('.modal').forEach((modal) => {
            modal.addEventListener('shown.bs.modal', function () {
                init(modal);
            });
        });
    });
})(window, window.jQuery);
