<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link rel="icon" href="data:,">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer-orders.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        body {
            background: #f5f5f5;
            min-height: 100vh;
        }

        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
        }

        /* ── Dashboard Container ── */
        .dashboard-container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: 24px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }

        /* ── Page Header ── */
        .page-header {
            margin-bottom: 1.6rem;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.4rem;
        }

        .page-title-icon {
            width: 52px;
            height: 52px;
            background: #fff6ed;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #f97316;
        }

        .title-wrapper h2 {
            font-size: 1.9rem;
            font-weight: 800;
            color: #111827;
            line-height: 1.2;
        }

        .title-wrapper .subtitle {
            color: #6b7280;
            font-size: 0.88rem;
            font-weight: 400;
            margin-top: 2px;
        }

        /* ── Stats Cards ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 0.9rem;
            margin-bottom: 1.4rem;
        }

        .stat-card {
            background: white;
            border: 1.5px solid #e5e7eb;
            border-radius: 16px;
            padding: 0.9rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
            transition: all 0.2s ease;
            position: relative;
        }

        .stat-card:hover {
            border-color: #f97316;
            box-shadow: 0 4px 12px rgba(249,115,22,0.1);
        }

        .stat-card.active {
            background: #f97316;
            border-color: #f97316;
        }

        .stat-card.active .stat-label,
        .stat-card.active .stat-number {
            color: white;
        }

        .stat-card.active .stat-icon-wrap {
            background: rgba(255,255,255,0.25);
            color: white;
        }

        .stat-icon-wrap {
            width: 38px;
            height: 38px;
            background: #f3f4f6;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            color: #f97316;
            flex-shrink: 0;
        }

        .stat-text {
            flex: 1;
            min-width: 0;
        }

        .stat-number {
            font-size: 1.35rem;
            font-weight: 800;
            color: #111827;
            line-height: 1.1;
        }

        .stat-label {
            font-size: 0.72rem;
            font-weight: 600;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-top: 1px;
        }

        .stat-badge {
            font-size: 0.68rem;
            font-weight: 600;
            padding: 0.18rem 0.45rem;
            border-radius: 20px;
            display: flex;
            align-items: center;
            gap: 3px;
            white-space: nowrap;
        }

        .stat-badge.new-badge {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .stat-badge.count-badge {
            background: #e0f2fe;
            color: #0369a1;
        }

        .stat-badge.green-badge {
            background: #dcfce7;
            color: #15803d;
        }

        /* ── Filter + Search Row ── */
        .filter-search-row {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.4rem;
            flex-wrap: wrap;
        }

        .filter-chips {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .filter-chip {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.45rem 1rem;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1.5px solid #e5e7eb;
            background: white;
            color: #4b5563;
        }

        .filter-chip .chip-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .filter-chip:hover {
            border-color: #f97316;
            color: #f97316;
        }

        .filter-chip.active {
            background: #f97316;
            border-color: #f97316;
            color: white;
        }

        .filter-chip.active .chip-dot {
            background: white !important;
        }

        .dot-orange { background: #f97316; }
        .dot-yellow { background: #fbbf24; }
        .dot-blue   { background: #60a5fa; }
        .dot-green  { background: #34d399; }

        .search-box {
            flex: 1;
            max-width: 320px;
            margin-left: auto;
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            font-size: 0.85rem;
        }

        .search-box input {
            width: 100%;
            padding: 0.5rem 1rem 0.5rem 2.2rem;
            border: 1.5px solid #e5e7eb;
            border-radius: 30px;
            font-size: 0.85rem;
            color: #374151;
            outline: none;
            transition: border-color 0.2s;
            background: #f9fafb;
        }

        .search-box input:focus {
            border-color: #f97316;
            background: white;
        }

        .search-box input::placeholder {
            color: #9ca3af;
        }

        /* ── Orders Grid ── */
        .orders-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        @media (max-width: 768px) {
            .orders-grid { grid-template-columns: 1fr; }
        }

        /* ── Order Card ── */
        .order-card {
            background: white;
            border: 1.5px solid #e5e7eb;
            border-radius: 16px;
            padding: 1.1rem 1.2rem;
            cursor: pointer;
            transition: all 0.2s ease;
            position: relative;
        }

        .order-card:hover {
            border-color: #f97316;
            box-shadow: 0 6px 20px rgba(249,115,22,0.1);
            transform: translateY(-2px);
        }

        .order-card-header {
            display: flex;
            align-items: flex-start;
            gap: 0.8rem;
            margin-bottom: 0.9rem;
        }

        .restaurant-logo {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            font-weight: 700;
            color: #374151;
            flex-shrink: 0;
            overflow: hidden;
            border: 1.5px solid #e5e7eb;
        }

        .restaurant-logo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .order-info {
            flex: 1;
            min-width: 0;
        }

        .restaurant-name {
            font-size: 1rem;
            font-weight: 700;
            color: #111827;
            margin-bottom: 2px;
        }

        .order-items {
            font-size: 0.8rem;
            color: #6b7280;
            font-weight: 400;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .order-amount {
            font-size: 1.05rem;
            font-weight: 800;
            color: #111827;
            flex-shrink: 0;
        }

        /* ── Progress Tracker ── */
        .progress-tracker {
            display: flex;
            align-items: center;
            gap: 0;
            margin-bottom: 0.9rem;
            overflow: hidden;
        }

        .progress-step {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 0.72rem;
            font-weight: 500;
            color: #9ca3af;
            white-space: nowrap;
        }

        .progress-step.done {
            color: #f97316;
        }

        .progress-step.active {
            color: #f97316;
            font-weight: 600;
        }

        .progress-step .step-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #d1d5db;
            flex-shrink: 0;
        }

        .progress-step.done .step-dot {
            background: #f97316;
        }

        .progress-step.active .step-dot {
            background: #f97316;
            box-shadow: 0 0 0 3px rgba(249,115,22,0.2);
        }

        .progress-step.complete .step-dot {
            background: #22c55e;
        }

        .progress-step.complete {
            color: #22c55e;
        }

        .progress-line {
            flex: 1;
            height: 2px;
            background: #e5e7eb;
            min-width: 18px;
            max-width: 40px;
        }

        .progress-line.done {
            background: #f97316;
        }

        .progress-line.complete {
            background: #22c55e;
        }

        /* ── Card Footer ── */
        .order-card-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .order-time {
            display: flex;
            align-items: center;
            gap: 0.35rem;
            font-size: 0.78rem;
            color: #6b7280;
        }

        .order-time i {
            color: #9ca3af;
            font-size: 0.75rem;
        }

        .card-actions {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .btn-view {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.42rem 0.9rem;
            border: 1.5px solid #e5e7eb;
            border-radius: 30px;
            font-size: 0.78rem;
            font-weight: 500;
            color: #374151;
            background: white;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-view:hover {
            border-color: #f97316;
            color: #f97316;
        }

        .btn-reorder {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.42rem 0.9rem;
            border: 1.5px solid #fed7aa;
            border-radius: 30px;
            font-size: 0.78rem;
            font-weight: 600;
            color: #f97316;
            background: #fff7ed;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-reorder:hover {
            background: #f97316;
            color: white;
            border-color: #f97316;
        }

        .btn-track {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.45rem 1rem;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 600;
            color: white;
            background: #f97316;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 4px 12px rgba(249,115,22,0.3);
        }

        .btn-track:hover {
            background: #ea580c;
        }

        .btn-confirm {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.45rem 1rem;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 600;
            color: white;
            background: #22c55e;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-confirm:hover {
            background: #16a34a;
        }

        /* ── Load More ── */
        .load-more-row {
            display: flex;
            justify-content: center;
            margin-top: 1rem;
        }

        .load-more-btn {
            padding: 0.7rem 2.5rem;
            border: 1.5px solid #e5e7eb;
            border-radius: 12px;
            background: white;
            font-size: 0.85rem;
            font-weight: 500;
            color: #374151;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
        }

        .load-more-btn:hover {
            border-color: #f97316;
            color: #f97316;
        }

        /* ── Empty State ── */
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: #6b7280;
            grid-column: 1/-1;
        }

        .empty-state i {
            font-size: 3rem;
            color: #d1d5db;
            margin-bottom: 1rem;
        }

        .empty-state p {
            font-size: 1rem;
            font-weight: 500;
        }

        /* ── Message Area ── */
        .message-area {
            margin: 0.8rem 0;
            padding: 0.8rem 1.2rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-size: 0.88rem;
            font-weight: 500;
            animation: slideIn 0.3s ease;
            border-left: 4px solid;
        }

        .message-area.success { background: #f0fdf4; color: #166534; border-left-color: #22c55e; }
        .message-area.error   { background: #fef2f2; color: #991b1b; border-left-color: #ef4444; }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ── Loading Skeleton ── */
        .skeleton-card {
            background: white;
            border: 1.5px solid #e5e7eb;
            border-radius: 16px;
            padding: 1.1rem 1.2rem;
        }

        .skeleton {
            background: linear-gradient(90deg, #f3f4f6 25%, #e5e7eb 50%, #f3f4f6 75%);
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
            border-radius: 8px;
        }

        @keyframes shimmer {
            0%   { background-position: -200% 0; }
            100% { background-position:  200% 0; }
        }

        /* ── Modal ── */
        .order-details-modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(15,23,42,0.65);
            backdrop-filter: blur(6px);
            z-index: 10000;
            align-items: center;
            justify-content: center;
        }

        .order-details-modal.active { display: flex; }

        .modal-window {
            background: white;
            border-radius: 24px;
            width: 90%;
            max-width: 820px;
            max-height: 90vh;
            overflow: hidden;
            box-shadow: 0 30px 60px rgba(0,0,0,0.2);
            animation: modalIn 0.25s ease;
        }

        @keyframes modalIn {
            from { opacity: 0; transform: scale(0.95) translateY(10px); }
            to   { opacity: 1; transform: scale(1)    translateY(0); }
        }

        .modal-header {
            background: linear-gradient(135deg, #f97316, #fb923c);
            color: white;
            padding: 1.1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-header h3 {
            font-size: 1.2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .close-btn {
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            width: 34px; height: 34px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 1rem;
        }

        .close-btn:hover {
            background: rgba(255,255,255,0.3);
            transform: rotate(90deg);
        }

        /* ── Loading Overlay ── */
        .loading-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(255,255,255,0.85);
            backdrop-filter: blur(3px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10001;
        }

        .loading-overlay.active { display: flex; }

        .loading-spinner {
            width: 48px; height: 48px;
            border: 3px solid #f1f5f9;
            border-top-color: #f97316;
            border-right-color: #f97316;
            border-radius: 50%;
            animation: spin 0.7s linear infinite;
        }

        @keyframes spin { to { transform: rotate(360deg); } }

        /* ── Responsive ── */
        @media (max-width: 1024px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 768px) {
            .content { padding: 1rem 1rem 1rem 4rem; }
            .content.shift { margin-left: 0; }
            .dashboard-container { padding: 1.2rem; }
            .stats-grid { grid-template-columns: repeat(2, 1fr); gap: 0.6rem; }
            .filter-search-row { gap: 0.5rem; }
            .search-box { max-width: 100%; margin-left: 0; }
        }

        @media (max-width: 480px) {
            .stats-grid { grid-template-columns: 1fr 1fr; }
            .orders-grid { grid-template-columns: 1fr; }
            .load-more-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<div class="content" id="mainContent">
    <div class="dashboard-container">

        <!-- Page Header -->
        <div class="page-header">
            <div class="page-title">
                <div class="page-title-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="title-wrapper">
                    <h2>My Orders</h2>
                    <span class="subtitle">Track and manage your orders in real-time</span>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid" id="statsGrid">
                <!-- Populated by JS -->
            </div>
        </div>

        <!-- Search Row -->
        <div class="filter-search-row">
            <div class="search-box" style="max-width:100%;margin-left:0;flex:1;">
                <i class="fas fa-search"></i>
                <input type="text" id="orderSearch" placeholder="Search by restaurant or item..." oninput="searchOrders(this.value)">
            </div>
        </div>

        <!-- Orders Grid -->
        <div class="orders-grid" id="ordersGrid">
            <!-- Skeleton loaders -->
            <div class="skeleton-card" id="skel1">
                <div style="display:flex;gap:0.8rem;margin-bottom:0.9rem;">
                    <div class="skeleton" style="width:46px;height:46px;border-radius:12px;flex-shrink:0;"></div>
                    <div style="flex:1;">
                        <div class="skeleton" style="height:14px;width:60%;margin-bottom:6px;"></div>
                        <div class="skeleton" style="height:11px;width:80%;"></div>
                    </div>
                    <div class="skeleton" style="width:60px;height:14px;border-radius:6px;"></div>
                </div>
                <div class="skeleton" style="height:10px;width:100%;margin-bottom:10px;border-radius:6px;"></div>
                <div style="display:flex;justify-content:space-between;">
                    <div class="skeleton" style="height:11px;width:40%;border-radius:6px;"></div>
                    <div class="skeleton" style="height:28px;width:30%;border-radius:20px;"></div>
                </div>
            </div>
            <div class="skeleton-card" id="skel2">
                <div style="display:flex;gap:0.8rem;margin-bottom:0.9rem;">
                    <div class="skeleton" style="width:46px;height:46px;border-radius:12px;flex-shrink:0;"></div>
                    <div style="flex:1;">
                        <div class="skeleton" style="height:14px;width:55%;margin-bottom:6px;"></div>
                        <div class="skeleton" style="height:11px;width:70%;"></div>
                    </div>
                    <div class="skeleton" style="width:60px;height:14px;border-radius:6px;"></div>
                </div>
                <div class="skeleton" style="height:10px;width:100%;margin-bottom:10px;border-radius:6px;"></div>
                <div style="display:flex;justify-content:space-between;">
                    <div class="skeleton" style="height:11px;width:35%;border-radius:6px;"></div>
                    <div class="skeleton" style="height:28px;width:35%;border-radius:20px;"></div>
                </div>
            </div>
        </div>

        <!-- Load More Row -->
        <div class="load-more-row" id="loadMoreRow" style="display:none;">
            <button class="load-more-btn" onclick="loadMore()">Load More</button>
        </div>

    </div>
</div>

<!-- Order Details Modal -->
<div class="order-details-modal" id="orderDetailsModal">
    <div class="modal-window">
        <div class="modal-header">
            <h3><i class="fas fa-receipt"></i> Order Details</h3>
            <button class="close-btn" onclick="closeOrderDetails()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body" id="orderDetailsContent" style="overflow-y:auto;max-height:calc(90vh - 70px);">
            <div style="text-align:center;padding:2rem;">
                <i class="fas fa-spinner fa-spin" style="font-size:2rem;color:#f97316;"></i>
                <p style="margin-top:1rem;color:#6b7280;">Loading order details...</p>
            </div>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner"></div>
</div>

<script>
    const contextPath = "${pageContext.request.contextPath}";
    let allOrders = [];
    let filteredOrders = [];
    let currentFilter = null;
    let currentSearch = '';
    const PAGE_SIZE = 4;
    let visibleCount = PAGE_SIZE;

    /* ─── Helpers ─── */
    function getField(obj, ...keys) {
        for (const k of keys) if (obj && obj[k] != null) return obj[k];
        return null;
    }

    function formatDate(val) {
        if (!val) return '';
        try {
            const d = new Date(val);
            return d.toLocaleString('en-IN', { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' });
        } catch(e) { return val; }
    }

    /* ─── Status config ─── */
    const STATUS_CONFIG = {
        'PLACED': { label: 'Placed', step: 0, color: '#f97316' },
        'ACCEPTED': { label: 'Accepted', step: 0, color: '#f97316' },
        'PREPARING': { label: 'Preparing', step: 0, color: '#f97316' },
        'READY': { label: 'Ready', step: 1, color: '#f97316' },
        'OUT_FOR_DELIVERY': { label: 'Out for Delivery', step: 1, color: '#f97316' },
        'DELIVERED': { label: 'Delivered', step: 2, color: '#22c55e' },
        'CANCELLED': { label: 'Cancelled', step: -1, color: '#ef4444' },
        'REJECTED': { label: 'Rejected', step: -1, color: '#ef4444' }
    };

    /* ─── Render progress tracker ─── */
    function renderProgress(status) {
        const steps = ['Placed', 'Out for Delivery', 'Delivered'];
        const cfg = STATUS_CONFIG[status] || STATUS_CONFIG['PLACED'];
        const currentStep = cfg.step;
        const isDelivered = status === 'DELIVERED';
        const isRejected = status === 'REJECTED' || status === 'CANCELLED';

        if (isRejected) {
            return '<div class="progress-tracker">' +
                '<div class="progress-step" style="color:#ef4444;">' +
                '<span class="step-dot" style="background:#ef4444;"></span> ' + status.charAt(0) + status.slice(1).toLowerCase() + '</div>' +
                '</div>';
        }

        let html = '<div class="progress-tracker">';
        steps.forEach(function(step, i) {
            const isDone = isDelivered ? true : (i <= currentStep);
            let cls = '';
            if (isDelivered) cls = 'complete';
            else if (isDone) cls = 'done';

            html += '<div class="progress-step ' + cls + '">';
            html += '<span class="step-dot"></span> ' + step;
            html += '</div>';

            if (i < steps.length - 1) {
                let lineCls = isDelivered ? 'complete' : (i < currentStep ? 'done' : '');
                html += '<div class="progress-line ' + lineCls + '"></div>';
            }
        });
        html += '</div>';
        return html;
    }

    /* ─── Restaurant icon/avatar ─── */
    function renderLogo(restaurantName) {
        if (!restaurantName) {
            return '<div class="restaurant-logo"><i class="fas fa-store" style="font-size:1.1rem;color:#9ca3af;"></i></div>';
        }
        const name = restaurantName.trim();
        const initials = name.split(' ').map(w => w[0]).join('').substring(0, 2).toUpperCase();
        const colors = ['#f97316','#ef4444','#8b5cf6','#3b82f6','#10b981','#f59e0b'];
        const color = colors[name.charCodeAt(0) % colors.length];
        return '<div class="restaurant-logo" style="background:' + color + '20;border-color:' + color + '30;color:' + color + ';font-weight:700;font-size:0.85rem;">' + initials + '</div>';
    }

    /* ─── Get item summary (fallback since items not in response) ─── */
    function getItemSummary(order) {
        // Since items aren't in the response, create a generic summary
        // You can modify this if you add items to your response later
        const restaurantName = getField(order, 'restaurantName', 'restaurant_name', 'restaurant') || 'Restaurant';
        return 'Order from ' + restaurantName;
    }

    /* ─── Render action buttons ─── */
    function renderActions(order) {
        const orderId = getField(order, 'orderId', 'id', 'order_id');
        const status = getField(order, 'status', 'orderStatus');

        if (status === 'OUT_FOR_DELIVERY') {
            return '<button class="btn-confirm" onclick="confirmDelivery(' + orderId + ', this, event)">' +
                '<i class="fas fa-check-circle"></i> Confirm Delivery</button>';
        }
        if (status === 'PLACED' || status === 'ACCEPTED' || status === 'PREPARING' || status === 'READY') {
            return '<button class="btn-track" onclick="openOrderDetails(' + orderId + '); event && event.stopPropagation();">' +
                '<i class="fas fa-location-dot"></i> Track Order</button>';
        }
        if (status === 'DELIVERED' || status === 'CANCELLED' || status === 'REJECTED') {
            return '<button class="btn-view" onclick="openOrderDetails(' + orderId + '); event && event.stopPropagation();">' +
                '<i class="fas fa-search"></i> View Details</button>' +
                '<button class="btn-reorder" onclick="event.stopPropagation(); showMessage(\'Reorder coming soon!\', \'success\');">' +
                '<i class="fas fa-redo"></i> Reorder</button>';
        }
        return '<button class="btn-view" onclick="openOrderDetails(' + orderId + '); event && event.stopPropagation();">' +
            '<i class="fas fa-search"></i> View Details</button>';
    }

    /* ─── Build a single order card ─── */
    function buildOrderCard(order) {
        const orderId     = getField(order, 'orderId', 'id', 'order_id');
        const status      = getField(order, 'status', 'orderStatus') || 'PLACED';
        const amount      = getField(order, 'totalAmount', 'total_Amount', 'total', 'amount') || 0;
        const lastUpdated = getField(order, 'lastUpdated', 'last_Updated', 'updatedAt', 'updateDate') ||
                            getField(order, 'createdAt', 'created_At', 'createdDate');
        const restaurant  = getField(order, 'restaurantName', 'restaurant_name', 'restaurant') || 'Restaurant';
        const itemsText   = getItemSummary(order);

        return '<div class="order-card" onclick="openOrderDetails(' + orderId + ')">' +
            '<div class="order-card-header">' +
            renderLogo(restaurant) +
            '<div class="order-info">' +
            '<div class="restaurant-name">' + restaurant + '</div>' +
            '<div class="order-items">' + itemsText + '</div>' +
            '</div>' +
            '<div class="order-amount">₹' + parseFloat(amount).toFixed(0) + '</div>' +
            '</div>' +
            renderProgress(status) +
            '<div class="order-card-footer">' +
            '<div class="order-time"><i class="fas fa-clock"></i> ' + (formatDate(lastUpdated) || '—') + '</div>' +
            '<div class="card-actions">' + renderActions(order) + '</div>' +
            '</div>' +
            '</div>';
    }

    /* ─── Render orders grid ─── */
    function renderOrders() {
        const grid = $('#ordersGrid');
        const toShow = filteredOrders.slice(0, visibleCount);

        if (filteredOrders.length === 0) {
            grid.html('<div class="empty-state"><i class="fas fa-shopping-bag"></i><p>No orders found</p></div>');
            $('#loadMoreRow').hide();
            return;
        }

        let html = '';
        toShow.forEach(function(order) {
            html += buildOrderCard(order);
        });
        grid.html(html);

        // Load more button
        if (filteredOrders.length > visibleCount) {
            $('#loadMoreRow').show();
        } else {
            $('#loadMoreRow').hide();
        }
    }

    /* ─── Update stats ─── */
    function updateStats(orders) {
        const total     = orders.length;
        const placed    = orders.filter(function(o){
            const status = getField(o, 'status', 'orderStatus');
            return status === 'PLACED' || status === 'ACCEPTED' || status === 'PREPARING' || status === 'READY';
        }).length;
        const onTheWay  = orders.filter(function(o){
            return getField(o, 'status', 'orderStatus') === 'OUT_FOR_DELIVERY';
        }).length;
        const delivered = orders.filter(function(o){
            return getField(o, 'status', 'orderStatus') === 'DELIVERED';
        }).length;

        $('#statsGrid').html(
            '<div class="stat-card ' + (currentFilter === null ? 'active' : '') + '" onclick="filterByStatus(null)">' +
            '<div class="stat-icon-wrap"><i class="fas fa-shopping-bag"></i></div>' +
            '<div class="stat-text"><div class="stat-number">' + total + '</div><div class="stat-label">Total Orders</div></div>' +
            '</div>' +

            '<div class="stat-card ' + (currentFilter === 'active' ? 'active' : '') + '" onclick="filterByStatus(\'active\')">' +
            '<div class="stat-icon-wrap"><i class="fas fa-clock"></i></div>' +
            '<div class="stat-text"><div class="stat-number">' + placed + '</div><div class="stat-label">Active Orders</div></div>' +
            (placed > 0 ? '<span class="stat-badge new-badge"><i class="fas fa-bolt"></i> ' + placed + '</span>' : '') +
            '</div>' +

            '<div class="stat-card ' + (currentFilter === 'OUT_FOR_DELIVERY' ? 'active' : '') + '" onclick="filterByStatus(\'OUT_FOR_DELIVERY\')">' +
            '<div class="stat-icon-wrap"><i class="fas fa-truck"></i></div>' +
            '<div class="stat-text"><div class="stat-number">' + onTheWay + '</div><div class="stat-label">Out for Delivery</div></div>' +
            (onTheWay > 0 ? '<span class="stat-badge count-badge">↗ ' + onTheWay + '</span>' : '') +
            '</div>' +

            '<div class="stat-card ' + (currentFilter === 'DELIVERED' ? 'active' : '') + '" onclick="filterByStatus(\'DELIVERED\')">' +
            '<div class="stat-icon-wrap"><i class="fas fa-check-circle"></i></div>' +
            '<div class="stat-text"><div class="stat-number">' + delivered + '</div><div class="stat-label">Delivered</div></div>' +
            (delivered > 0 ? '<span class="stat-badge green-badge">✓ ' + delivered + '</span>' : '') +
            '</div>'
        );
    }

    /* ─── Apply filter + search ─── */
    function applyFilters() {
        filteredOrders = allOrders.filter(function(o) {
            const status = getField(o, 'status', 'orderStatus') || '';


            let matchFilter = true;
            if (currentFilter === 'active') {
                matchFilter = ['PLACED', 'ACCEPTED', 'PREPARING', 'READY', 'OUT_FOR_DELIVERY'].includes(status);
            } else if (currentFilter) {
                matchFilter = status === currentFilter;
            }

            if (!matchFilter) return false;


            if (!currentSearch) return true;

            const q = currentSearch.toLowerCase();
            const restaurant = (getField(o, 'restaurantName', 'restaurant_name', 'restaurant') || '').toLowerCase();
            return restaurant.includes(q);
        });

        visibleCount = PAGE_SIZE;
        renderOrders();
    }

    /* ─── Filter by status ─── */
    function filterByStatus(status) {
        currentFilter = status;
        updateStats(allOrders);
        applyFilters();
    }

    /* ─── Search ─── */
    function searchOrders(val) {
        currentSearch = val;
        applyFilters();
    }

    /* ─── Load more ─── */
    function loadMore() {
        visibleCount += PAGE_SIZE;
        renderOrders();
    }

    /* ─── Fetch orders ─── */
    function fetchOrders() {
        $('#ordersGrid').html(`
            <div class="skeleton-card">
                <div style="display:flex;gap:0.8rem;margin-bottom:0.9rem;">
                    <div class="skeleton" style="width:46px;height:46px;border-radius:12px;"></div>
                    <div style="flex:1;">
                        <div class="skeleton" style="height:14px;width:60%;margin-bottom:6px;"></div>
                        <div class="skeleton" style="height:11px;width:80%;"></div>
                    </div>
                </div>
            </div>
            <div class="skeleton-card">
                <div style="display:flex;gap:0.8rem;margin-bottom:0.9rem;">
                    <div class="skeleton" style="width:46px;height:46px;border-radius:12px;"></div>
                    <div style="flex:1;">
                        <div class="skeleton" style="height:14px;width:60%;margin-bottom:6px;"></div>
                        <div class="skeleton" style="height:11px;width:80%;"></div>
                    </div>
                </div>
            </div>
        `);

        $.ajax({
            url: contextPath + "/customer/orders/get-all-orders-with-restaurant",
            type: "GET",
            success: function(response) {
                let orders = [];


                if (response && response.data && Array.isArray(response.data)) {
                    orders = response.data;
                } else if (Array.isArray(response)) {
                    orders = response;
                } else if (response && response.orders && Array.isArray(response.orders)) {
                    orders = response.orders;
                }


                orders = orders.map(function(o) {
                    return {
                        orderId: o.orderId || o.id,
                        status: o.status || 'PLACED',
                        lastUpdated: o.lastUpdated || o.updatedAt || o.createdAt,
                        totalAmount: o.totalAmount || o.amount || 0,
                        createdAt: o.createdAt,
                        restaurantId: o.restaurantId,
                        restaurantName: o.restaurantName || 'Restaurant'
                    };
                });


                orders.sort(function(a, b) {
                    return new Date(b.createdAt || 0) - new Date(a.createdAt || 0);
                });

                allOrders = orders;
                filteredOrders = orders.slice();
                updateStats(orders);
                renderOrders();
            },
            error: function(xhr) {
                if (xhr.status === 401) {

                    if (confirm('Your session has expired. Please login again.')) {
                        window.location.href = contextPath + '/login';
                    }
                } else {
                    showMessage('Failed to load orders. Please refresh.', 'error');
                    $('#ordersGrid').html('<div class="empty-state"><i class="fas fa-exclamation-circle"></i><p>Could not load orders</p></div>');
                }
            }
        });
    }

    /* ─── Confirm delivery ─── */
    function confirmDelivery(orderId, button, event) {
        event && event.stopPropagation();
        if (!orderId) { showMessage('Error: Order ID missing', 'error'); return; }
        if (!confirm('Have you received your order? Click OK to confirm delivery.')) return;

        const $btn = $(button);
        const orig = $btn.html();
        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Confirming...');

        $.ajax({
            url: contextPath + "/customer/orders/" + orderId + "/confirm-delivery",
            type: "POST",
            success: function() {
                showMessage('Delivery confirmed! Thank you for ordering.', 'success');
                fetchOrders();
            },
            error: function(xhr) {
                showMessage('Failed to confirm delivery. Please try again.', 'error');
                $btn.prop('disabled', false).html(orig);
                if (xhr.status === 401) {
                    if (confirm('Your session has expired. Please login again.')) {
                        window.location.href = contextPath + '/login';
                    }
                }
            }
        });
    }


    function openOrderDetails(orderId) {
        if (!orderId) {
            showMessage('Error: Order ID missing', 'error');
            return;
        }

        $('#loadingOverlay').addClass('active');
        $('#orderDetailsModal').addClass('active');

        $.ajax({
            url: contextPath + "/customer/orders/" + orderId + "/details",
            type: "GET",
            success: function(response) {
                $('#orderDetailsContent').html(response);
                $('#loadingOverlay').removeClass('active');
            },
            error: function(xhr) {
                $('#loadingOverlay').removeClass('active');
                if (xhr.status === 401) {
                    $('#orderDetailsModal').removeClass('active');
                    if (confirm('Your session has expired. Please login again.')) {
                        window.location.href = contextPath + '/login';
                    }
                } else {
                    $('#orderDetailsContent').html(
                        '<div style="text-align:center;padding:3rem;color:#991b1b;">' +
                        '<i class="fas fa-exclamation-circle" style="font-size:3rem;margin-bottom:1rem;"></i>' +
                        '<p>Failed to load order details. Please try again.</p>' +
                        '<button onclick="closeOrderDetails()" style="margin-top:1rem;padding:0.5rem 1.5rem;border:none;border-radius:8px;background:#f97316;color:white;cursor:pointer;">Close</button>' +
                        '</div>'
                    );
                }
            }
        });
    }

    function closeOrderDetails() {
        $('#orderDetailsModal').removeClass('active');
        $('#orderDetailsContent').html(
            '<div style="text-align:center;padding:2rem;">' +
            '<i class="fas fa-spinner fa-spin" style="font-size:2rem;color:#f97316;"></i>' +
            '<p style="margin-top:1rem;color:#6b7280;">Loading order details...</p></div>'
        );
    }

    /* ─── Show message ─── */
    function showMessage(message, type) {
        $('.message-area').remove();
        const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
        const el = $('<div class="message-area ' + type + '"><i class="fas ' + icon + '"></i><span>' + message + '</span></div>');
        $('.filter-search-row').before(el);
        setTimeout(function() {
            el.fadeOut(300, function(){ $(this).remove(); });
        }, 3000);
    }

    $(document).ready(function() {
        fetchOrders();


        $(window).on('click', function(e) {
            if ($(e.target).hasClass('order-details-modal')) {
                closeOrderDetails();
            }
        });


        $(document).on('keydown', function(e) {
            if (e.key === 'Escape' && $('#orderDetailsModal').hasClass('active')) {
                closeOrderDetails();
            }
        });
    });


    document.addEventListener("DOMContentLoaded", function() {
        const hamburger = document.getElementById("hamburgerBtn");
        const sidebar   = document.getElementById("sidebar");
        const mainContent = document.getElementById("mainContent");

        if (hamburger && sidebar && mainContent) {
            hamburger.addEventListener("click", function(e) {
                e.stopPropagation();
                sidebar.classList.toggle("open");
                mainContent.classList.toggle("shift");
            });
            document.addEventListener('click', function(e) {
                if (!sidebar.contains(e.target) && !hamburger.contains(e.target) && sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    mainContent.classList.remove('shift');
                }
            });
        }
    });
</script>
</body>
</html>
