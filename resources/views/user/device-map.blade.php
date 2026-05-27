@extends('user.layout')

@push('styles')
    <style>
        :root {
            --map-ui-bg: rgba(255, 255, 255, 0.92);
            --map-ui-border: rgba(15, 23, 42, 0.08);
            --map-ui-shadow: 0 12px 40px rgba(15, 23, 42, 0.18);
            --map-ui-radius: 20px;
            --map-accent: #1976D2;
            --map-accent-dark: #1565C0;
            --map-accent-glow: rgba(25, 118, 210, 0.35);
        }

        .tracking-container { display: flex; width: 100%; height: 100%; min-height: 0; }
        #mapArea {
            position: relative;
            flex: 1;
            min-width: 0;
            min-height: 0;
            height: 100%;
            overflow: hidden;
        }
        #map { width: 100%; height: 100%; }

        /* Map floating controls */
        .smart-controls {
            position: absolute;
            top: max(12px, env(safe-area-inset-top));
            right: max(12px, env(safe-area-inset-right));
            display: flex;
            flex-direction: column;
            gap: 8px;
            z-index: 1000;
            transition: bottom 0.35s ease, top 0.35s ease;
        }
        .control-group {
            background: var(--map-ui-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-radius: 14px;
            box-shadow: var(--map-ui-shadow);
            overflow: hidden;
            border: 1px solid var(--map-ui-border);
        }
        .smart-btn {
            width: 46px;
            height: 46px;
            border: none;
            background: transparent;
            color: #334155;
            cursor: pointer;
            transition: background 0.2s, color 0.2s, transform 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .smart-btn + .smart-btn { border-top: 1px solid var(--map-ui-border); }
        .smart-btn:hover { background: #f1f5f9; }
        .smart-btn:active { transform: scale(0.96); }
        .smart-btn.active { background: var(--map-accent); color: #fff; }
        .smart-btn i { font-size: 18px; }

        /* Bottom Play — opens route playback panel */
        .playback-fab {
            position: absolute;
            left: 50%;
            bottom: max(20px, env(safe-area-inset-bottom));
            transform: translateX(-50%);
            z-index: 1050;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 22px;
            border: none;
            border-radius: 999px;
            background: linear-gradient(135deg, var(--map-accent), #2563eb);
            color: #fff;
            font-size: 0.9rem;
            font-weight: 700;
            letter-spacing: 0.02em;
            cursor: pointer;
            box-shadow: 0 10px 28px var(--map-accent-glow), 0 2px 8px rgba(15, 23, 42, 0.12);
            transition: transform 0.25s ease, opacity 0.25s ease, box-shadow 0.25s ease;
        }
        .playback-fab i { font-size: 1rem; }
        .playback-fab:hover:not(:disabled) {
            transform: translateX(-50%) translateY(-2px);
            box-shadow: 0 14px 32px var(--map-accent-glow);
        }
        .playback-fab:active:not(:disabled) {
            transform: translateX(-50%) scale(0.97);
        }
        .playback-fab:disabled {
            opacity: 0.55;
            cursor: not-allowed;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.08);
        }
        .playback-fab.playback-fab--hidden {
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
            transform: translateX(-50%) translateY(12px);
        }

        /* ——— Route playback (premium bottom bar) ——— */
        .playback-panel {
            position: absolute;
            left: 50%;
            bottom: max(16px, env(safe-area-inset-bottom));
            transform: translateX(-50%) translateY(120%);
            width: min(560px, calc(100% - 24px));
            z-index: 1100;
            opacity: 0;
            visibility: hidden;
            pointer-events: none;
            transition: transform 0.4s cubic-bezier(0.22, 1, 0.36, 1), opacity 0.3s ease, visibility 0.3s;
        }
        .playback-panel.active {
            transform: translateX(-50%) translateY(0);
            opacity: 1;
            visibility: visible;
            pointer-events: auto;
        }
        .playback-panel__inner {
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
            border: 1px solid var(--map-ui-border);
            border-radius: var(--map-ui-radius);
            box-shadow: var(--map-ui-shadow), 0 0 0 1px rgba(255,255,255,0.5) inset;
            padding: 14px 16px 16px;
            overflow: hidden;
        }
        .playback-panel__inner::before {
            content: '';
            display: block;
            width: 40px;
            height: 4px;
            background: #cbd5e1;
            border-radius: 4px;
            margin: 0 auto 12px;
        }
        .playback-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 14px;
        }
        .playback-header__left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }
        .playback-badge {
            width: 44px;
            height: 44px;
            border-radius: 14px;
            background: linear-gradient(135deg, var(--map-accent), #42a5f5);
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            box-shadow: 0 6px 16px var(--map-accent-glow);
            flex-shrink: 0;
        }
        .playback-title {
            margin: 0;
            font-size: 0.95rem;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.2;
        }
        .playback-subtitle {
            margin: 2px 0 0;
            font-size: 0.75rem;
            color: #64748b;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .playback-close {
            width: 36px;
            height: 36px;
            border: none;
            border-radius: 10px;
            background: #f1f5f9;
            color: #64748b;
            cursor: pointer;
            flex-shrink: 0;
            transition: background 0.2s, color 0.2s;
        }
        .playback-close:hover { background: #e2e8f0; color: #0f172a; }

        .playback-timeline { margin-bottom: 12px; }
        .playback-progress {
            position: relative;
            height: 8px;
            background: #e2e8f0;
            border-radius: 999px;
            cursor: pointer;
            overflow: visible;
        }
        .playback-progress-bar {
            height: 100%;
            width: 0%;
            border-radius: 999px;
            background: linear-gradient(90deg, var(--map-accent), #42a5f5);
            transition: width 0.15s linear;
            position: relative;
        }
        .playback-progress-thumb {
            position: absolute;
            top: 50%;
            left: 0%;
            width: 18px;
            height: 18px;
            margin-top: -9px;
            margin-left: -9px;
            background: #fff;
            border: 3px solid var(--map-accent);
            border-radius: 50%;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            pointer-events: none;
            transition: left 0.15s linear;
        }
        .playback-time-row {
            display: flex;
            justify-content: space-between;
            margin-top: 8px;
            font-size: 0.7rem;
            font-weight: 600;
            color: #64748b;
            font-variant-numeric: tabular-nums;
        }

        .playback-stats-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-bottom: 14px;
        }
        .playback-stat {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 10px;
            background: #f1f5f9;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #334155;
        }
        .playback-stat i { color: var(--map-accent); font-size: 0.85rem; }
        .playback-stat span { font-variant-numeric: tabular-nums; }

        .playback-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }
        .playback-transport {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .playback-btn {
            width: 42px;
            height: 42px;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.2s, box-shadow 0.2s, background 0.2s;
            font-size: 0.95rem;
        }
        .playback-btn--ghost {
            background: #f1f5f9;
            color: #475569;
        }
        .playback-btn--ghost:hover { background: #e2e8f0; }
        .playback-btn--primary {
            width: 52px;
            height: 52px;
            background: linear-gradient(135deg, var(--map-accent), #2196F3);
            color: #fff;
            box-shadow: 0 8px 20px var(--map-accent-glow);
        }
        .playback-btn--primary:hover { transform: scale(1.05); }
        .playback-btn--primary.is-playing { background: linear-gradient(135deg, #f59e0b, #f97316); box-shadow: 0 8px 20px rgba(245, 158, 11, 0.4); }

        .playback-speed-group {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }
        .playback-speed-label {
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: #94a3b8;
        }
        .playback-speed-pills { display: flex; gap: 4px; }
        .speed-btn {
            min-width: 40px;
            padding: 6px 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 700;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
        }
        .speed-btn:hover { border-color: var(--map-accent); color: var(--map-accent); }
        .speed-btn.active {
            background: var(--map-accent);
            border-color: var(--map-accent);
            color: #fff;
            box-shadow: 0 4px 12px var(--map-accent-glow);
        }

        #mapArea.playback-open .smart-controls {
            bottom: calc(200px + env(safe-area-inset-bottom));
            top: auto;
        }

        /* Live vehicle HUD */
        .map-hud {
            position: absolute;
            top: max(12px, env(safe-area-inset-top));
            left: max(12px, env(safe-area-inset-left));
            z-index: 1000;
            width: min(280px, calc(100% - 80px));
            background: var(--map-ui-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--map-ui-border);
            border-radius: 14px;
            box-shadow: var(--map-ui-shadow);
            padding: 12px 14px;
            pointer-events: auto;
            transition: padding 0.25s ease, box-shadow 0.25s ease;
        }
        .map-hud.is-collapsed {
            padding: 10px 12px;
        }
        .map-hud__toggle {
            display: flex;
            align-items: center;
            gap: 8px;
            width: 100%;
            margin: 0;
            padding: 0;
            border: none;
            background: transparent;
            cursor: pointer;
            text-align: left;
            color: inherit;
            font: inherit;
        }
        .map-hud__toggle:hover .map-hud__name { color: var(--map-accent); }
        .map-hud__toggle:focus-visible {
            outline: 2px solid var(--map-accent);
            outline-offset: 2px;
            border-radius: 8px;
        }
        .map-hud__toggle-text {
            flex: 1;
            min-width: 0;
        }
        .map-hud__label {
            display: block;
            font-size: 0.65rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #64748b;
            line-height: 1.2;
        }
        .map-hud__chevron {
            flex-shrink: 0;
            font-size: 0.75rem;
            color: #94a3b8;
            transition: transform 0.25s ease;
        }
        .map-hud.is-collapsed .map-hud__chevron { transform: rotate(180deg); }
        .map-hud__mini {
            flex-shrink: 0;
            font-weight: 700;
            font-size: 0.82rem;
            color: var(--map-accent);
            font-variant-numeric: tabular-nums;
            display: none;
        }
        .map-hud.is-collapsed .map-hud__mini { display: block; }
        .map-hud__body {
            overflow: hidden;
            max-height: 400px;
            opacity: 1;
            transition: max-height 0.3s ease, opacity 0.25s ease, margin 0.25s ease;
            margin-top: 10px;
        }
        .map-hud.is-collapsed .map-hud__body {
            max-height: 0;
            opacity: 0;
            margin-top: 0;
            pointer-events: none;
        }
        .map-hud__status-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #94a3b8;
            box-shadow: 0 0 0 3px rgba(148, 163, 184, 0.25);
        }
        .map-hud__status-dot.is-online { background: #22c55e; box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.25); }
        .map-hud__status-dot.is-moving { background: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25); }
        .map-hud__status-dot.is-stopped { background: #94a3b8; }
        .map-hud__status-dot.is-alert { background: #ef4444; box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.25); }
        .map-hud__name { font-weight: 700; font-size: 0.95rem; color: #0f172a; }
        .map-hud__grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            font-size: 0.8rem;
        }
        .map-hud__cell span { display: block; color: #94a3b8; font-size: 0.65rem; text-transform: uppercase; font-weight: 600; }
        .map-hud__cell strong { color: #0f172a; font-variant-numeric: tabular-nums; }
        .map-hud__address {
            margin-top: 8px;
            font-size: 0.72rem;
            color: #475569;
            line-height: 1.35;
            max-height: 2.7em;
            overflow: hidden;
        }
        .map-hud__actions {
            display: flex;
            gap: 6px;
            margin-top: 10px;
            flex-wrap: wrap;
        }
        .map-hud__actions button {
            flex: 1;
            min-width: 0;
            padding: 5px 8px;
            border: 1px solid #e2e8f0;
            background: #fff;
            border-radius: 8px;
            font-size: 0.68rem;
            font-weight: 600;
            color: #475569;
            cursor: pointer;
        }
        .map-hud__actions button:hover { border-color: var(--map-accent); color: var(--map-accent); }

        .heatmap-legend {
            position: absolute;
            bottom: max(88px, calc(72px + env(safe-area-inset-bottom)));
            left: max(12px, env(safe-area-inset-left));
            z-index: 1000;
            background: var(--map-ui-bg);
            border: 1px solid var(--map-ui-border);
            border-radius: 12px;
            padding: 10px 12px;
            box-shadow: var(--map-ui-shadow);
            font-size: 0.75rem;
        }
        .heatmap-legend .legend-header { font-weight: 700; margin-bottom: 6px; display: flex; align-items: center; gap: 6px; }
        .heatmap-legend .legend-bar {
            height: 8px;
            border-radius: 4px;
            background: linear-gradient(90deg, #9aa0a6, #34a853, #fbbc05, #ea4335);
            margin-bottom: 4px;
        }
        .heatmap-legend .legend-labels { display: flex; justify-content: space-between; color: #64748b; font-size: 0.65rem; }

        .map-tools-left {
            position: absolute;
            left: max(12px, env(safe-area-inset-left));
            bottom: max(88px, calc(72px + env(safe-area-inset-bottom)));
            z-index: 1000;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        #mapArea.playback-open .map-tools-left {
            bottom: calc(220px + env(safe-area-inset-bottom));
        }

        /* Geofence panel */
        .geofence-panel {
            position: absolute;
            top: max(12px, env(safe-area-inset-top));
            left: max(12px, env(safe-area-inset-left));
            background: var(--map-ui-bg);
            backdrop-filter: blur(16px);
            border-radius: var(--map-ui-radius);
            box-shadow: var(--map-ui-shadow);
            padding: 16px;
            z-index: 1000;
            width: min(320px, calc(100vw - 24px));
            display: none;
            border: 1px solid var(--map-ui-border);
        }
        .geofence-panel.active { display: block; }
        .geofence-types {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }
        .geofence-type-btn {
            padding: 16px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            text-align: center;
        }
        .geofence-type-btn.active { border-color: #4285f4; background: rgba(66,133,244,0.05); }
        .geofence-btn {
            flex: 1;
            padding: 12px;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
        }
        .geofence-btn.save { background: #4285f4; color: white; }
        .geofence-btn.cancel { background: #f5f5f5; color: #666; }
        .geofence-status {
            margin-top: 12px;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 6px;
            font-size: 12px;
            text-align: center;
        }

        /* Notifications */
        .notification-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 10000;
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 350px;
        }
        .notification {
            background: white;
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            border-left: 4px solid #4285f4;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideInRight 0.3s ease;
        }
        .notification.success { border-left-color: #34a853; }
        .notification.error { border-left-color: #ea4335; }
        .notification.warning { border-left-color: #f59e0b; }
        .notification.info { border-left-color: #4285f4; }

        .geofence-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .geofence-title { font-weight: 700; font-size: 0.95rem; }
        .geofence-close { width: 32px; height: 32px; border: none; border-radius: 8px; background: #f1f5f9; cursor: pointer; }
        .geofence-controls { display: flex; gap: 8px; margin-top: 12px; }

        /* Mobile & tablet */
        @media (max-width: 992px) {
            .playback-panel {
                left: 0;
                right: 0;
                width: 100%;
                max-width: none;
                bottom: 0;
                transform: translateY(100%);
                border-radius: 0;
            }
            .playback-panel.active {
                transform: translateY(0);
            }
            .playback-panel__inner {
                border-radius: 20px 20px 0 0;
                padding-bottom: max(16px, env(safe-area-inset-bottom));
            }
            .playback-toolbar { flex-direction: column; align-items: stretch; }
            .playback-transport { justify-content: center; }
            .playback-speed-group { justify-content: center; }
            .smart-controls {
                top: auto;
                bottom: max(16px, env(safe-area-inset-bottom));
                right: max(10px, env(safe-area-inset-right));
                flex-direction: row;
            }
            .control-group { display: flex; border-radius: 999px; }
            .smart-btn + .smart-btn { border-top: none; border-left: 1px solid var(--map-ui-border); }
            .smart-btn { width: 44px; height: 44px; }
            #mapArea.playback-open .smart-controls {
                bottom: calc(220px + env(safe-area-inset-bottom));
            }
            #mapArea.playback-open .playback-fab {
                opacity: 0;
                visibility: hidden;
                pointer-events: none;
            }
            .geofence-panel {
                left: 0;
                right: 0;
                top: auto;
                bottom: 0;
                width: 100%;
                max-height: 70vh;
                border-radius: 20px 20px 0 0;
                overflow-y: auto;
            }
            .notification-container {
                left: 12px;
                right: 12px;
                max-width: none;
                top: max(76px, env(safe-area-inset-top));
            }
        }

        @media (max-width: 992px) {
            .map-hud {
                width: min(240px, calc(100vw - 100px));
                font-size: 0.85rem;
                top: max(8px, env(safe-area-inset-top));
            }
            .map-tools-left { bottom: max(100px, calc(84px + env(safe-area-inset-bottom))); }
        }

        @media (max-width: 576px) {
            .playback-panel__inner::before { display: block; }
            .map-hud__actions button { font-size: 0.62rem; padding: 4px 6px; }
            .playback-stats-row { grid-template-columns: 1fr 1fr; gap: 6px; }
            .playback-stat { font-size: 0.72rem; padding: 6px 8px; }
            .playback-btn--primary { width: 48px; height: 48px; }
            .playback-btn { width: 38px; height: 38px; }
            .speed-btn { min-width: 36px; padding: 5px 8px; font-size: 0.7rem; }
            .navbar-brand span { display: none; }
        }
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* Loading overlay */
        .loading-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(4px);
            z-index: 2000;
            display: none;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 16px;
        }
        .loading-overlay.active { display: flex; }
        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #4285f4;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Map guided tour — root above map chrome; card above highlighted panels */
        body.map-tour-open { overflow: hidden; }
        .map-tour-root {
            position: fixed;
            inset: 0;
            z-index: 13000;
            pointer-events: none;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.25s ease, visibility 0.25s;
            isolation: isolate;
        }
        .map-tour-root--active {
            pointer-events: auto;
            opacity: 1;
            visibility: visible;
        }
        .map-tour-backdrop {
            position: fixed;
            inset: 0;
            z-index: 1;
            background: transparent;
            pointer-events: auto;
        }
        .map-tour-spotlight-wrap {
            position: fixed;
            inset: 0;
            z-index: 2;
            pointer-events: none;
            overflow: visible;
        }
        .map-tour-spotlight__label {
            position: fixed;
            z-index: 3;
            max-width: min(320px, calc(100vw - 32px));
            padding: 6px 14px;
            border-radius: 8px;
            background: linear-gradient(135deg, #1976d2, #42a5f5);
            color: #fff;
            font-size: 0.78rem;
            font-weight: 700;
            line-height: 1.35;
            box-shadow: 0 8px 24px rgba(25, 118, 210, 0.45);
            white-space: normal;
            word-break: break-word;
            animation: mapTourLabelIn 0.25s ease;
        }
        @keyframes mapTourLabelIn {
            from { opacity: 0; transform: translateY(6px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .map-tour-spotlight {
            position: fixed;
            z-index: 2;
            border-radius: 12px;
            background: transparent;
            box-shadow: 0 0 0 9999px rgba(10, 15, 45, 0.78);
            border: 3px solid #42a5f5;
            outline: 2px solid rgba(255, 255, 255, 0.45);
            outline-offset: 2px;
            pointer-events: none;
            transition: top 0.35s ease, left 0.35s ease, width 0.35s ease, height 0.35s ease;
            animation: mapTourPulse 2s ease-in-out infinite;
        }
        @keyframes mapTourPulse {
            0%, 100% { box-shadow: 0 0 0 9999px rgba(10, 15, 45, 0.78), 0 0 0 0 rgba(66, 165, 245, 0.45); }
            50% { box-shadow: 0 0 0 9999px rgba(10, 15, 45, 0.78), 0 0 0 8px rgba(66, 165, 245, 0.2); }
        }
        /* Highlighted map UI: above map, below tour dialog */
        body.map-tour-open .map-tour-elevated {
            z-index: 12950 !important;
        }
        .map-tour-target--active {
            position: relative;
            z-index: 12951 !important;
            isolation: isolate;
            box-shadow: 0 0 0 4px rgba(66, 165, 245, 0.45), 0 8px 28px rgba(25, 118, 210, 0.35);
            border-radius: 10px;
        }
        .map-tour-heading--active {
            position: relative;
            z-index: 12952 !important;
            color: #0d47a1 !important;
            background: linear-gradient(90deg, rgba(66, 165, 245, 0.2), rgba(66, 165, 245, 0.05)) !important;
            border-radius: 8px;
            box-shadow: inset 0 0 0 2px rgba(66, 165, 245, 0.55);
            padding: 4px 8px !important;
            margin: -4px -8px !important;
        }
        .premium-card.map-tour-target--active .card-header {
            border-radius: 10px 10px 0 0;
        }
        .map-tour-card {
            position: fixed;
            z-index: 10;
            width: min(420px, calc(100vw - 24px));
            max-width: min(420px, calc(100vw - 24px));
            max-height: min(calc(100vh - var(--map-tour-nav-h, 70px) - 32px), 640px);
            overflow-x: hidden;
            overflow-y: auto;
            background: linear-gradient(160deg, #ffffff 0%, #f8fafc 100%);
            border: 1px solid rgba(15, 23, 42, 0.1);
            border-radius: 20px;
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.35), 0 0 0 1px rgba(255, 255, 255, 0.5) inset;
            padding: 20px 22px 18px;
            box-sizing: border-box;
        }
        /* Centered modals: position set in JS within the map pane (below navbar) */
        .map-tour-card--center {
            right: auto !important;
            bottom: auto !important;
            inset-inline-start: auto !important;
        }
        /* Welcome step (LTR): center inside visible map pane, not full page width */
        html[dir="ltr"] .map-tour-root--welcome.map-tour-root--active .map-tour-card--center {
            top: calc(var(--tour-pane-top, 70px) + var(--tour-pane-height, 50vh) / 2) !important;
            left: calc(var(--tour-pane-left, 0px) + var(--tour-pane-width, 100vw) / 2) !important;
            transform: translate(-50%, -50%) !important;
            max-width: min(420px, calc(var(--tour-pane-width, 100vw) - 32px)) !important;
        }
        .map-tour-card--layout-pending {
            opacity: 0;
            pointer-events: none;
        }
        .map-tour-root--active .map-tour-card:not(.map-tour-card--layout-pending) {
            transition: opacity 0.2s ease;
        }
        .map-tour-card__header {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 12px;
        }
        .map-tour-card__titles {
            flex: 1;
            min-width: 0;
        }
        .map-tour-card__kicker {
            display: block;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: #1976d2;
            margin-bottom: 4px;
            word-break: break-word;
        }
        html[dir="rtl"] .map-tour-card__kicker {
            text-transform: none;
            letter-spacing: 0;
        }
        .map-tour-card__hint {
            margin: -8px 0 14px;
            padding: 10px 12px;
            border-radius: 10px;
            font-size: 0.82rem;
            line-height: 1.45;
        }
        .map-tour-card__hint--warn {
            background: #fff7ed;
            border: 1px solid #fed7aa;
            color: #9a3412;
        }
        .map-tour-card--pointer-bottom::before,
        .map-tour-card--pointer-top::before,
        .map-tour-card--pointer-left::before,
        .map-tour-card--pointer-right::before {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            background: #fff;
            border: 1px solid rgba(15, 23, 42, 0.08);
            transform: rotate(45deg);
        }
        .map-tour-card--pointer-bottom::before {
            top: -7px;
            left: 28px;
            border-bottom: none;
            border-right: none;
        }
        .map-tour-card--pointer-top::before {
            bottom: -7px;
            left: 28px;
            border-top: none;
            border-left: none;
        }
        .map-tour-card--pointer-left::before {
            inset-inline-end: -7px;
            inset-inline-start: auto;
            top: 24px;
            border-bottom: none;
            border-inline-start: none;
        }
        .map-tour-card--pointer-right::before {
            inset-inline-start: -7px;
            inset-inline-end: auto;
            top: 24px;
            border-top: none;
            border-inline-end: none;
        }
        .map-tour-card__progress {
            margin-bottom: 14px;
        }
        .map-tour-card__progress-bar {
            height: 4px;
            border-radius: 4px;
            background: linear-gradient(90deg, var(--map-accent), #42a5f5);
            width: 0;
            transition: width 0.3s ease;
        }
        .map-tour-card__step-label {
            display: block;
            margin-top: 8px;
            font-size: 0.72rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }
        .map-tour-card__icon {
            flex-shrink: 0;
            width: 52px;
            height: 52px;
            border-radius: 14px;
            background: linear-gradient(135deg, var(--map-accent), #42a5f5);
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
            box-shadow: 0 8px 20px var(--map-accent-glow);
        }
        .map-tour-card__icon--finish {
            background: linear-gradient(135deg, #059669, #10b981);
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.35);
        }
        .map-tour-card__icon--modal {
            background: linear-gradient(135deg, #7c3aed, #a78bfa);
            box-shadow: 0 8px 20px rgba(124, 58, 237, 0.35);
        }
        .map-tour-card__title {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.35;
            word-break: break-word;
        }
        .map-tour-card__body {
            margin: 0 0 16px;
            font-size: 0.9rem;
            line-height: 1.55;
            color: #475569;
            word-break: break-word;
        }
        html[dir="ltr"] .map-tour-card {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }
        html[dir="ltr"] .map-tour-card--center {
            max-width: min(420px, calc(100vw - 40px));
        }
        html[dir="ltr"] .map-tour-card__title {
            font-size: 1.15rem;
            line-height: 1.35;
            hyphens: auto;
        }
        html[dir="ltr"] .map-tour-card__body {
            font-size: 0.9rem;
            line-height: 1.55;
        }
        html[dir="ltr"] .map-tour-card__actions {
            flex-wrap: wrap;
            gap: 10px;
        }
        html[dir="rtl"] .map-tour-card {
            font-family: "Noto Sans Arabic", "Inter", system-ui, sans-serif;
        }
        .map-tour-prefs {
            margin-bottom: 16px;
            padding: 12px;
            background: #f1f5f9;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }
        .map-tour-prefs__lead {
            margin: 0 0 10px;
            font-size: 0.8rem;
            font-weight: 600;
            color: #334155;
        }
        .map-tour-prefs__option {
            display: flex;
            gap: 10px;
            align-items: flex-start;
            margin-bottom: 8px;
            font-size: 0.82rem;
            color: #475569;
            cursor: pointer;
        }
        .map-tour-prefs__option:last-child { margin-bottom: 0; }
        .map-tour-prefs__option input { margin-top: 3px; accent-color: var(--map-accent); }
        .map-tour-card__actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }
        .map-tour-card__actions-side {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 8px;
        }
        .map-tour-card__nav {
            display: flex;
            gap: 8px;
            margin-inline-start: auto;
            flex-shrink: 0;
        }
        html[dir="rtl"] .map-tour-card__header {
            flex-direction: row-reverse;
        }
        html[dir="rtl"] .map-tour-card__actions {
            flex-direction: row-reverse;
        }
        html[dir="rtl"] .map-tour-prefs__option {
            flex-direction: row-reverse;
            text-align: right;
        }
        @media (max-width: 480px) {
            .map-tour-card {
                width: calc(100vw - 16px);
                max-height: 92vh;
                padding: 16px;
            }
            .map-tour-card__actions {
                flex-direction: column;
                align-items: stretch;
            }
            .map-tour-card__nav {
                margin-inline-start: 0;
                justify-content: stretch;
            }
            .map-tour-card__nav .map-tour-btn {
                flex: 1;
            }
        }
        .map-tour-btn {
            border: none;
            border-radius: 10px;
            padding: 10px 16px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s, color 0.2s, transform 0.15s;
        }
        .map-tour-btn--ghost {
            background: #f1f5f9;
            color: #475569;
        }
        .map-tour-btn--ghost:hover { background: #e2e8f0; color: #0f172a; }
        .map-tour-btn--primary {
            background: linear-gradient(135deg, var(--map-accent), #2563eb);
            color: #fff;
            box-shadow: 0 6px 16px var(--map-accent-glow);
        }
        .map-tour-btn--primary:hover { transform: translateY(-1px); }

        /* Polyline info window */
        .gm-polyline-info {
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            min-width: 280px;
            overflow: hidden;
        }
        .polyline-header {
            padding: 16px;
            background: linear-gradient(135deg, #4285f4, #34a853);
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .polyline-body { padding: 16px; }
        .polyline-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 16px;
        }
        .stat-item { text-align: center; padding: 12px; background: #f8f9fa; border-radius: 8px; }
        .stat-value { font-size: 20px; font-weight: 700; color: #4285f4; }
    </style>
@endpush

@section('title', $device->name . ' - ' . __('app.map.live_tracking'))

@section('content')
    <div class="tracking-container">
        @include('user.side_bar_map')
        <div class="map-area" id="mapArea">
            <div id="map"></div>

            <div class="loading-overlay" id="loadingOverlay">
                <div class="loading-spinner"></div>
                <div class="loading-text" id="loadingText">{{ __('app.map.loading_map') }}</div>
            </div>
            <div class="notification-container" id="notificationContainer"></div>

            <!-- Live vehicle HUD -->
            <div class="map-hud" id="mapHud">
                <button type="button" class="map-hud__toggle" id="mapHudToggle" aria-expanded="true" aria-controls="mapHudBody" title="{{ __('app.map.hud_toggle_title') }}">
                    <span class="map-hud__status-dot" id="hudStatusDot"></span>
                    <span class="map-hud__toggle-text">
                        <span class="map-hud__label">{{ __('app.map.live_vehicle') }}</span>
                        <span class="map-hud__name">{{ $device->name }}</span>
                    </span>
                    <span class="map-hud__mini" id="hudMiniSpeed">—</span>
                    <i class="fas fa-chevron-up map-hud__chevron" aria-hidden="true"></i>
                </button>
                <div class="map-hud__body" id="mapHudBody">
                <div class="map-hud__grid">
                    <div class="map-hud__cell"><span>{{ __('app.map.speed') }}</span><strong id="hudSpeed">—</strong></div>
                    <div class="map-hud__cell"><span>{{ __('app.map.heading') }}</span><strong id="hudHeading">—</strong></div>
                    <div class="map-hud__cell"><span>{{ __('app.map.updated') }}</span><strong id="hudUpdated">—</strong></div>
                    <div class="map-hud__cell"><span>{{ __('app.map.coords') }}</span><strong id="hudCoords">—</strong></div>
                </div>
                <div class="map-hud__address" id="hudAddress">{{ __('app.map.address_loading') }}</div>
                <div class="map-hud__actions">
                    <button type="button" id="btnCopyCoords"><i class="fas fa-copy"></i> {{ __('app.map.copy') }}</button>
                    <button type="button" id="btnOpenMaps"><i class="fas fa-external-link-alt"></i> {{ __('app.map.open_maps') }}</button>
                    <button type="button" id="btnStreetView"><i class="fas fa-street-view"></i> {{ __('app.map.street_view') }}</button>
                </div>
                </div>
            </div>

            <!-- Heatmap Legend -->
            <div class="heatmap-legend" id="heatmapLegend" style="display:none;">
                <div class="legend-header"><i class="fas fa-fire"></i><span>{{ __('app.map.route_density') }}</span></div>
                <div class="legend-bar"></div>
                <div class="legend-labels"><span>0-40</span><span>40-80</span><span>80+</span></div>
            </div>

            <button type="button" class="playback-fab" id="playbackFab" disabled aria-label="{{ __('app.map.open_playback') }}">
                <i class="fas fa-play"></i>
                <span>{{ __('app.map.play_route_lower') }}</span>
            </button>

            <!-- Route Playback (hidden until Play is clicked) -->
            <div class="playback-panel" id="playbackPanel">
                <div class="playback-panel__inner">
                    <header class="playback-header">
                        <div class="playback-header__left">
                            <span class="playback-badge"><i class="fas fa-route"></i></span>
                            <div>
                                <h6 class="playback-title">{{ __('app.map.route_playback') }}</h6>
                                <p class="playback-subtitle" id="playbackSubtitle">{{ __('app.map.load_history') }}</p>
                            </div>
                        </div>
                        <button type="button" class="playback-close" id="playbackClose" aria-label="{{ __('app.map.playback_close') }}">
                            <i class="fas fa-times"></i>
                        </button>
                    </header>

                    <div class="playback-timeline">
                        <div class="playback-progress" id="playbackProgress" role="slider" aria-label="{{ __('app.map.playback_position') }}">
                            <div class="playback-progress-bar" id="playbackProgressBar"></div>
                            <div class="playback-progress-thumb" id="playbackProgressThumb"></div>
                        </div>
                        <div class="playback-time-row">
                            <span id="playbackTimeCurrent">00:00</span>
                            <span id="playbackTimeTotal">00:00</span>
                        </div>
                    </div>

                    <div class="playback-stats-row">
                        <div class="playback-stat">
                            <i class="fas fa-tachometer-alt"></i>
                            <span><span id="pbLiveSpeed">0</span> km/h</span>
                        </div>
                        <div class="playback-stat">
                            <i class="fas fa-location-dot"></i>
                            <span><span id="pbPointIndex">0</span> / <span id="pbPointTotal">0</span></span>
                        </div>
                    </div>

                    <div class="playback-toolbar">
                        <div class="playback-transport">
                            <button type="button" class="playback-btn playback-btn--ghost" id="pbRewind" title="{{ __('app.map.restart') }}">
                                <i class="fas fa-rotate-left"></i>
                            </button>
                            <button type="button" class="playback-btn playback-btn--primary" id="pbPlayPause" title="{{ __('app.map.play') }}">
                                <i class="fas fa-play" id="pbPlayPauseIcon"></i>
                            </button>
                            <button type="button" class="playback-btn playback-btn--ghost" id="pbStop" title="{{ __('app.map.stop') }}">
                                <i class="fas fa-stop"></i>
                            </button>
                        </div>
                        <div class="playback-speed-group">
                            <span class="playback-speed-label">{{ __('app.map.speed_label') }}</span>
                            <div class="playback-speed-pills">
                                <button type="button" class="speed-btn" data-speed="0.5">0.5×</button>
                                <button type="button" class="speed-btn active" data-speed="1">1×</button>
                                <button type="button" class="speed-btn" data-speed="2">2×</button>
                                <button type="button" class="speed-btn" data-speed="4">4×</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Geofence Drawing Panel -->
            <div class="geofence-panel" id="geofencePanel">
                <div class="geofence-header">
                    <div class="geofence-title"><i class="fas fa-draw-polygon"></i> {{ __('app.map.draw_geofence') }}</div>
                    <button class="geofence-close" id="geofenceClose"><i class="fas fa-times"></i></button>
                </div>
                <div class="geofence-types">
                    <button class="geofence-type-btn" id="btnDrawPolygon"><i class="fas fa-shapes"></i><span>{{ __('app.map.polygon') }}</span></button>
                    <button class="geofence-type-btn" id="btnDrawCircle"><i class="fas fa-circle"></i><span>{{ __('app.map.circle') }}</span></button>
                </div>
                <div class="geofence-status" id="geofenceStatus">{{ __('app.map.geofence_select_shape') }}</div>
                <div class="geofence-controls">
                    <button class="geofence-btn save" id="btnSaveGeofence" disabled>{{ __('app.map.save') }}</button>
                    <button class="geofence-btn cancel" id="btnCancelGeofence">{{ __('app.common.cancel') }}</button>
                </div>
            </div>

            <!-- Smart Controls -->
            <div class="smart-controls">
                <div class="control-group">
                    <button class="smart-btn" id="btnRecenter" title="{{ __('app.map.recenter') }}"><i class="fas fa-crosshairs"></i></button>
                    <button class="smart-btn" id="btnFollow" title="{{ __('app.map.follow') }}"><i class="fas fa-satellite"></i></button>
                    <button class="smart-btn" id="btnGeofence" title="{{ __('app.map.geofences') }}"><i class="fas fa-draw-polygon"></i></button>
                    <button class="smart-btn" id="btnClear" title="{{ __('app.map.clear_route') }}"><i class="fas fa-trash-alt"></i></button>
                    <button class="smart-btn" id="btnTraffic" title="{{ __('app.map.traffic') }}"><i class="fas fa-traffic-light"></i></button>
                </div>
                <div class="control-group" id="layerControls">
                    <button class="smart-btn active" data-layer="roadmap" title="{{ __('app.map.road_map') }}"><i class="fas fa-road"></i></button>
                    <button class="smart-btn" data-layer="satellite" title="{{ __('app.map.satellite_layer') }}"><i class="fas fa-satellite-dish"></i></button>
                    <button class="smart-btn" data-layer="hybrid" title="{{ __('app.map.hybrid') }}"><i class="fas fa-layer-group"></i></button>
                </div>
            </div>
            <div class="map-tools-left">
                <div class="control-group">
                    <button class="smart-btn" id="btnFitRoute" title="{{ __('app.map.fit_route') }}"><i class="fas fa-expand"></i></button>
                    <button class="smart-btn" id="btnHeatmap" title="{{ __('app.map.heatmap') }}"><i class="fas fa-fire"></i></button>
                    <button class="smart-btn" id="btnNightMode" title="{{ __('app.map.night_mode') }}"><i class="fas fa-moon"></i></button>
                    <button class="smart-btn" id="btnExportRoute" title="{{ __('app.map.export_csv_title') }}"><i class="fas fa-download"></i></button>
                    <button class="smart-btn" id="btnStops" title="{{ __('app.map.parking_stops') }}"><i class="fas fa-parking"></i></button>
                </div>
            </div>
        </div>
    </div>

    <div id="polylineInfoTemplate" style="display:none;">
        <div class="gm-polyline-info">
            <div class="polyline-header"><i class="fas fa-route"></i><div class="polyline-title"><h3>{{ __('app.map.route_segment_details') }}</h3></div></div>
            <div class="polyline-body">
                <div class="polyline-stats">
                    <div class="stat-item"><div class="stat-value" id="statSpeed">0</div><div class="stat-label">{{ __('app.map.speed_kmh') }}</div></div>
                    <div class="stat-item"><div class="stat-value" id="statDistance">0</div><div class="stat-label">{{ __('app.map.distance_label') }}</div></div>
                </div>
                <div class="polyline-details">
                    <div class="detail-row"><span class="detail-label">{{ __('app.map.start_time') }}</span><span id="detailStartTime">--:--</span></div>
                    <div class="detail-row"><span class="detail-label">{{ __('app.map.end_time') }}</span><span id="detailEndTime">--:--</span></div>
                    <div class="detail-row"><span class="detail-label">{{ __('app.map.speed_status') }}</span><span id="detailSpeedStatus">{{ __('app.map.normal') }}</span><span id="speedIndicator" class="speed-indicator">0-40</span></div>
                    <div class="detail-row"><span class="detail-label">{{ __('app.map.coordinates') }}</span><span id="detailCoords">0,0</span></div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        window.DEVICE_MAP_CONFIG = {
            deviceId: {{ $device->id }},
            mapToken: @json($mapToken ?? ''),
            deviceName: @json($device->mapMarkerTitle()),
            mapDisplayTitle: @json($device->mapDisplayTitle()),
            deviceTypeLabel: @json($device->deviceTypeLabel()),
            isAdminMap: @json($isAdminMap ?? false),
            apiRoutes: @json($mapApiRoutes ?? []),
            baseUrl: @json(url('/')),
            csrfToken: @json(csrf_token()),
            googleMapsKey: @json(config('services.google.maps_key', env('GOOGLE_MAPS_API_KEY'))),
            initialPoint: @json($initialPoint ?? null),
            defaultLat: 24.8607,
            defaultLng: 67.0011,
            overSpeedLimit: 80,
            lowBatteryThreshold: 20,
            movingSpeedKmh: {{ \App\Services\UserDashboardService::MOVING_SPEED_KMH }},
            idleSpeedKmh: 0.5,
            parkedIconSpeedKmh: 0.1,
            motionDetectKm: 0.004,
            onlineMinutes: 5,
            pollIntervalMs: 5000,
            stopMinMinutes: 2,
            stopIcon: @json(asset('images/stop.svg')),
            startIcon: @json(asset('images/start.png')),
            parkingIcon: @json(asset('images/stop.svg')),
            mapTour: {
                showOnLoad: @json($showMapTourOnLoad ?? true),
                mode: @json($mapTourMode ?? 'repeat'),
                saveUrl: @json(route('map.tour.preference')),
                i18n: @json(trans('map_tour')),
            },
            mapSession: {
                endUrl: @json(route('map.session.end')),
            },
            initialAlerts: @json($initialAlerts ?? []),
            alertsUrl: @json($mapApiRoutes['alerts'] ?? ''),
            i18n: {
                dash: @json(__('app.map.dash')),
                loadingMap: @json(__('app.map.loading_map')),
                loadingMapRetry: @json(__('app.map.loading_map_retry')),
                loadingMapFailed: @json(__('app.map.loading_map_failed')),
                kmh: @json(__('app.map.kmh_unit')),
                km: @json(__('app.map.km_unit')),
                ignitionOn: @json(__('app.map.ignition_on')),
                ignitionOff: @json(__('app.map.ignition_off')),
                statusOnline: @json(__('app.map.status_online')),
                statusPowerCut: @json(__('app.map.status_power_cut')),
                statusSos: @json(__('app.map.status_sos')),
                statusOverspeed: @json(__('app.map.status_overspeed')),
                statusStopped: @json(__('app.map.status_stopped')),
                statusMoving: @json(__('app.map.status_moving')),
                statusRunning: @json(__('app.map.status_running')),
                statusParked: @json(__('app.map.status_parked')),
                statusIdle: @json(__('app.map.status_idle')),
                statusOffline: @json(__('app.map.status_offline')),
                liveBadge: @json(__('app.map.live_badge')),
                addressNotFound: @json(__('app.map.address_not_found')),
                addressLoadError: @json(__('app.map.address_load_error')),
                addressCouldNotLoad: @json(__('app.map.address_could_not_load')),
                geofenceUnnamed: @json(__('app.map.geofence_unnamed')),
                geofenceZoomTitle: @json(__('app.map.geofence_zoom_title')),
                geofenceRemoveTitle: @json(__('app.map.geofence_remove_title')),
                geofenceNotOnMap: @json(__('app.map.geofence_not_on_map')),
                geofenceZoomed: @json(__('app.map.geofence_zoomed')),
                geofenceRemoveConfirm: @json(__('app.map.geofence_remove_confirm')),
                geofenceThis: @json(__('app.map.geofence_this')),
                geofenceRemoving: @json(__('app.map.geofence_removing')),
                geofenceRemoved: @json(__('app.map.geofence_removed')),
                geofenceRemoveFailed: @json(__('app.map.geofence_remove_failed')),
                geofenceTypeLabel: @json(__('app.map.geofence_type_label')),
                geofenceZoomBtn: @json(__('app.map.geofence_zoom_btn')),
                geofenceRemoveBtn: @json(__('app.map.geofence_remove_btn')),
                noNewAlerts: @json(__('app.map.no_new_alerts')),
                noAlertsYet: @json(__('app.map.no_alerts_yet')),
                alertsNewCount: @json(__('app.map.alerts_new_count')),
                deleteFailed: @json(__('app.map.delete_failed')),
                accessRestricted: @json(__('app.map.access_restricted')),
                accessDeniedDefault: @json(__('app.map.access_denied_default')),
                noGpsRecently: @json(__('app.map.no_gps_recently')),
                noGps24h: @json(__('app.map.no_gps_24h')),
                historyFallbackLastKnownActivity: @json(__('app.map.history_fallback_last_known_activity')),
                historyFallbackLastActivityDay: @json(__('app.map.history_fallback_last_activity_day')),
                historyFallback30Days: @json(__('app.map.history_fallback_30_days')),
                deviceOffline: @json(__('app.map.device_offline')),
                overspeedDetail: @json(__('app.map.overspeed_detail')),
                adminLocations: @json(__('app.admin.locations.title')),
                devices: @json(__('app.common.devices')),
            },
        };
    </script>
    @if(!empty($initialAlerts))
    <script>
        (function () {
            const alerts = @json($initialAlerts);
            function esc(s) {
                const el = document.createElement('div');
                el.textContent = s == null ? '' : String(s);
                return el.innerHTML;
            }
            function bootMapBell() {
                const list = document.getElementById('navAlertsList');
                if (!list || !alerts.length) return;
                list.innerHTML = alerts.map(function (a) {
                    const isGf = a.event_type === 'geofence_enter' || a.event_type === 'geofence_exit';
                    const zone = a.geofence || ((a.message || '').match(/geofence\s+"([^"]+)"/i) || [])[1] || '';
                    const d = a.time ? new Date(a.time) : null;
                    const time = d && !isNaN(d.getTime())
                        ? d.toLocaleDateString(undefined, { month: 'short', day: 'numeric', year: 'numeric' })
                            + ' · ' + d.toLocaleTimeString(undefined, { hour: '2-digit', minute: '2-digit' })
                        : '';
                    const coords = a.lat && a.lng
                        ? '<span class="nav-alert-detail text-muted">' + Number(a.lat).toFixed(5) + ', ' + Number(a.lng).toFixed(5) + '</span>'
                        : '';
                    const zoneHtml = zone
                        ? '<span class="nav-alert-detail"><i class="fas fa-draw-polygon"></i> ' + esc(zone) + '</span>'
                        : '';
                    return '<div class="nav-alert-item nav-alert-item--' + esc(a.type || 'info') + (isGf ? ' nav-alert-item--geofence' : '') + '">'
                        + '<strong>' + esc(a.title || 'Alert') + '</strong>'
                        + '<span>' + esc(a.message || '') + '</span>'
                        + zoneHtml + coords
                        + '<small>' + esc(time) + '</small></div>';
                }).join('');
                const badge = document.getElementById('navAlertBadge');
                const btn = document.getElementById('navAlertsBtn');
                const summary = document.getElementById('navAlertsSummary');
                if (badge) {
                    badge.hidden = false;
                    badge.textContent = alerts.length > 99 ? '99+' : String(alerts.length);
                }
                if (btn) btn.classList.add('has-unread');
                if (summary) {
                    summary.textContent = @json(__('app.map.alerts_new_count')).replace(':count', String(alerts.length));
                }
            }
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', bootMapBell);
            } else {
                bootMapBell();
            }
        })();
    </script>
    @endif
    <script src="{{ protected_js('map-session-guard.js') }}"></script>
    <script src="{{ protected_js('device-map-tracker.js') }}"></script>
    <script src="{{ protected_js('map-tour.js') }}"></script>
@endpush

