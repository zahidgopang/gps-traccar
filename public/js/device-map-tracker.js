/**
 * GPS device map tracker — live updates, history, alerts
 */
(function () {
    'use strict';

    const cfg = window.DEVICE_MAP_CONFIG || {};
    const i18n = cfg.i18n || {};
    const mi = (key, fallback) => (i18n[key] != null && i18n[key] !== '' ? i18n[key] : fallback);
    const dash = () => mi('dash', '—');
    const deviceId = cfg.deviceId;
    const baseUrl = cfg.baseUrl || '';
    const csrfToken = cfg.csrfToken || '';
    const api = cfg.apiRoutes || {};
    const mapToken = cfg.mapToken || '';
    const liveUrl = api.live || (mapToken ? `${baseUrl}/user/device/${mapToken}/live-json` : '');
    const historyUrl = api.history || (mapToken ? `${baseUrl}/user/device/${mapToken}/history-json` : '');
    const alertsUrl = cfg.alertsUrl || api.alerts || (mapToken ? `${baseUrl}/user/device/${mapToken}/alerts-json` : '');
    const reverseGeocodeUrl = api.reverseGeocode || (mapToken ? `${baseUrl}/user/device/${mapToken}/reverse-geocode` : '');
    const geofencesUrl = api.geofences || (mapToken ? `${baseUrl}/user/device/${mapToken}/geofences-json` : '');
    const geofencesSaveUrl = api.geofencesSave || (mapToken ? `${baseUrl}/user/device/${mapToken}/geofences-save` : '');
    const geofenceDestroyBase = api.geofenceDestroy || `${baseUrl}/user/geofence`;
    const geofenceUpdateBase = api.geofenceUpdate || `${baseUrl}/user/geofence`;
    const accessDeniedRedirect = api.accessDeniedRedirect || `${baseUrl}/user/devices`;
    const overSpeedLimit = cfg.overSpeedLimit || 80;
    const lowBatteryThreshold = cfg.lowBatteryThreshold || 20;
    const movingSpeedKmh = cfg.movingSpeedKmh ?? 5;
    const idleSpeedKmh = cfg.idleSpeedKmh ?? 0.5;
    const parkedIconSpeedKmh = cfg.parkedIconSpeedKmh ?? 0.1;
    const motionDetectKm = cfg.motionDetectKm ?? 0.004;
    const onlineTimeoutMs = (cfg.onlineMinutes || 5) * 60 * 1000;
    const pollIntervalMs = cfg.pollIntervalMs || 5000;

    let map, drawingManager, trafficLayer, customInfoWindow;
    let geofences = [];
    let polylines = [];
    let realtimePolylines = [];
    let markers = [];
    let currentPositionMarker = null;
    let startMarker = null;
    let currentDrawing = null;
    let playbackPoints = [];
    let playbackTimer, playbackIndex = 0, isPlaying = false, playbackSpeed = 1;
    let playbackMarker = null;
    let followVehicle = true;
    let flatpickrInstance;
    let historyData = [];
    let lastRealtimePoint = null;
    let lastTelemetry = null;
    let pollTimer = null;
    let alertState = {};
    let offlineTimer = null;
    let heatmapLayer = null;
    let stopMarkers = [];
    let showsStops = false;
    let nightModeOn = false;
    let addressFetchTimer = null;
    let lastAddressKey = '';
    const navAlertStore = [];
    const NAV_ALERT_LIMIT = 12;
    let lastAlertEventId = 0;
    const seenAlertIds = new Set();
    let alertsBootstrapped = false;
    let unreadAlertCount = 0;

    const MAP_BOOT_MAX = 4;
    const MAP_READY_TIMEOUT_MS = 12000;
    const MAP_HEALTH_INTERVAL_MS = 20000;
    let mapReady = false;
    let mapBootAttempts = 0;
    let mapBootRunning = false;
    let mapControlsBound = false;
    let mapDataStarted = false;
    let mapHealthTimer = null;
    let mapResizeObserver = null;
    let lastAppliedPositionKey = '';
    let livePollTimer = null;
    let alertsPollTimer = null;

    function sleep(ms) {
        return new Promise((resolve) => setTimeout(resolve, ms));
    }

    const NIGHT_MAP_STYLES = [
        { elementType: 'geometry', stylers: [{ color: '#1d2c4d' }] },
        { elementType: 'labels.text.fill', stylers: [{ color: '#8ec3b9' }] },
        { elementType: 'labels.text.stroke', stylers: [{ color: '#1a3646' }] },
        { featureType: 'road', elementType: 'geometry', stylers: [{ color: '#304a7d' }] },
        { featureType: 'road', elementType: 'geometry.stroke', stylers: [{ color: '#212a37' }] },
        { featureType: 'water', elementType: 'geometry', stylers: [{ color: '#0e1626' }] },
    ];

    function normalizePoint(raw) {
        if (!raw) return null;
        const lat = parseFloat(raw.lat ?? raw.latitude ?? 0);
        const lng = parseFloat(raw.lng ?? raw.longitude ?? 0);
        if (!lat || !lng || Number.isNaN(lat) || Number.isNaN(lng)) return null;

        const ts = raw.recorded_at || raw.timestamp || null;

        return {
            lat,
            lng,
            speed: parseFloat(raw.speed ?? 0),
            heading: parseFloat(raw.heading ?? 0),
            battery: raw.battery ?? raw.battery_level ?? null,
            ignition: raw.ignition === true || raw.ignition === 1 || raw.ignition === '1',
            gsm_signal: raw.gsm_signal ?? null,
            satellites: raw.satellites ?? null,
            odometer: raw.odometer ?? null,
            power_cut: raw.power_cut === true || raw.power_cut === 1,
            panic: raw.panic === true || raw.panic === 1,
            recorded_at: ts,
            position_id: raw.position_id != null ? Number(raw.position_id) : null,
        };
    }

    function positionKey(point) {
        if (!point) {
            return '';
        }
        if (point.position_id) {
            return `id:${point.position_id}`;
        }
        return `${point.recorded_at || ''}|${point.lat}|${point.lng}`;
    }

    function normalizeResponse(j) {
        if (!j) return [];
        if (Array.isArray(j)) return j;
        if (Array.isArray(j.locations)) return j.locations;
        if (Array.isArray(j.data)) return j.data;
        if (j.lat && j.lng) return [j];
        return [];
    }

    function haversineDistance(lat1, lng1, lat2, lng2) {
        const R = 6371, toRad = Math.PI / 180;
        const dLat = (lat2 - lat1) * toRad, dLng = (lng2 - lng1) * toRad;
        const a = Math.sin(dLat / 2) ** 2 + Math.cos(lat1 * toRad) * Math.cos(lat2 * toRad) * Math.sin(dLng / 2) ** 2;
        return 2 * R * Math.asin(Math.sqrt(a));
    }

    function bearingFromPoints(from, to) {
        const lat1 = from.lat * Math.PI / 180;
        const lat2 = to.lat * Math.PI / 180;
        const dLng = (to.lng - from.lng) * Math.PI / 180;
        const y = Math.sin(dLng) * Math.cos(lat2);
        const x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(dLng);
        return (Math.atan2(y, x) * 180 / Math.PI + 360) % 360;
    }

    function speedToColor(speed) {
        const spd = parseFloat(speed || 0);
        if (spd === 0) return '#9aa0a6';
        if (spd <= 40) return '#34a853';
        if (spd <= 60) return '#fbbc05';
        if (spd <= 80) return '#f97316';
        return '#ea4335';
    }

    function vehicleIcon(speed, heading) {
        const spd = parseFloat(speed || 0);
        if (spd <= parkedIconSpeedKmh) {
            return {
                url: cfg.stopIcon || '/images/stop.svg',
                scaledSize: new google.maps.Size(36, 36),
                anchor: new google.maps.Point(18, 18),
            };
        }
        return {
            path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
            scale: spd <= idleSpeedKmh ? 4.5 : 5,
            fillColor: spd <= idleSpeedKmh ? '#42a5f5' : '#1976D2',
            fillOpacity: 1,
            strokeColor: '#ffffff',
            strokeWeight: 1.5,
            rotation: parseFloat(heading || 0),
            anchor: new google.maps.Point(0, 2.5),
        };
    }

    function setText(id, value) {
        const el = document.getElementById(id);
        if (el) el.textContent = value;
    }

    function formatDurationLong(seconds) {
        const s = Math.max(0, Math.floor(seconds));
        const h = Math.floor(s / 3600);
        const m = Math.floor((s % 3600) / 60);
        if (h > 0) return `${h}h ${m}m`;
        return `${m}m`;
    }

    function effectiveSpeedKmh(point, previous) {
        const reported = parseFloat(point?.speed ?? 0);
        if (!previous || !point?.recorded_at || !previous.recorded_at) {
            return reported;
        }

        const distKm = haversineDistance(previous.lat, previous.lng, point.lat, point.lng);
        const elapsedMs = new Date(point.recorded_at).getTime() - new Date(previous.recorded_at).getTime();
        if (elapsedMs <= 0) {
            return reported;
        }

        const computed = (distKm / (elapsedMs / 3600000));
        if (!Number.isFinite(computed) || computed < 0) {
            return reported;
        }

        // Traccar often reports speed=0 while coordinates change — trust GPS motion.
        if (distKm >= motionDetectKm && (reported < idleSpeedKmh || computed > reported * 1.5)) {
            return Math.max(reported, computed);
        }

        return reported;
    }

    function enrichPointWithMotion(point, previous) {
        if (!previous) {
            return point;
        }

        const distKm = haversineDistance(previous.lat, previous.lng, point.lat, point.lng);
        const speed = effectiveSpeedKmh(point, previous);
        let heading = parseFloat(point.heading ?? 0);

        if (distKm >= motionDetectKm) {
            const travelBearing = bearingFromPoints(
                { lat: previous.lat, lng: previous.lng },
                { lat: point.lat, lng: point.lng }
            );
            if (!Number.isFinite(heading) || heading === 0 || speed <= idleSpeedKmh) {
                heading = travelBearing;
            }
        }

        if (speed === point.speed && heading === parseFloat(point.heading ?? 0)) {
            return point;
        }

        return { ...point, speed, heading };
    }

    function resolveVehicleStatus(point) {
        if (!point) {
            return { key: 'offline', label: mi('statusOffline', 'Offline'), cls: 'bg-secondary' };
        }

        const speed = parseFloat(point.speed || 0);

        if (point.power_cut) {
            return { key: 'alert', label: mi('statusPowerCut', 'Power cut'), cls: 'bg-danger' };
        }
        if (point.panic) {
            return { key: 'alert', label: mi('statusSos', 'SOS'), cls: 'bg-danger' };
        }
        if (speed > overSpeedLimit) {
            return { key: 'alert', label: mi('statusOverspeed', 'Overspeed'), cls: 'bg-warning text-dark' };
        }
        if (speed > movingSpeedKmh) {
            return { key: 'moving', label: mi('statusRunning', 'Running'), cls: 'bg-success' };
        }
        if (speed > idleSpeedKmh) {
            return { key: 'idle', label: mi('statusIdle', 'Idle'), cls: 'bg-info' };
        }
        if (point.ignition === true) {
            return { key: 'stopped', label: mi('statusStopped', 'Stopped'), cls: 'bg-warning text-dark' };
        }

        return { key: 'parked', label: mi('statusParked', 'Parked'), cls: 'bg-secondary' };
    }

    function getVehicleStatusKey(point) {
        return resolveVehicleStatus(point).key;
    }

    function setMapHudCollapsed(collapsed, persist) {
        const hud = document.getElementById('mapHud');
        const toggle = document.getElementById('mapHudToggle');
        if (!hud) return;
        hud.classList.toggle('is-collapsed', collapsed);
        toggle?.setAttribute('aria-expanded', collapsed ? 'false' : 'true');
        if (persist) {
            try {
                localStorage.setItem('mapHudCollapsed.' + deviceId, collapsed ? '1' : '0');
            } catch (e) { /* ignore */ }
        }
    }

    function initMapHudToggle() {
        const toggle = document.getElementById('mapHudToggle');
        if (!toggle) return;
        let startCollapsed = false;
        try {
            startCollapsed = localStorage.getItem('mapHudCollapsed.' + deviceId) === '1';
        } catch (e) { /* ignore */ }
        setMapHudCollapsed(startCollapsed, false);
        toggle.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            const hud = document.getElementById('mapHud');
            setMapHudCollapsed(!hud?.classList.contains('is-collapsed'), true);
        });
    }

    function updateMapHud(point) {
        if (!point) return;
        const speed = parseFloat(point.speed || 0);
        const speedText = speed.toFixed(0) + ' ' + mi('kmh', 'km/h');
        setText('hudSpeed', speedText);
        setText('hudMiniSpeed', speedText);
        setText('hudHeading', (point.heading ?? 0) + '°');
        setText('hudUpdated', point.recorded_at ? new Date(point.recorded_at).toLocaleTimeString() : dash());
        setText('hudCoords', point.lat.toFixed(5) + ', ' + point.lng.toFixed(5));

        const dot = document.getElementById('hudStatusDot');
        if (dot) {
            dot.className = 'map-hud__status-dot is-' + getVehicleStatusKey(point);
        }

        scheduleAddressLookup(point.lat, point.lng);
    }

    function scheduleAddressLookup(lat, lng) {
        const key = lat.toFixed(4) + ',' + lng.toFixed(4);
        if (key === lastAddressKey) return;
        clearTimeout(addressFetchTimer);
        addressFetchTimer = setTimeout(() => fetchAddressForHud(lat, lng, key), 1200);
    }

    async function fetchAddressForHud(lat, lng, key) {
        try {
            const res = await fetch(`${reverseGeocodeUrl}?lat=${lat}&lng=${lng}`);
            if (!res.ok) return;
            const data = await res.json();
            lastAddressKey = key;
            const addr = data.address || 'Address unavailable';
            setText('hudAddress', addr);
            setText('addressBox', addr);
        } catch (e) {
            setText('hudAddress', 'Could not load address');
        }
    }

    function getLivePosition() {
        if (currentPositionMarker) {
            const p = currentPositionMarker.getPosition();
            return { lat: p.lat(), lng: p.lng() };
        }
        if (lastTelemetry) return { lat: lastTelemetry.lat, lng: lastTelemetry.lng };
        return null;
    }

    function copyLiveCoords() {
        const pos = getLivePosition();
        if (!pos) return showNotification('No position available', 'error');
        const text = `${pos.lat.toFixed(6)}, ${pos.lng.toFixed(6)}`;
        navigator.clipboard?.writeText(text).then(() => showNotification('Coordinates copied', 'success'))
            .catch(() => showNotification(text, 'info', 'Coordinates'));
    }

    function openInGoogleMaps() {
        const pos = getLivePosition();
        if (!pos) return showNotification('No position available', 'error');
        window.open(`https://www.google.com/maps?q=${pos.lat},${pos.lng}`, '_blank');
    }

    function openStreetView() {
        const pos = getLivePosition();
        if (!pos) return showNotification('No position available', 'error');
        window.open(`https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=${pos.lat},${pos.lng}`, '_blank');
    }

    function analyzeRoute(data) {
        if (!data.length) return null;
        const stopMinSec = (cfg.stopMinMinutes || 2) * 60;
        let dist = 0, maxSpeed = 0, overspeedEvents = 0, movingSec = 0, stoppedSec = 0;
        const stops = [];
        let stopRun = [];

        const flushStop = () => {
            if (stopRun.length < 2) { stopRun = []; return; }
            const t0 = new Date(stopRun[0].recorded_at).getTime();
            const t1 = new Date(stopRun[stopRun.length - 1].recorded_at).getTime();
            const dur = (t1 - t0) / 1000;
            if (dur >= stopMinSec) {
                const mid = stopRun[Math.floor(stopRun.length / 2)];
                stops.push({
                    lat: mid.lat, lng: mid.lng, duration: dur,
                    start: stopRun[0].recorded_at, end: stopRun[stopRun.length - 1].recorded_at,
                });
            }
            stopRun = [];
        };

        for (let i = 1; i < data.length; i++) {
            const a = data[i - 1], b = data[i];
            dist += haversineDistance(a.lat, a.lng, b.lat, b.lng);
            const spd = parseFloat(b.speed || 0);
            if (spd > maxSpeed) maxSpeed = spd;
            if (spd > overSpeedLimit) overspeedEvents++;

            const t0 = a.recorded_at ? new Date(a.recorded_at).getTime() : null;
            const t1 = b.recorded_at ? new Date(b.recorded_at).getTime() : null;
            const dt = t0 && t1 && t1 > t0 ? (t1 - t0) / 1000 : 0;

            if (spd < 2) {
                stoppedSec += dt;
                stopRun.push(b);
            } else {
                movingSec += dt;
                flushStop();
            }
        }
        flushStop();

        const tStart = data[0].recorded_at ? new Date(data[0].recorded_at).getTime() : null;
        const tEnd = data[data.length - 1].recorded_at ? new Date(data[data.length - 1].recorded_at).getTime() : null;
        const totalSec = tStart && tEnd && tEnd > tStart ? (tEnd - tStart) / 1000 : 0;

        return { dist, maxSpeed, overspeedEvents, movingSec, stoppedSec, totalSec, stops };
    }

    function renderTripEvents(stops, overspeedEvents) {
        const list = document.getElementById('tripEventsList');
        const countEl = document.getElementById('tripEventsCount');
        if (!list) return;

        const items = [];
        stops.forEach((s, i) => {
            items.push({
                type: 'stop',
                title: `Parking stop #${i + 1}`,
                detail: formatDurationLong(s.duration) + ' · ' + (s.start ? new Date(s.start).toLocaleTimeString() : ''),
                lat: s.lat, lng: s.lng,
            });
        });
        if (overspeedEvents > 0) {
            items.unshift({
                type: 'overspeed',
                title: 'Overspeed detected',
                detail: `${overspeedEvents} segment(s) above ${overSpeedLimit} km/h`,
            });
        }

        if (countEl) countEl.textContent = String(items.length);
        if (!items.length) {
            list.innerHTML = '<div class="trip-event-empty text-muted small text-center py-3">No stops or events in this period</div>';
            return;
        }

        list.innerHTML = items.map((ev) => `
            <div class="trip-event-item trip-event-item--${ev.type}" data-lat="${ev.lat ?? ''}" data-lng="${ev.lng ?? ''}">
                <strong>${escapeHtml(ev.title)}</strong>
                <span>${escapeHtml(ev.detail)}</span>
            </div>`).join('');

        list.querySelectorAll('.trip-event-item[data-lat]').forEach((el) => {
            el.addEventListener('click', () => {
                const lat = parseFloat(el.dataset.lat);
                const lng = parseFloat(el.dataset.lng);
                if (!Number.isNaN(lat) && !Number.isNaN(lng)) {
                    map.panTo({ lat, lng });
                    map.setZoom(16);
                }
            });
        });
    }

    function clearStopMarkers() {
        stopMarkers.forEach((m) => m.setMap(null));
        stopMarkers = [];
    }

    function renderStopMarkers(stops) {
        clearStopMarkers();
        if (!showsStops || !stops.length) return;
        stops.forEach((s, i) => {
            const m = new google.maps.Marker({
                position: { lat: s.lat, lng: s.lng },
                map,
                title: `Stop ${i + 1} (${formatDurationLong(s.duration)})`,
                icon: {
                    url: cfg.parkingIcon || cfg.stopIcon || '/images/stop.svg',
                    scaledSize: new google.maps.Size(28, 28),
                    anchor: new google.maps.Point(14, 14),
                },
                zIndex: 500 + i,
            });
            m.addListener('click', () => {
                customInfoWindow.setContent(`
                    <div style="padding:8px;min-width:160px;">
                        <strong>Parking stop</strong><br>
                        <small>Duration: ${formatDurationLong(s.duration)}</small><br>
                        <small>${s.start ? new Date(s.start).toLocaleString() : ''}</small>
                    </div>`);
                customInfoWindow.setPosition({ lat: s.lat, lng: s.lng });
                customInfoWindow.open(map);
            });
            stopMarkers.push(m);
        });
    }

    let routeStops = [];

    function toggleStopMarkers() {
        showsStops = !showsStops;
        document.getElementById('btnStops')?.classList.toggle('active', showsStops);
        if (showsStops) renderStopMarkers(routeStops);
        else clearStopMarkers();
        showNotification(showsStops ? 'Parking stops shown' : 'Parking stops hidden', 'info');
    }

    function toggleHeatmap() {
        const btn = document.getElementById('btnHeatmap');
        const legend = document.getElementById('heatmapLegend');
        if (heatmapLayer) {
            heatmapLayer.setMap(null);
            heatmapLayer = null;
            btn?.classList.remove('active');
            if (legend) legend.style.display = 'none';
            return;
        }
        if (!historyData.length || !google.maps.visualization) {
            return showNotification('Load route history first', 'info');
        }
        const weighted = historyData.map((p) => ({
            location: new google.maps.LatLng(p.lat, p.lng),
            weight: Math.max(1, parseFloat(p.speed || 0)),
        }));
        heatmapLayer = new google.maps.visualization.HeatmapLayer({
            data: weighted,
            map,
            radius: 22,
            opacity: 0.65,
        });
        btn?.classList.add('active');
        if (legend) legend.style.display = 'block';
        showNotification('Speed-weighted heatmap enabled', 'info');
    }

    function toggleNightMode() {
        nightModeOn = !nightModeOn;
        document.getElementById('btnNightMode')?.classList.toggle('active', nightModeOn);
        map.setOptions({ styles: nightModeOn ? NIGHT_MAP_STYLES : [] });
    }

    function fitRouteBounds() {
        if (!historyData.length) return showNotification('Load route history first', 'info');
        const bounds = new google.maps.LatLngBounds();
        historyData.forEach((p) => bounds.extend({ lat: p.lat, lng: p.lng }));
        map.fitBounds(bounds, { top: 120, right: 80, bottom: 140, left: 320 });
    }

    function downloadFile(filename, content, mime) {
        const blob = new Blob([content], { type: mime });
        const a = document.createElement('a');
        a.href = URL.createObjectURL(blob);
        a.download = filename;
        a.click();
        URL.revokeObjectURL(a.href);
    }

    function exportRouteCsv() {
        if (!historyData.length) return showNotification('No route data to export', 'info');
        const header = 'lat,lng,speed,heading,recorded_at,battery,ignition,odometer';
        const rows = historyData.map((p) => [
            p.lat, p.lng, p.speed, p.heading, p.recorded_at || '',
            p.battery ?? '', p.ignition ? 1 : 0, p.odometer ?? '',
        ].join(','));
        downloadFile(`route-${deviceId}-${Date.now()}.csv`, [header, ...rows].join('\n'), 'text/csv');
        showNotification('CSV exported', 'success');
    }

    function exportRouteGpx() {
        if (!historyData.length) return showNotification('No route data to export', 'info');
        const pts = historyData.map((p) => {
            const t = p.recorded_at ? new Date(p.recorded_at).toISOString() : new Date().toISOString();
            return `      <trkpt lat="${p.lat}" lon="${p.lng}"><time>${t}</time><speed>${p.speed || 0}</speed></trkpt>`;
        }).join('\n');
        const gpx = `<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="FalconEyeGPS">
  <trk><name>${cfg.deviceName || 'Route'}</name><trkseg>
${pts}
  </trkseg></trk>
</gpx>`;
        downloadFile(`route-${deviceId}-${Date.now()}.gpx`, gpx, 'application/gpx+xml');
        showNotification('GPX exported', 'success');
    }

    function updateTelemetryUI(point) {
        if (!point) return;

        const speed = parseFloat(point.speed || 0);
        const battery = point.battery != null ? parseInt(point.battery, 10) : null;

        setText('lastSeen', point.recorded_at ? new Date(point.recorded_at).toLocaleString() : dash());
        setText('telemetrySpeed', speed.toFixed(0) + ' ' + mi('kmh', 'km/h'));
        setText('telemetryHeading', point.heading != null && point.heading !== '' ? point.heading + '°' : dash());
        setText('telemetryBattery', battery != null ? battery + '%' : dash());
        setText('telemetryIgnition', point.ignition != null ? (point.ignition ? mi('ignitionOn', 'ON') : mi('ignitionOff', 'OFF')) : dash());
        setText('telemetryGsm', point.gsm_signal != null ? point.gsm_signal + '%' : dash());
        setText('telemetrySatellites', point.satellites != null ? String(point.satellites) : dash());
        setText('telemetryOdometer', point.odometer != null ? Number(point.odometer).toLocaleString() + ' ' + mi('km', 'km') : dash());

        const statusEl = document.getElementById('curStatus');
        if (statusEl) {
            const status = resolveVehicleStatus(point);
            statusEl.innerHTML = `<span class="badge ${status.cls}">${status.label}</span>`;
        }

        const navStatus = document.getElementById('navLiveStatus');
        if (navStatus) {
            navStatus.innerHTML = statusEl ? statusEl.innerHTML : '<span class="badge bg-success">Live</span>';
        }

        updateMapHud(point);
    }

    let mapAccessDeniedHandled = false;

    async function parseJsonResponse(res) {
        try {
            return await res.json();
        } catch {
            return {};
        }
    }

    function handleMapAccessDenied(res, data) {
        if (cfg.isAdminMap) {
            return false;
        }
        if (res.status !== 403) {
            return false;
        }
        if (mapAccessDeniedHandled) {
            return true;
        }
        mapAccessDeniedHandled = true;
        const payload = data || {};
        const title = payload.title || 'Access restricted';
        const msg = payload.message || 'Map access is not available. Please resubscribe or contact support.';
        showNotification(msg, 'warning', title);
        const redirect = payload.redirect || accessDeniedRedirect;
        setTimeout(() => {
            window.location.href = redirect;
        }, 3500);
        return true;
    }

    function showNotification(msg, type = 'info', title = null) {
        const cont = document.getElementById('notificationContainer');
        if (!cont) return;

        const icons = { success: 'fa-check-circle', error: 'fa-exclamation-circle', warning: 'fa-exclamation-triangle', info: 'fa-info-circle' };
        const notif = document.createElement('div');
        notif.className = 'notification ' + type;
        notif.innerHTML = `
            <div class="notification-icon"><i class="fas ${icons[type] || icons.info}"></i></div>
            <div class="notification-content">
                <div class="notification-title">${title || type.toUpperCase()}</div>
                <div class="notification-message">${msg}</div>
            </div>
            <button type="button" class="notification-close"><i class="fas fa-times"></i></button>`;
        notif.className = 'notification ' + type;
        cont.prepend(notif);
        notif.querySelector('.notification-close')?.addEventListener('click', () => notif.remove());
        setTimeout(() => notif.remove(), 8000);
    }

    function updateNavAlertBadge(count) {
        unreadAlertCount = Math.max(0, count);
        const badge = document.getElementById('navAlertBadge');
        const btn = document.getElementById('navAlertsBtn');
        const summary = document.getElementById('navAlertsSummary');
        if (badge) {
            badge.textContent = unreadAlertCount > 99 ? '99+' : String(unreadAlertCount);
            badge.hidden = unreadAlertCount <= 0;
        }
        if (btn) btn.classList.toggle('has-unread', unreadAlertCount > 0);
        if (summary) {
            summary.textContent = unreadAlertCount > 0
                ? mi('alertsNewCount', `${unreadAlertCount} new`).replace(':count', String(unreadAlertCount))
                : mi('noNewAlerts', 'No new alerts');
        }
    }

    function geofenceLabelFromAlert(alert) {
        if (alert?.geofence) {
            return alert.geofence;
        }
        const m = (alert?.message || '').match(/geofence\s+"([^"]+)"/i);

        return m ? m[1] : '';
    }

    function isGeofenceAlert(alert) {
        return alert?.event_type === 'geofence_enter'
            || alert?.event_type === 'geofence_exit'
            || /geofenceEnter|geofenceExit/i.test(alert?.event_type || '');
    }

    function renderNavAlertsList() {
        const list = document.getElementById('navAlertsList');
        if (!list) return;
        if (!navAlertStore.length) {
            list.innerHTML = `<div class="nav-alerts-empty">${escapeHtml(mi('noAlertsYet', 'No alerts yet'))}</div>`;
            return;
        }
        list.innerHTML = navAlertStore.slice(0, NAV_ALERT_LIMIT).map((a) => {
            const d = a.time instanceof Date ? a.time : (a.time ? new Date(a.time) : null);
            const dateStr = d && !Number.isNaN(d.getTime()) ? d.toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' }) : '';
            const timeStr = d && !Number.isNaN(d.getTime()) ? d.toLocaleTimeString(undefined, { hour: '2-digit', minute: '2-digit', second: '2-digit' }) : '';
            const time = [dateStr, timeStr].filter(Boolean).join(' · ');
            const isGeofence = isGeofenceAlert(a);
            const zoneName = geofenceLabelFromAlert(a);
            const detail = zoneName
                ? `<span class="nav-alert-detail"><i class="fas fa-draw-polygon"></i> ${escapeHtml(zoneName)}</span>`
                : '';
            const coords = a.lat && a.lng
                ? `<span class="nav-alert-detail text-muted">${Number(a.lat).toFixed(5)}, ${Number(a.lng).toFixed(5)}</span>`
                : '';
            return `<div class="nav-alert-item nav-alert-item--${escapeHtml(a.type || 'info')}${isGeofence ? ' nav-alert-item--geofence' : ''}">
                <strong>${escapeHtml(a.title || 'Alert')}</strong>
                <span>${escapeHtml(a.message || '')}</span>
                ${detail}
                ${coords}
                <small>${escapeHtml(time)}</small>
            </div>`;
        }).join('');
    }

    function pushNavAlert(title, message, type, options = {}) {
        const countAsUnread = options.countAsUnread !== false;
        const id = options.id || 0;
        if (id && seenAlertIds.has(id)) {
            return;
        }
        if (id) {
            seenAlertIds.add(id);
            if (id > lastAlertEventId) {
                lastAlertEventId = id;
            }
        }
        navAlertStore.unshift({
            id,
            title: title || 'Alert',
            message: message || '',
            type: type || 'info',
            event_type: options.event_type || '',
            geofence: options.geofence || '',
            lat: options.lat,
            lng: options.lng,
            time: options.time ? new Date(options.time) : new Date(),
        });
        if (navAlertStore.length > 50) navAlertStore.pop();
        renderNavAlertsList();
        if (countAsUnread) updateNavAlertBadge(unreadAlertCount + 1);
    }

    function ingestAlertPayload(e, options = {}) {
        const notify = options.notify === true;
        const countAsUnread = options.countAsUnread !== false;
        const geofence = geofenceLabelFromAlert(e);
        pushNavAlert(e.title || 'Alert', e.message || '', e.type || 'info', {
            id: e.id,
            time: e.time,
            event_type: e.event_type,
            geofence,
            lat: e.lat,
            lng: e.lng,
            countAsUnread,
        });
        if (notify) {
            const gf = isGeofenceAlert(e);
            showNotification(e.message || e.title, gf ? 'warning' : (e.type || 'info'), e.title);
        }
    }

    function initNavAlerts() {
        const btn = document.getElementById('navAlertsBtn');
        const dropdown = document.getElementById('navAlertsDropdown');
        if (!btn || !dropdown) return;

        btn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            const open = !dropdown.classList.contains('show');
            dropdown.classList.toggle('show', open);
            btn.setAttribute('aria-expanded', open ? 'true' : 'false');
            if (open) {
                updateNavAlertBadge(0);
                loadRecentAlerts();
            }
        });

        document.addEventListener('click', (e) => {
            if (!e.target.closest('.nav-alerts-wrap')) {
                dropdown.classList.remove('show');
                btn.setAttribute('aria-expanded', 'false');
            }
        });
    }

    function triggerAlert(key, msg, type, title) {
        if (alertState[key]) return;
        alertState[key] = true;
        pushNavAlert(title, msg, type);
        showNotification(msg, type, title);
        setTimeout(() => { alertState[key] = false; }, 60000);
    }

    function evaluateAlerts(point, prev) {
        if (!point) return;

        if (point.panic) triggerAlert('panic', 'Emergency panic button activated!', 'error', 'SOS Alert');
        if (point.power_cut) triggerAlert('power', 'Device power has been cut.', 'error', 'Power Cut');
        if (point.battery != null && point.battery <= lowBatteryThreshold) {
            triggerAlert('battery', `Battery low: ${point.battery}%`, 'warning', 'Low Battery');
        }
        if (point.speed > overSpeedLimit) {
            triggerAlert('overspeed', `Speed ${point.speed.toFixed(0)} km/h exceeds ${overSpeedLimit} km/h`, 'warning', 'Overspeed');
        }
        if (prev && point.speed > 10 && !point.ignition) {
            triggerAlert('ignition', 'Vehicle moving with ignition OFF', 'warning', 'Ignition Alert');
        }
        if (prev) {
            const dist = haversineDistance(prev.lat, prev.lng, point.lat, point.lng);
            if (dist > 0.5 && point.speed < 2) {
                triggerAlert('jump', 'Possible GPS jump detected', 'info', 'GPS Anomaly');
            }
        }

        resetOfflineWatch(point);
    }

    function resetOfflineWatch(point) {
        if (offlineTimer) clearTimeout(offlineTimer);
        offlineTimer = setTimeout(() => {
            triggerAlert('offline', 'No GPS update received recently', 'warning', 'Device Offline');
            const statusEl = document.getElementById('curStatus');
            if (statusEl) {
                const offline = resolveVehicleStatus(null);
                statusEl.innerHTML = `<span class="badge ${offline.cls}">${offline.label}</span>`;
            }
        }, onlineTimeoutMs);
    }

    function updateCurrentMarker(point) {
        const position = { lat: point.lat, lng: point.lng };
        const icon = vehicleIcon(point.speed, point.heading);

        if (!currentPositionMarker) {
            currentPositionMarker = new google.maps.Marker({
                position,
                map,
                title: cfg.deviceName || cfg.mapDisplayTitle || 'Vehicle',
                icon,
                zIndex: 999,
            });
            markers.push(currentPositionMarker);
        } else {
            currentPositionMarker.setPosition(position);
            currentPositionMarker.setIcon(icon);
            currentPositionMarker.setTitle(cfg.deviceName || cfg.mapDisplayTitle || 'Vehicle');
        }

        if (followVehicle) map.panTo(position);
    }

    function drawRealtimeSegment(from, to, speed) {
        const seg = new google.maps.Polyline({
            path: [{ lat: from.lat, lng: from.lng }, { lat: to.lat, lng: to.lng }],
            strokeColor: speedToColor(speed),
            strokeOpacity: 0.9,
            strokeWeight: speed === 0 ? 2 : speed <= 40 ? 3 : speed <= 80 ? 4 : 5,
            clickable: false,
            map,
        });
        realtimePolylines.push(seg);
        if (realtimePolylines.length > 200) {
            realtimePolylines.shift().setMap(null);
        }
    }

    function applyLivePoint(raw) {
        let point = normalizePoint(raw);
        if (!point) return;

        point = enrichPointWithMotion(point, lastTelemetry);

        const key = positionKey(point);
        if (key && key === lastAppliedPositionKey) {
            return;
        }
        lastAppliedPositionKey = key;

        updateCurrentMarker(point);
        updateTelemetryUI(point);
        evaluateAlerts(point, lastTelemetry);

        if (lastRealtimePoint) drawRealtimeSegment(lastRealtimePoint, point, point.speed);

        lastRealtimePoint = { lat: point.lat, lng: point.lng };
        lastTelemetry = point;
    }

    async function pollLive() {
        try {
            const res = await fetch(liveUrl, { headers: { Accept: 'application/json' } });
            const data = await parseJsonResponse(res);
            if (handleMapAccessDenied(res, data)) return;
            if (!res.ok) return;
            if (data && data.lat) applyLivePoint(data);
            await pollNewAlerts();
        } catch (e) {
            console.warn('Live poll failed', e);
        }
    }

    function alertsFetchUrl(extraLimit, useAfterId) {
        const limit = extraLimit || NAV_ALERT_LIMIT;
        const params = new URLSearchParams({ limit: String(limit), bell: '1' });
        if (useAfterId !== false && lastAlertEventId > 0) {
            params.set('after_id', String(lastAlertEventId));
        }
        return `${alertsUrl}?${params.toString()}`;
    }

    function fetchAlerts(url) {
        return fetch(url, {
            credentials: 'same-origin',
            headers: {
                Accept: 'application/json',
                'X-Requested-With': 'XMLHttpRequest',
            },
        });
    }

    function hydrateAlertsFromConfig() {
        const items = Array.isArray(cfg.initialAlerts) ? cfg.initialAlerts : [];
        if (!items.length) {
            return false;
        }
        navAlertStore.length = 0;
        seenAlertIds.clear();
        lastAlertEventId = 0;
        items.forEach((e) => ingestAlertPayload(e, { countAsUnread: false }));
        sortNavAlertStore();
        renderNavAlertsList();
        const gfCount = navAlertStore.filter((a) => isGeofenceAlert(a)).length;
        if (gfCount > 0) {
            updateNavAlertBadge(gfCount);
        }
        alertsBootstrapped = true;
        return true;
    }

    function setupRealtime() {
        if (livePollTimer) {
            clearInterval(livePollTimer);
        }
        if (alertsPollTimer) {
            clearInterval(alertsPollTimer);
        }

        pollLive();
        livePollTimer = setInterval(() => pollLive(), pollIntervalMs);
        alertsPollTimer = setInterval(pollNewAlerts, pollIntervalMs);

        if (window.Echo && typeof window.Echo.private === 'function') {
            try {
                window.Echo.private(`device.${deviceId}`)
                    .listen('.DeviceLocationUpdated', (payload) => {
                        applyLivePoint(payload.location || payload);
                        pollNewAlerts();
                    });
            } catch (err) {
                console.warn('[device-map] Echo subscribe failed — using polling only', err);
            }
            return;
        }

        console.info('[device-map] Live updates via polling every', pollIntervalMs, 'ms');
    }

    function showLoading(msg) {
        const el = document.getElementById('loadingOverlay');
        if (el) {
            document.getElementById('loadingText').textContent = msg;
            el.classList.add('active');
        }
    }

    function hideLoading() {
        document.getElementById('loadingOverlay')?.classList.remove('active');
    }

    function hasGoogleMapDom(el) {
        return !!(el && el.querySelector('.gm-style'));
    }

    function waitForMapContainerSize(maxMs = 8000) {
        return new Promise((resolve, reject) => {
            const start = Date.now();
            const check = () => {
                const el = document.getElementById('map');
                const area = document.getElementById('mapArea');
                const target = el || area;
                if (target && target.offsetWidth >= 20 && target.offsetHeight >= 20) {
                    resolve();
                    return;
                }
                if (Date.now() - start > maxMs) {
                    reject(new Error('Map container not sized'));
                    return;
                }
                requestAnimationFrame(check);
            };
            check();
        });
    }

    function loadGoogleMapsApi() {
        return new Promise((resolve, reject) => {
            if (window.google?.maps?.Map) {
                resolve();
                return;
            }

            const key = cfg.googleMapsKey;
            if (!key) {
                reject(new Error('Missing Google Maps API key'));
                return;
            }

            const existing = document.querySelector('script[data-device-map-gmaps]');
            if (existing) {
                let tries = 0;
                (function waitExisting() {
                    if (window.google?.maps?.Map) {
                        resolve();
                    } else if (++tries > 120) {
                        reject(new Error('Google Maps API timeout'));
                    } else {
                        setTimeout(waitExisting, 100);
                    }
                })();
                return;
            }

            const script = document.createElement('script');
            script.dataset.deviceMapGmaps = '1';
            script.async = true;
            script.src = `https://maps.googleapis.com/maps/api/js?key=${encodeURIComponent(key)}&libraries=drawing,geometry,visualization,places&loading=async`;
            script.onerror = () => reject(new Error('Google Maps script failed to load'));
            script.onload = () => {
                let tries = 0;
                (function waitMaps() {
                    if (window.google?.maps?.Map) {
                        resolve();
                    } else if (++tries > 120) {
                        reject(new Error('Google Maps API unavailable'));
                    } else {
                        setTimeout(waitMaps, 50);
                    }
                })();
            };
            document.head.appendChild(script);
        });
    }

    function verifyMapRendered() {
        return new Promise((resolve, reject) => {
            if (!map) {
                reject(new Error('Map not initialized'));
                return;
            }

            const div = document.getElementById('map');
            if (!div || div.offsetWidth < 20 || div.offsetHeight < 20) {
                reject(new Error('Map container too small'));
                return;
            }

            if (hasGoogleMapDom(div)) {
                resolve();
                return;
            }

            let settled = false;
            const finish = (ok) => {
                if (settled) {
                    return;
                }
                settled = true;
                clearTimeout(timer);
                if (ok || hasGoogleMapDom(div)) {
                    resolve();
                } else {
                    reject(new Error('Map tiles did not render'));
                }
            };

            const timer = setTimeout(() => finish(hasGoogleMapDom(div)), MAP_READY_TIMEOUT_MS);

            google.maps.event.addListenerOnce(map, 'tilesloaded', () => finish(true));
            google.maps.event.addListenerOnce(map, 'idle', () => {
                setTimeout(() => finish(true), 250);
            });
            google.maps.event.trigger(map, 'resize');
        });
    }

    async function startMapDataServices() {
        try {
            await loadRecentAlerts();
            setupRealtime();
            await pollLive();
        } catch (err) {
            console.warn('[device-map] data services failed', err);
        }
    }

    function onMapTilesReady() {
        mapReady = true;
        hideLoading();
        resizeMap();
        if (!mapDataStarted) {
            mapDataStarted = true;
            startMapDataServices();
        }
        window.dispatchEvent(new CustomEvent('device-map-ready'));
    }

    function bindMapWatchers() {
        if (mapResizeObserver || typeof ResizeObserver === 'undefined') {
            return;
        }

        const area = document.getElementById('mapArea');
        if (!area) {
            return;
        }

        let resizeTimer;
        mapResizeObserver = new ResizeObserver(() => {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(() => {
                resizeMap();
                if (map && !mapReady) {
                    verifyMapRendered().then(onMapTilesReady).catch(() => {});
                }
            }, 150);
        });
        mapResizeObserver.observe(area);

        window.addEventListener('map-sidebar-toggled', () => {
            setTimeout(resizeMap, 400);
        });

        document.addEventListener('visibilitychange', () => {
            if (document.visibilityState !== 'visible' || !map) {
                return;
            }
            resizeMap();
            const div = document.getElementById('map');
            if (mapReady && div && !hasGoogleMapDom(div)) {
                mapReady = false;
                bootDeviceMap();
            }
        });

        if (mapHealthTimer) {
            clearInterval(mapHealthTimer);
        }
        mapHealthTimer = setInterval(() => {
            if (!map || mapBootRunning) {
                return;
            }
            const div = document.getElementById('map');
            if (mapReady && div && !hasGoogleMapDom(div)) {
                console.warn('[device-map] render health check failed — reloading map');
                mapReady = false;
                map = null;
                bootDeviceMap();
            }
        }, MAP_HEALTH_INTERVAL_MS);
    }

    function createMapInstance() {
        const initial = normalizePoint(cfg.initialPoint);
        const center = initial
            ? { lat: initial.lat, lng: initial.lng }
            : { lat: cfg.defaultLat || 24.8607, lng: cfg.defaultLng || 67.0011 };

        map = new google.maps.Map(document.getElementById('map'), {
            center,
            zoom: initial ? 15 : 13,
            mapTypeId: 'roadmap',
            gestureHandling: 'greedy',
            fullscreenControl: true,
            zoomControl: true,
            streetViewControl: false,
            minZoom: 3,
            maxZoom: 21,
        });

        drawingManager = new google.maps.drawing.DrawingManager({ drawingControl: false });
        drawingManager.setMap(map);
        trafficLayer = new google.maps.TrafficLayer();
        customInfoWindow = new google.maps.InfoWindow({ maxWidth: 360 });

        if (!mapControlsBound) {
            bindControls();
            initNavAlerts();
            initMapHudToggle();
            updatePlaybackFab();
            initDateFilter();
            mapControlsBound = true;
        }

        hydrateAlertsFromConfig();
        loadGeofences();
        loadHistory();

        if (initial) {
            applyLivePoint(initial);
            lastRealtimePoint = { lat: initial.lat, lng: initial.lng };
        }
    }

    async function bootDeviceMap() {
        if (mapBootRunning) {
            return;
        }
        if (mapReady && map && hasGoogleMapDom(document.getElementById('map'))) {
            resizeMap();
            return;
        }

        mapBootRunning = true;
        mapBootAttempts += 1;

        const attemptLabel = mapBootAttempts > 1
            ? mi('loadingMapRetry', 'Reloading map…').replace(':attempt', String(mapBootAttempts))
            : mi('loadingMap', 'Loading map…');
        showLoading(attemptLabel);

        try {
            await waitForMapContainerSize();
            await loadGoogleMapsApi();

            if (!map) {
                createMapInstance();
            } else {
                google.maps.event.trigger(map, 'resize');
            }

            bindMapWatchers();
            await verifyMapRendered();
            onMapTilesReady();
            mapBootAttempts = 0;
        } catch (err) {
            console.warn('[device-map] boot failed', mapBootAttempts, err);
            map = null;
            mapReady = false;

            if (mapBootAttempts < MAP_BOOT_MAX) {
                await sleep(Math.min(1500 * mapBootAttempts, 6000));
                mapBootRunning = false;
                return bootDeviceMap();
            }

            showLoading(mi('loadingMapFailed', 'Map failed to load. Retrying…'));
            mapBootAttempts = 0;
            await sleep(8000);
            mapBootRunning = false;
            return bootDeviceMap();
        } finally {
            mapBootRunning = false;
        }
    }

    function resizeMap() {
        if (map && google?.maps?.event) {
            setTimeout(() => google.maps.event.trigger(map, 'resize'), 350);
        }
    }

    async function loadRecentAlerts() {
        if (!alertsUrl) {
            if (!alertsBootstrapped) {
                hydrateAlertsFromConfig();
            }
            return;
        }
        try {
            const res = await fetchAlerts(alertsFetchUrl(NAV_ALERT_LIMIT, false));
            const events = await parseJsonResponse(res);
            if (handleMapAccessDenied(res, events)) {
                if (!alertsBootstrapped) {
                    hydrateAlertsFromConfig();
                }
                return;
            }
            if (!res.ok) {
                console.warn('Alerts load HTTP', res.status);
                if (!alertsBootstrapped) {
                    hydrateAlertsFromConfig();
                }
                return;
            }
            const items = Array.isArray(events) ? events : (Array.isArray(events?.data) ? events.data : []);
            if (!items.length && !alertsBootstrapped) {
                hydrateAlertsFromConfig();
                return;
            }
            navAlertStore.length = 0;
            seenAlertIds.clear();
            lastAlertEventId = 0;
            items.forEach((e) => {
                ingestAlertPayload(e, { countAsUnread: false });
            });
            sortNavAlertStore();
            renderNavAlertsList();
            const unreadGeofence = navAlertStore.filter((a) => isGeofenceAlert(a)).length;
            if (unreadGeofence > 0) {
                updateNavAlertBadge(unreadGeofence);
            }
            alertsBootstrapped = true;
        } catch (err) {
            console.warn('Alerts load failed', err);
            if (!alertsBootstrapped) {
                hydrateAlertsFromConfig();
            }
        }
    }

    function sortNavAlertStore() {
        navAlertStore.sort((a, b) => {
            const score = (x) => {
                if (isGeofenceAlert(x)) return 100;
                if (x.event_type === 'panic' || x.event_type === 'power_cut') return 90;
                return 10;
            };
            return score(b) - score(a) || (b.id || 0) - (a.id || 0);
        });
    }

    async function pollNewAlerts() {
        if (!alertsUrl) return;
        try {
            const res = await fetchAlerts(alertsFetchUrl(lastAlertEventId > 0 ? 15 : NAV_ALERT_LIMIT));
            const events = await parseJsonResponse(res);
            if (handleMapAccessDenied(res, events)) return;
            if (!res.ok) return;
            const items = Array.isArray(events) ? events : [];
            if (!items.length) return;

            if (lastAlertEventId > 0) {
                items.forEach((e) => {
                    ingestAlertPayload(e, {
                        notify: isGeofenceAlert(e),
                        countAsUnread: isGeofenceAlert(e),
                    });
                });
            } else {
                items.forEach((e) => ingestAlertPayload(e, { countAsUnread: false }));
            }

            sortNavAlertStore();
            renderNavAlertsList();
        } catch (err) {
            console.warn('Alert poll failed', err);
        }
    }

    function bindControls() {
        document.getElementById('btnRecenter')?.addEventListener('click', () => {
            if (currentPositionMarker) {
                map.panTo(currentPositionMarker.getPosition());
                map.setZoom(15);
            }
        });
        document.getElementById('btnFollow')?.addEventListener('click', () => {
            followVehicle = !followVehicle;
            document.getElementById('btnFollow')?.classList.toggle('active', followVehicle);
            showNotification(followVehicle ? 'Follow mode on' : 'Follow mode off', 'info');
        });
        document.getElementById('btnTraffic')?.addEventListener('click', () => {
            trafficLayer.setMap(trafficLayer.getMap() ? null : map);
        });
        document.getElementById('playbackFab')?.addEventListener('click', () => {
            if (!playbackPoints.length) {
                showNotification('Load route history first', 'info');
                return;
            }
            setPlaybackPanelOpen(true);
        });
        document.getElementById('btnGeofence')?.addEventListener('click', () => {
            document.getElementById('geofencePanel')?.classList.toggle('active');
        });
        document.getElementById('btnClear')?.addEventListener('click', clearRoute);
        document.getElementById('playbackClose')?.addEventListener('click', () => {
            if (isPlaying) pausePlayback();
            setPlaybackPanelOpen(false);
        });
        document.getElementById('geofenceClose')?.addEventListener('click', () => {
            document.getElementById('geofencePanel')?.classList.remove('active');
        });
        document.getElementById('applyFilter')?.addEventListener('click', applyDateFilter);
        document.getElementById('reverseBtn')?.addEventListener('click', reverseGeocode);
        document.getElementById('btnCopyCoords')?.addEventListener('click', copyLiveCoords);
        document.getElementById('btnOpenMaps')?.addEventListener('click', openInGoogleMaps);
        document.getElementById('btnStreetView')?.addEventListener('click', openStreetView);
        document.getElementById('btnFitRoute')?.addEventListener('click', fitRouteBounds);
        document.getElementById('btnHeatmap')?.addEventListener('click', toggleHeatmap);
        document.getElementById('btnNightMode')?.addEventListener('click', toggleNightMode);
        document.getElementById('btnExportRoute')?.addEventListener('click', exportRouteCsv);
        document.getElementById('btnExportCsv')?.addEventListener('click', exportRouteCsv);
        document.getElementById('btnExportGpx')?.addEventListener('click', exportRouteGpx);
        document.getElementById('btnStops')?.addEventListener('click', toggleStopMarkers);

        document.querySelectorAll('#layerControls [data-layer]').forEach((btn) => {
            btn.addEventListener('click', () => {
                const layer = btn.dataset.layer;
                if (!layer) return;
                map.setMapTypeId(layer);
                document.querySelectorAll('#layerControls [data-layer]').forEach((b) => b.classList.remove('active'));
                btn.classList.add('active');
            });
        });

        window.addEventListener('map-sidebar-toggled', resizeMap);

        google.maps.event.addListener(drawingManager, 'overlaycomplete', (e) => {
            currentDrawing = e.overlay;
            document.getElementById('btnSaveGeofence').disabled = false;
            drawingManager.setDrawingMode(null);
        });
        document.getElementById('btnDrawPolygon')?.addEventListener('click', () => {
            currentDrawing?.setMap(null);
            drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
        });
        document.getElementById('btnDrawCircle')?.addEventListener('click', () => {
            currentDrawing?.setMap(null);
            drawingManager.setDrawingMode(google.maps.drawing.OverlayType.CIRCLE);
        });
        document.getElementById('btnSaveGeofence')?.addEventListener('click', saveGeofence);
        document.getElementById('btnCancelGeofence')?.addEventListener('click', () => {
            currentDrawing?.setMap(null);
            drawingManager.setDrawingMode(null);
            document.getElementById('btnSaveGeofence').disabled = true;
            document.getElementById('geofencePanel')?.classList.remove('active');
        });

        document.getElementById('pbPlayPause')?.addEventListener('click', togglePlayPause);
        document.getElementById('pbStop')?.addEventListener('click', stopPlayback);
        document.getElementById('pbRewind')?.addEventListener('click', rewindPlayback);
        document.getElementById('playbackProgress')?.addEventListener('click', scrubPlayback);
        document.querySelectorAll('.speed-btn').forEach((btn) => {
            btn.addEventListener('click', () => {
                playbackSpeed = parseFloat(btn.dataset.speed);
                document.querySelectorAll('.speed-btn').forEach((b) => b.classList.remove('active'));
                btn.classList.add('active');
                if (isPlaying) { pausePlayback(); startPlayback(); }
            });
        });
    }

    function updatePlaybackFab() {
        const fab = document.getElementById('playbackFab');
        if (!fab) return;
        const hasRoute = playbackPoints.length > 0;
        fab.disabled = !hasRoute;
    }

    function setPlaybackPanelOpen(open) {
        const panel = document.getElementById('playbackPanel');
        const mapArea = document.getElementById('mapArea');
        const fab = document.getElementById('playbackFab');
        if (!panel) return;
        panel.classList.toggle('active', open);
        mapArea?.classList.toggle('playback-open', open);
        fab?.classList.toggle('playback-fab--hidden', open);
        if (open) setTimeout(resizeMap, 400);
    }

    function formatClock(date) {
        if (!date || Number.isNaN(date.getTime())) return '00:00';
        return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    }

    function formatDuration(seconds) {
        const s = Math.max(0, Math.floor(seconds));
        const h = Math.floor(s / 3600);
        const m = Math.floor((s % 3600) / 60);
        const sec = s % 60;
        if (h > 0) return `${h}:${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`;
        return `${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`;
    }

    function getPlaybackDurationSec() {
        if (playbackPoints.length < 2) return 0;
        const start = new Date(playbackPoints[0].recorded_at).getTime();
        const end = new Date(playbackPoints[playbackPoints.length - 1].recorded_at).getTime();
        if (Number.isNaN(start) || Number.isNaN(end) || end <= start) return playbackPoints.length;
        return (end - start) / 1000;
    }

    function updatePlaybackMeta() {
        const total = playbackPoints.length;
        const subtitle = document.getElementById('playbackSubtitle');
        if (subtitle) {
            subtitle.textContent = total
                ? `${total} points · ${isPlaying ? 'Playing' : 'Ready'}`
                : 'Load history to start';
        }
        setText('pbPointTotal', String(total));
    }

    function setPlayPauseUi(playing) {
        const btn = document.getElementById('pbPlayPause');
        const icon = document.getElementById('pbPlayPauseIcon');
        if (btn) btn.classList.toggle('is-playing', playing);
        if (icon) icon.className = playing ? 'fas fa-pause' : 'fas fa-play';
    }

    function togglePlayPause() {
        if (!playbackPoints.length) return showNotification('Load route history first', 'info');
        if (isPlaying) pausePlayback();
        else startPlayback();
    }

    function rewindPlayback() {
        if (!playbackPoints.length) return;
        pausePlayback();
        playbackIndex = 0;
        updatePlaybackAtIndex(0);
    }

    function scrubPlayback(e) {
        if (!playbackPoints.length) return;
        const rect = e.currentTarget.getBoundingClientRect();
        const percent = Math.min(1, Math.max(0, (e.clientX - rect.left) / rect.width));
        playbackIndex = Math.min(playbackPoints.length - 1, Math.floor(percent * playbackPoints.length));
        pausePlayback();
        updatePlaybackAtIndex(playbackIndex);
    }

    function updatePlaybackAtIndex(index) {
        const p = playbackPoints[index];
        if (!p) return;
        if (!playbackMarker) {
            playbackMarker = new google.maps.Marker({
                map,
                title: 'Playback',
                zIndex: 1000,
                icon: vehicleIcon(p.speed, p.heading),
            });
        } else {
            playbackMarker.setPosition({ lat: p.lat, lng: p.lng });
            playbackMarker.setIcon(vehicleIcon(p.speed, p.heading));
        }
        setText('pbLiveSpeed', parseFloat(p.speed || 0).toFixed(0));
        setText('pbPointIndex', String(index + 1));
        updatePlaybackProgress();
        if (followVehicle) map.panTo({ lat: p.lat, lng: p.lng });
    }

    /** Calendar date in local timezone (Y-m-d), not UTC ISO. */
    function formatLocalDate(d) {
        const y = d.getFullYear();
        const m = String(d.getMonth() + 1).padStart(2, '0');
        const day = String(d.getDate()).padStart(2, '0');
        return `${y}-${m}-${day}`;
    }

    function parseDateRangeInput() {
        const raw = document.getElementById('dateRange')?.value?.trim() || '';
        if (!raw) return null;

        const rangeMatch = raw.match(/^(\d{4}-\d{2}-\d{2})\s*(?:to|-)\s*(\d{4}-\d{2}-\d{2})$/i);
        if (rangeMatch) return { from: rangeMatch[1], to: rangeMatch[2] };

        if (/^\d{4}-\d{2}-\d{2}$/.test(raw)) return { from: raw, to: raw };

        return null;
    }

    function resolveFilterDates() {
        const dates = flatpickrInstance?.selectedDates || [];
        if (dates.length >= 2) {
            return { from: formatLocalDate(dates[0]), to: formatLocalDate(dates[1]) };
        }
        if (dates.length === 1) {
            const d = formatLocalDate(dates[0]);
            return { from: d, to: d };
        }
        return parseDateRangeInput();
    }

    async function loadHistory(from = null, to = null) {
        const useLast24Hours = !from && !to;
        showLoading(useLast24Hours ? 'Loading last 24 hours...' : 'Loading route history...');
        try {
            let url = historyUrl;
            if (from) {
                const end = to || from;
                url += `?from=${encodeURIComponent(from)}&to=${encodeURIComponent(end)}`;
            }
            const response = await fetch(url);
            const json = await parseJsonResponse(response);
            if (handleMapAccessDenied(response, json)) return;
            if (!response.ok) throw new Error('HTTP ' + response.status);
            const historyFallback = response.headers.get('X-History-Fallback') || '';
            const data = normalizeResponse(json).map(normalizePoint).filter(Boolean);

            polylines.forEach((p) => p.setMap(null));
            polylines = [];
            markers.forEach((m) => { if (m !== currentPositionMarker) m.setMap(null); });
            markers = currentPositionMarker ? [currentPositionMarker] : [];

            if (!data.length) {
                showNotification(
                    useLast24Hours ? mi('noGps24h', 'No GPS data in the last 24 hours') : 'No history for selected period',
                    'info'
                );
                return;
            }

            historyData = data;
            const bounds = new google.maps.LatLngBounds();

            for (let i = 1; i < data.length; i++) {
                const a = data[i - 1], b = data[i];
                bounds.extend({ lat: a.lat, lng: a.lng });
                bounds.extend({ lat: b.lat, lng: b.lng });
                const speed = b.speed;
                const seg = new google.maps.Polyline({
                    path: [{ lat: a.lat, lng: a.lng }, { lat: b.lat, lng: b.lng }],
                    strokeColor: speedToColor(speed),
                    strokeOpacity: 1,
                    strokeWeight: 5,
                    clickable: true,
                    map,
                });
                seg._segmentData = { start: a, end: b, speed, distance: haversineDistance(a.lat, a.lng, b.lat, b.lng), startTime: a.recorded_at, endTime: b.recorded_at };
                google.maps.event.addListener(seg, 'click', (e) => showPolylineInfo(seg, e.latLng));
                polylines.push(seg);
            }

            addStartEndMarkers(data[0], data[data.length - 1]);
            lastRealtimePoint = { lat: data[data.length - 1].lat, lng: data[data.length - 1].lng };
            applyLivePoint(data[data.length - 1]);

            if (data.length < 100) map.fitBounds(bounds);
            else { map.setCenter({ lat: data[data.length - 1].lat, lng: data[data.length - 1].lng }); map.setZoom(14); }

            playbackPoints = data;
            playbackIndex = 0;
            updatePlaybackMeta();
            updatePlaybackProgress();
            updatePlaybackFab();
            setPlaybackPanelOpen(false);
            updateRouteSummary(data);
            if (historyFallback) {
                const fallbackKeys = {
                    last_known_activity: 'historyFallbackLastKnownActivity',
                    last_activity_day: 'historyFallbackLastActivityDay',
                    '30_days': 'historyFallback30Days',
                };
                const i18nKey = fallbackKeys[historyFallback] || 'historyFallbackLastKnownActivity';
                const fallbackMsg = mi(i18nKey, `Loaded ${data.length} GPS points from last known activity`);
                showNotification(fallbackMsg.replace(':count', String(data.length)), 'info');
            } else {
                showNotification(
                    useLast24Hours
                        ? `Loaded ${data.length} GPS points (last 24 hours)`
                        : `Loaded ${data.length} GPS points`,
                    'success'
                );
            }
        } catch (err) {
            showNotification('Failed to load history: ' + err.message, 'error');
        } finally {
            hideLoading();
        }
    }

    function showPolylineInfo(polyline, latLng) {
        const d = polyline?._segmentData;
        if (!d) return;
        const content = document.getElementById('polylineInfoTemplate')?.cloneNode(true);
        if (!content) return;
        content.style.display = 'block';
        content.querySelector('#statSpeed').textContent = d.speed.toFixed(1) + ' km/h';
        content.querySelector('#statDistance').textContent = (d.distance * 1000).toFixed(0) + ' m';
        content.querySelector('#detailStartTime').textContent = d.startTime ? new Date(d.startTime).toLocaleTimeString() : dash();
        content.querySelector('#detailEndTime').textContent = d.endTime ? new Date(d.endTime).toLocaleTimeString() : dash();
        customInfoWindow.setContent(content);
        customInfoWindow.setPosition(latLng);
        customInfoWindow.open(map);
    }

    function addStartEndMarkers(start, end) {
        startMarker?.setMap(null);
        startMarker = new google.maps.Marker({
            position: { lat: start.lat, lng: start.lng },
            map,
            title: 'Start',
            icon: { url: cfg.startIcon || '/images/start.png', scaledSize: new google.maps.Size(32, 32) },
            zIndex: 998,
        });
        markers.push(startMarker);
        updateCurrentMarker(end);
    }

    function clearRoute() {
        polylines.forEach((p) => p.setMap(null));
        polylines = [];
        realtimePolylines.forEach((p) => p.setMap(null));
        realtimePolylines = [];
        markers.forEach((m) => { if (m !== currentPositionMarker) m.setMap(null); });
        markers = currentPositionMarker ? [currentPositionMarker] : [];
        stopPlayback();
        historyData = [];
        playbackPoints = [];
        routeStops = [];
        if (heatmapLayer) { heatmapLayer.setMap(null); heatmapLayer = null; }
        document.getElementById('btnHeatmap')?.classList.remove('active');
        document.getElementById('heatmapLegend') && (document.getElementById('heatmapLegend').style.display = 'none');
        clearStopMarkers();
        showsStops = false;
        document.getElementById('btnStops')?.classList.remove('active');
        setPlaybackPanelOpen(false);
        updatePlaybackMeta();
        updatePlaybackFab();
        renderTripEvents([], 0);
        showNotification('Route cleared', 'info');
    }

    function startPlayback() {
        if (!playbackPoints.length) return showNotification('No playback data', 'error');
        if (playbackIndex >= playbackPoints.length) playbackIndex = 0;
        isPlaying = true;
        setPlayPauseUi(true);
        updatePlaybackMeta();
        clearInterval(playbackTimer);
        playbackTimer = setInterval(() => {
            if (playbackIndex >= playbackPoints.length) {
                stopPlayback();
                showNotification('Playback finished', 'success');
                return;
            }
            updatePlaybackAtIndex(playbackIndex);
            playbackIndex++;
        }, 1000 / playbackSpeed);
    }

    function pausePlayback() {
        clearInterval(playbackTimer);
        isPlaying = false;
        setPlayPauseUi(false);
        updatePlaybackMeta();
    }

    function stopPlayback() {
        clearInterval(playbackTimer);
        isPlaying = false;
        playbackIndex = 0;
        setPlayPauseUi(false);
        playbackMarker?.setMap(null);
        playbackMarker = null;
        setText('pbLiveSpeed', '0');
        setText('pbPointIndex', '0');
        updatePlaybackProgress();
        updatePlaybackMeta();
    }

    function updatePlaybackProgress() {
        const total = playbackPoints.length;
        const idx = Math.min(playbackIndex, total);
        const percent = total > 1 ? (idx / (total - 1)) * 100 : 0;

        const bar = document.getElementById('playbackProgressBar');
        const thumb = document.getElementById('playbackProgressThumb');
        if (bar) bar.style.width = percent + '%';
        if (thumb) thumb.style.left = percent + '%';

        const durationSec = getPlaybackDurationSec();
        let currentSec = 0;
        if (total > 0 && playbackPoints[0]?.recorded_at) {
            const start = new Date(playbackPoints[0].recorded_at).getTime();
            const cur = playbackPoints[Math.min(idx, total - 1)]?.recorded_at;
            if (cur) currentSec = (new Date(cur).getTime() - start) / 1000;
        } else {
            currentSec = idx;
        }

        setText('playbackTimeCurrent', formatDuration(currentSec));
        setText('playbackTimeTotal', formatDuration(durationSec));
        setText('pbPointIndex', String(total ? Math.min(idx + 1, total) : 0));
        setText('pbPointTotal', String(total));
    }

    function updateRouteSummary(data) {
        if (!data.length) return;
        const stats = analyzeRoute(data);
        if (!stats) return;

        routeStops = stats.stops;
        const dur = stats.totalSec || 0;
        const avg = dur > 0 ? (stats.dist / (dur / 3600)).toFixed(1) : '0';

        setText('totalDistance', stats.dist.toFixed(2) + ' km');
        setText('routeDuration', formatDurationLong(dur));
        setText('avgSpeed', avg + ' km/h');
        setText('maxSpeed', stats.maxSpeed.toFixed(1) + ' km/h');
        setText('movingTime', formatDurationLong(stats.movingSec));
        setText('stoppedTime', formatDurationLong(stats.stoppedSec));
        setText('overspeedCount', String(stats.overspeedEvents));
        setText('idleCount', String(stats.stops.length));
        setText('idleTotal', formatDurationLong(stats.stoppedSec));

        renderTripEvents(stats.stops, stats.overspeedEvents);
        if (showsStops) renderStopMarkers(routeStops);
    }

    function initDateFilter() {
        try {
            flatpickrInstance = flatpickr('#dateRange', { mode: 'range', dateFormat: 'Y-m-d', allowInput: true, maxDate: 'today' });
        } catch (e) { /* flatpickr optional */ }
    }

    function applyDateFilter() {
        const range = resolveFilterDates();
        if (range) {
            loadHistory(range.from, range.to);
        } else {
            loadHistory();
        }
    }

    function reverseGeocode() {
        if (!currentPositionMarker) return showNotification('No vehicle position', 'error');
        const pos = currentPositionMarker.getPosition();
        fetch(`${reverseGeocodeUrl}?lat=${pos.lat()}&lng=${pos.lng()}`)
            .then((r) => r.json())
            .then((data) => setText('addressBox', data.address || 'Not found'))
            .catch(() => setText('addressBox', 'Error loading address'));
    }

    function escapeHtml(text) {
        const el = document.createElement('div');
        el.textContent = text ?? '';
        return el.innerHTML;
    }

    function geofenceListItemHtml(g) {
        const name = escapeHtml(g.name || 'Unnamed');
        const type = escapeHtml(g.type || 'zone');
        return `
            <div class="geofence-list-item" data-geofence-id="${g.id}">
                <div class="geofence-list-item__info">
                    <strong>${name}</strong>
                    <small class="text-muted">${type}</small>
                </div>
                <div class="geofence-list-item__actions">
                    <button type="button" class="btn btn-sm btn-outline-secondary geofence-zoom-btn" data-id="${g.id}" title="Zoom to zone">
                        <i class="fas fa-search-plus"></i>
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-danger geofence-delete-btn" data-id="${g.id}" title="Remove geofence">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </div>
            </div>`;
    }

    function findGeofenceLayer(id) {
        return geofences.find((layer) => layer._geofenceId === id);
    }

    window.zoomToGeofence = function (id) {
        const layer = findGeofenceLayer(id);
        if (!layer) return showNotification('Geofence not found on map', 'error');
        if (layer.getBounds) map.fitBounds(layer.getBounds());
        else if (layer.getCenter) { map.setCenter(layer.getCenter()); map.setZoom(15); }
        showNotification('Zoomed to geofence', 'info');
    };

    window.deleteGeofence = async function (id) {
        const meta = findGeofenceLayer(id)?._geofenceMeta;
        const label = meta?.name ? `"${meta.name}"` : 'this geofence';
        if (!confirm(`Remove ${label}? This cannot be undone.`)) return;
        showLoading('Removing geofence...');
        try {
            const res = await fetch(`${geofenceDestroyBase}/${id}`, {
                method: 'DELETE',
                headers: { 'X-CSRF-TOKEN': csrfToken, Accept: 'application/json' },
            });
            const json = await res.json().catch(() => ({}));
            if (!res.ok) throw new Error(json.message || 'Delete failed');
            customInfoWindow?.close();
            await loadGeofences();
            showNotification('Geofence removed', 'success');
        } catch (e) {
            showNotification(e.message || 'Failed to remove geofence', 'error');
        } finally {
            hideLoading();
        }
    };

    function showGeofenceInfo(layer, position) {
        const meta = layer._geofenceMeta;
        if (!meta) return;
        customInfoWindow.setContent(`
            <div style="padding:12px;min-width:200px;">
                <strong>${escapeHtml(meta.name)}</strong><br>
                <small>Type: ${escapeHtml(meta.type)}</small>
                <div style="margin-top:10px;display:flex;gap:8px;">
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.zoomToGeofence(${meta.id})">Zoom</button>
                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="window.deleteGeofence(${meta.id})">Remove</button>
                </div>
            </div>`);
        customInfoWindow.setPosition(position);
        customInfoWindow.open(map);
    }

    function bindGeofenceListActions() {
        ['geofenceList', 'geofenceManageList'].forEach((id) => {
            const el = document.getElementById(id);
            if (!el || el.dataset.bound) return;
            el.dataset.bound = '1';
            el.addEventListener('click', (e) => {
                const deleteBtn = e.target.closest('.geofence-delete-btn');
                const zoomBtn = e.target.closest('.geofence-zoom-btn');
                if (deleteBtn) window.deleteGeofence(parseInt(deleteBtn.dataset.id, 10));
                if (zoomBtn) window.zoomToGeofence(parseInt(zoomBtn.dataset.id, 10));
            });
        });
    }

    async function loadGeofences() {
        try {
            const res = await fetch(geofencesUrl);
            const list = await parseJsonResponse(res);
            if (handleMapAccessDenied(res, list)) return;
            geofences.forEach((g) => g.setMap?.(null));
            geofences = [];
            const listEl = document.getElementById('geofenceList');
            const manageEl = document.getElementById('geofenceManageList');
            if (listEl) listEl.innerHTML = '';
            if (manageEl) manageEl.innerHTML = '';
            const items = Array.isArray(list) ? list : [];
            items.forEach((g) => {
                let layer = null;
                if (g.type === 'polygon' && g.coords?.length) {
                    layer = new google.maps.Polygon({
                        paths: g.coords.map((c) => ({ lat: parseFloat(c[0]), lng: parseFloat(c[1]) })),
                        strokeColor: '#8e44ad', fillColor: '#8e44ad', fillOpacity: 0.12, map,
                    });
                } else if (g.type === 'circle' && g.center) {
                    layer = new google.maps.Circle({
                        center: { lat: parseFloat(g.center[0]), lng: parseFloat(g.center[1]) },
                        radius: parseFloat(g.radius), strokeColor: '#2980b9', fillColor: '#2980b9', fillOpacity: 0.12, map,
                    });
                }
                if (layer) {
                    layer._geofenceId = g.id;
                    layer._geofenceMeta = g;
                    google.maps.event.addListener(layer, 'click', (e) => showGeofenceInfo(layer, e.latLng));
                    geofences.push(layer);
                }
                if (listEl) listEl.insertAdjacentHTML('beforeend', geofenceListItemHtml(g));
                if (manageEl) manageEl.insertAdjacentHTML('beforeend', geofenceListItemHtml(g));
            });
            if (listEl && !items.length) {
                listEl.innerHTML = '<div class="text-muted small text-center py-2">No geofences yet. Draw one on the map.</div>';
            }
            bindGeofenceListActions();
        } catch (e) {
            showNotification('Error loading geofences', 'error');
        }
    }

    async function saveGeofence() {
        if (!currentDrawing) return showNotification('Draw a shape first', 'error');
        const name = prompt('Geofence name:', 'New Geofence');
        if (!name) return;
        const payload = { name, device_id: deviceId };
        if (currentDrawing instanceof google.maps.Polygon) {
            payload.type = 'polygon';
            const path = currentDrawing.getPath();
            payload.coords = [];
            for (let i = 0; i < path.getLength(); i++) {
                const ll = path.getAt(i);
                payload.coords.push([ll.lat(), ll.lng()]);
            }
        } else if (currentDrawing instanceof google.maps.Circle) {
            payload.type = 'circle';
            const c = currentDrawing.getCenter();
            payload.center = [c.lat(), c.lng()];
            payload.radius = Math.round(currentDrawing.getRadius());
        }
        try {
            const res = await fetch(geofencesSaveUrl, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrfToken },
                body: JSON.stringify(payload),
            });
            const json = await res.json().catch(() => ({}));
            if (!res.ok || json.success === false) {
                showNotification(json.message || 'Save failed', 'error');
                return;
            }
            if (json.success || json.id) {
                currentDrawing.setMap(null);
                currentDrawing = null;
                document.getElementById('btnSaveGeofence').disabled = true;
                document.getElementById('geofencePanel')?.classList.remove('active');
                await loadGeofences();
                showNotification('Geofence saved', 'success');
            }
        } catch (e) {
            showNotification('Save failed', 'error');
        }
    }

    window.initDeviceMap = function () {
        bootDeviceMap();
    };

    window.initMap = window.initDeviceMap;
    window.deviceMapResize = resizeMap;

    function scheduleMapBoot() {
        if (!document.getElementById('map')) {
            return;
        }
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => bootDeviceMap(), { once: true });
        } else {
            bootDeviceMap();
        }
    }

    scheduleMapBoot();
})();
