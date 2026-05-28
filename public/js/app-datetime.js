/**
 * FalconEyeGPS — Pakistan (Asia/Karachi) date/time formatting for web UI.
 */
(function (global) {
    'use strict';

    const TZ = 'Asia/Karachi';

    function parseDate(value) {
        if (!value) return null;
        const d = value instanceof Date ? value : new Date(value);
        return Number.isNaN(d.getTime()) ? null : d;
    }

    function capitalizeAmPm(text) {
        return String(text).replace(/\b(am|pm)\b/gi, (m) => m.toUpperCase());
    }

    /** 29 May 2026, 10:35 AM */
    function formatDateTime(value) {
        const d = parseDate(value);
        if (!d) return '—';
        const parts = new Intl.DateTimeFormat('en-GB', {
            timeZone: TZ,
            day: 'numeric',
            month: 'short',
            year: 'numeric',
            hour: 'numeric',
            minute: '2-digit',
            hour12: true,
        }).formatToParts(d);

        const get = (type) => parts.find((p) => p.type === type)?.value ?? '';
        const day = get('day');
        const month = get('month');
        const year = get('year');
        const hour = get('hour');
        const minute = get('minute');
        const dayPeriod = get('dayPeriod').toUpperCase();

        return `${day} ${month} ${year}, ${hour}:${minute} ${dayPeriod}`;
    }

    /** 29-May-2026 10:35 AM */
    function formatDateTimeShort(value) {
        const d = parseDate(value);
        if (!d) return '—';
        const parts = new Intl.DateTimeFormat('en-GB', {
            timeZone: TZ,
            day: '2-digit',
            month: 'short',
            year: 'numeric',
            hour: 'numeric',
            minute: '2-digit',
            hour12: true,
        }).formatToParts(d);

        const get = (type) => parts.find((p) => p.type === type)?.value ?? '';
        const day = get('day').padStart(2, '0');
        const month = get('month');
        const year = get('year');
        const hour = get('hour');
        const minute = get('minute');
        const dayPeriod = get('dayPeriod').toUpperCase();

        return `${day}-${month}-${year} ${hour}:${minute} ${dayPeriod}`;
    }

    /** 10:35 AM */
    function formatTime(value) {
        const d = parseDate(value);
        if (!d) return '—';
        return capitalizeAmPm(
            new Intl.DateTimeFormat('en-US', {
                timeZone: TZ,
                hour: 'numeric',
                minute: '2-digit',
                hour12: true,
            }).format(d)
        );
    }

    /** 29 May 2026 */
    function formatDate(value) {
        const d = parseDate(value);
        if (!d) return '—';
        const parts = new Intl.DateTimeFormat('en-GB', {
            timeZone: TZ,
            day: 'numeric',
            month: 'short',
            year: 'numeric',
        }).formatToParts(d);

        const get = (type) => parts.find((p) => p.type === type)?.value ?? '';
        return `${get('day')} ${get('month')} ${get('year')}`;
    }

    global.AppDateTime = {
        TZ,
        formatDateTime,
        formatDateTimeShort,
        formatTime,
        formatDate,
    };
})(typeof window !== 'undefined' ? window : globalThis);
