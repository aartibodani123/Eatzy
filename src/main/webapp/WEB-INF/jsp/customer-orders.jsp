<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link rel="icon" href="data:,">

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

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
            background: linear-gradient(145deg, #f8fafc 0%, #f1f5f9 100%);
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

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(226, 232, 240, 0.4);
        }

        /* Enhanced Header Section */
        .page-header {
            margin-bottom: 2.5rem;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 1.2rem;
            margin-bottom: 1.8rem;
        }

        .page-title i {
            font-size: 2.2rem;
            color: #f97316;
            background: linear-gradient(135deg, #fff6ed 0%, #ffe4d6 100%);
            padding: 1rem;
            border-radius: 18px;
            box-shadow: 0 10px 20px -10px rgba(249, 115, 22, 0.3);
        }

        .title-wrapper {
            display: flex;
            flex-direction: column;
        }

        .title-wrapper h2 {
            font-size: 2.4rem;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.02em;
            line-height: 1.2;
        }

        .title-wrapper .subtitle {
            color: #64748b;
            font-size: 0.95rem;
            font-weight: 500;
            margin-top: 0.2rem;
        }

        /* Enhanced Stats Cards - Now below title */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.2rem;
            margin-top: 1.5rem;
        }

        .stat-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 1.5rem 1.2rem;
            display: flex;
            align-items: center;
            gap: 1.2rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(249, 115, 22, 0.15), 0 10px 10px -5px rgba(249, 115, 22, 0.05);
            border-color: #f97316;
        }

        .stat-card.active {
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            border-color: #f97316;
        }

        .stat-card.active .stat-icon,
        .stat-card.active .stat-info h3,
        .stat-card.active .stat-info p {
            color: white;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(249, 115, 22, 0.1) 0%, rgba(249, 115, 22, 0) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            background: #f8fafc;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            color: #f97316;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .stat-card:hover .stat-icon {
            background: white;
            transform: scale(1.1) rotate(5deg);
        }

        .stat-info {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .stat-info h3 {
            font-size: 1.8rem;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.2;
            margin-bottom: 0.2rem;
        }

        .stat-info p {
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-trend {
            font-size: 0.85rem;
            color: #22c55e;
            background: #dcfce7;
            padding: 0.2rem 0.6rem;
            border-radius: 40px;
            margin-left: 0.5rem;
            font-weight: 600;
        }

        /* Enhanced Table Container */
        .table-container {
            background: white;
            border-radius: 28px;
            padding: 1.8rem;
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
            margin-top: 2rem;
        }

        .table-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .table-title {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .table-title h3 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #0f172a;
        }

        .table-title span {
            background: #f1f5f9;
            color: #f97316;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .filter-chips {
            display: flex;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .filter-chip {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 40px;
            padding: 0.5rem 1.2rem;
            font-size: 0.9rem;
            font-weight: 500;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .filter-chip:hover {
            background: #fff6ed;
            border-color: #f97316;
            color: #f97316;
        }

        .filter-chip.active {
            background: #f97316;
            border-color: #f97316;
            color: white;
        }

        .filter-chip i {
            font-size: 0.8rem;
        }

        /* DataTables Customization */
        .dataTables_wrapper {
            font-family: 'Inter', sans-serif;
        }

        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter {
            margin-bottom: 1.8rem;
        }

        .dataTables_wrapper .dataTables_length label,
        .dataTables_wrapper .dataTables_filter label {
            color: #0f172a;
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .dataTables_wrapper .dataTables_length select {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 0.6rem 2rem 0.6rem 1rem;
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            outline: none;
            transition: all 0.2s;
            background: #f8fafc;
            cursor: pointer;
        }

        .dataTables_wrapper .dataTables_filter input {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 0.6rem 1rem;
            font-family: 'Inter', sans-serif;
            outline: none;
            transition: all 0.2s;
            min-width: 280px;
            background: #f8fafc;
        }

        .dataTables_wrapper .dataTables_length select:focus,
        .dataTables_wrapper .dataTables_filter input:focus {
            border-color: #f97316;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
            background: white;
        }

        /* Enhanced Table */
        #ordersTable {
            border-collapse: separate;
            border-spacing: 0 0.8rem;
            margin-top: 0.5rem;
        }

        #ordersTable thead th {
            background: #f8fafc;
            color: #0f172a;
            font-weight: 700;
            font-size: 0.9rem;
            padding: 1.2rem 1rem;
            border: none;
            border-bottom: 3px solid #f97316;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        #ordersTable thead th:first-child {
            border-radius: 20px 0 0 20px;
        }

        #ordersTable thead th:last-child {
            border-radius: 0 20px 20px 0;
        }

        #ordersTable tbody tr {
            background: white;
            border-radius: 20px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            cursor: pointer;
            border: 1px solid transparent;
        }

        #ordersTable tbody tr:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(249, 115, 22, 0.15), 0 10px 10px -5px rgba(249, 115, 22, 0.05);
            border-color: #f97316;
        }

        #ordersTable tbody td {
            padding: 1.4rem 1rem;
            border: none;
            color: #334155;
            font-weight: 500;
        }

        #ordersTable tbody td:first-child {
            border-radius: 20px 0 0 20px;
        }

        #ordersTable tbody td:last-child {
            border-radius: 0 20px 20px 0;
        }

        /* Enhanced Order ID */
        .order-id {
            font-weight: 700;
            color: #f97316;
            background: #fff6ed;
            padding: 0.4rem 1rem;
            border-radius: 40px;
            display: inline-block;
            font-size: 0.9rem;
            border: 1px solid #ffe4d6;
        }

        /* Enhanced Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1.2rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
            border: 1px solid transparent;
        }

        .status-badge i {
            font-size: 0.7rem;
        }

        .status-placed {
            background: #fef3c7;
            color: #92400e;
            border-color: #fde68a;
        }

        .status-accepted {
            background: #dbeafe;
            color: #1e40af;
            border-color: #bfdbfe;
        }

        .status-preparing {
            background: #dcfce7;
            color: #166534;
            border-color: #bbf7d0;
        }

        .status-ready {
            background: #cffafe;
            color: #0891b2;
            border-color: #a5f3fc;
        }

        .status-out_for_delivery {
            background: #fed7aa;
            color: #9a3412;
            border-color: #fdba74;
        }

        .status-delivered {
            background: #e0f2fe;
            color: #0369a1;
            border-color: #bae6fd;
        }

        .status-rejected {
            background: #fee2e2;
            color: #b91c1c;
            border-color: #fecaca;
        }

        /* Enhanced Action Button */
        .action-btn {
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.6rem 1.4rem;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.7rem;
            position: relative;
            z-index: 10;
            box-shadow: 0 10px 15px -3px rgba(249, 115, 22, 0.3);
        }

        .action-btn:hover {
            background: linear-gradient(135deg, #ea580c 0%, #f97316 100%);
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(249, 115, 22, 0.4);
        }

        .action-btn.confirm {
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            box-shadow: 0 10px 15px -3px rgba(34, 197, 94, 0.3);
        }

        .action-btn.confirm:hover {
            background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
        }

        /* Enhanced Date Display */
        .date-display {
            display: flex;
            flex-direction: column;
            gap: 0.2rem;
        }

        .date-main {
            font-weight: 600;
            color: #0f172a;
            font-size: 0.9rem;
        }

        .date-time {
            font-size: 0.75rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .date-time i {
            color: #f97316;
            font-size: 0.7rem;
        }

        /* Message Area */
        .message-area {
            margin: 1rem 0;
            padding: 1rem 1.5rem;
            border-radius: 16px;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: slideIn 0.3s ease;
            font-weight: 500;
            border-left: 4px solid;
        }

        .message-area.success {
            background: #f0fdf4;
            color: #166534;
            border-left-color: #22c55e;
        }

        .message-area.error {
            background: #fef2f2;
            color: #991b1b;
            border-left-color: #ef4444;
        }

        .message-area i {
            font-size: 1.2rem;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Modal Enhancements */
        .order-details-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(8px);
            z-index: 10000;
            align-items: center;
            justify-content: center;
        }

        .order-details-modal.active {
            display: flex;
        }

        .modal-window {
            background: white;
            border-radius: 32px;
            width: 90%;
            max-width: 900px;
            max-height: 90vh;
            overflow: hidden;
            box-shadow: 0 50px 70px -15px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .modal-header {
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            color: white;
            padding: 1.2rem 1.8rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-header h3 {
            font-size: 1.6rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .close-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 1.2rem;
            backdrop-filter: blur(4px);
        }

        .close-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(4px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10001;
        }

        .loading-overlay.active {
            display: flex;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid #f1f5f9;
            border-top-color: #f97316;
            border-right-color: #f97316;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .dashboard-container {
                padding: 1.5rem;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 0.8rem;
            }

            .stat-card {
                padding: 1rem;
            }

            .stat-icon {
                width: 48px;
                height: 48px;
                font-size: 1.4rem;
            }

            .stat-info h3 {
                font-size: 1.4rem;
            }

            .page-title h2 {
                font-size: 2rem;
            }

            .table-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Pagination Enhancement */
        .dataTables_paginate {
            padding-top: 1.5rem;
        }

        .dataTables_paginate .paginate_button {
            border-radius: 12px !important;
            margin: 0 0.2rem;
            border: 1px solid #e2e8f0 !important;
            background: white !important;
            color: #334155 !important;
            padding: 0.5rem 1rem !important;
            font-weight: 500 !important;
        }

        .dataTables_paginate .paginate_button.current {
            background: #f97316 !important;
            border-color: #f97316 !important;
            color: white !important;
        }

        .dataTables_paginate .paginate_button:hover {
            background: #fff6ed !important;
            border-color: #f97316 !important;
            color: #f97316 !important;
        }

        /* Info Text */
        .dataTables_info {
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 500;
            padding-top: 1rem;
        }
        /* Enhanced Stats Cards - Made Smaller */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
            margin-top: 1.2rem;
        }

        .stat-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 1rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.1);
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 12px -5px rgba(249, 115, 22, 0.15);
            border-color: #f97316;
        }

        .stat-card.active {
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            border-color: #f97316;
        }

        .stat-card.active .stat-icon,
        .stat-card.active .stat-info h3,
        .stat-card.active .stat-info p {
            color: white;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            background: #f8fafc;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #f97316;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.1);
        }

        .stat-card:hover .stat-icon {
            background: white;
            transform: scale(1.05) rotate(3deg);
        }

        .stat-info {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .stat-info h3 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.2;
            margin-bottom: 0.1rem;
        }

        .stat-info p {
            color: #64748b;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .stat-trend {
            font-size: 0.7rem;
            color: #22c55e;
            background: #dcfce7;
            padding: 0.15rem 0.4rem;
            border-radius: 30px;
            margin-left: 0.3rem;
            font-weight: 600;
        }

        /* Responsive adjustments for smaller stats */
        @media (max-width: 1024px) {
            .stats-grid {
                gap: 0.8rem;
            }
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 0.6rem;
            }

            .stat-card {
                padding: 0.8rem;
            }

            .stat-icon {
                width: 36px;
                height: 36px;
                font-size: 1rem;
                border-radius: 10px;
            }

            .stat-info h3 {
                font-size: 1.2rem;
            }

            .stat-info p {
                font-size: 0.7rem;
            }
        }

        @media (max-width: 480px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
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
                <i class="fas fa-shopping-bag"></i>
                <div class="title-wrapper">
                    <h2>My Orders</h2>
                    <span class="subtitle">Track and manage your orders in real-time</span>
                </div>
            </div>

            <!-- Stats Grid - Now below title -->
            <div class="stats-grid" id="statsGrid">
                <!-- Stats will be populated by JavaScript -->
            </div>
        </div>

        <!-- Orders Table -->
        <div class="table-container">
            <div class="table-header">
                <div class="table-title">
                    <h3>Order History</h3>
                    <span id="totalOrdersCount">0</span>
                </div>
                <div class="filter-chips">
                    <button class="filter-chip" onclick="clearAllFilters()">
                        <i class="fas fa-times"></i> Clear All
                    </button>
                    <button class="filter-chip" onclick="refreshTable()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
            </div>

            <table id="ordersTable" class="display" style="width:100%">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Last Updated</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<!-- Order Details Modal -->
<div class="order-details-modal" id="orderDetailsModal">
    <div class="modal-window">
        <div class="modal-header">
            <h3>
                <i class="fas fa-receipt"></i>
                Order Details
            </h3>
            <button class="close-btn" onclick="closeOrderDetails()">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="modal-body" id="orderDetailsContent">
            <div style="text-align: center; padding: 2rem;">
                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #f97316;"></i>
                <p style="margin-top: 1rem; color: #64748b;">Loading order details...</p>
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
    let ordersData = []; // Store all orders for filtering
    let currentFilter = null;

    function confirmDelivery(orderId, button, event) {
        event.stopPropagation();

        if (!orderId) {
            showMessage('Error: Order ID is missing', 'error');
            return;
        }

        if (!confirm('Have you received your order? Click OK to confirm delivery.')) {
            return;
        }

        const originalText = $(button).html();
        $(button).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Confirming...');

        $.ajax({
            url: contextPath + "/customer/orders/" + orderId + "/confirm-delivery",
            type: "POST",
            success: function(response) {
                showMessage('Delivery confirmed successfully!', 'success');
                $('#ordersTable').DataTable().ajax.reload();
            },
            error: function(xhr) {
                showMessage('Failed to confirm delivery. Please try again.', 'error');
                $(button).prop('disabled', false).html(originalText);
                if (xhr.status === 401) {
                    $('#sessionModal').addClass('active');
                } else if (xhr.status === 400) {
                    showMessage('Invalid order ID', 'error');
                }
            }
        });
    }

    function showMessage(message, type) {
        $('.message-area').remove();

        const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
        const messageHtml = '<div class="message-area ' + type + '">' +
            '<i class="fas ' + icon + '"></i>' +
            '<span>' + message + '</span>' +
            '</div>';

        $('.page-header').after(messageHtml);

        setTimeout(function() {
            $('.message-area').fadeOut(300, function() {
                $(this).remove();
            });
        }, 3000);
    }

    function openOrderDetails(orderId) {
        if (!orderId) {
            showMessage('Error: Cannot load order details - Order ID is missing', 'error');
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
                    $('#sessionModal').addClass('active');
                } else if (xhr.status === 404) {
                    $('#orderDetailsContent').html(
                        '<div style="text-align: center; padding: 3rem; color: #991b1b;">' +
                        '<i class="fas fa-exclamation-circle" style="font-size: 4rem; margin-bottom: 1rem;"></i>' +
                        '<p style="font-size: 1.1rem; font-weight: 500;">Order not found. The order may have been deleted.</p>' +
                        '</div>'
                    );
                } else {
                    $('#orderDetailsContent').html(
                        '<div style="text-align: center; padding: 3rem; color: #991b1b;">' +
                        '<i class="fas fa-exclamation-circle" style="font-size: 4rem; margin-bottom: 1rem;"></i>' +
                        '<p style="font-size: 1.1rem; font-weight: 500;">Failed to load order details. Please try again.</p>' +
                        '</div>'
                    );
                }
            }
        });
    }

    function closeOrderDetails() {
        $('#orderDetailsModal').removeClass('active');
        $('#orderDetailsContent').html(
            '<div style="text-align: center; padding: 2rem;">' +
            '<i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #f97316;"></i>' +
            '<p style="margin-top: 1rem; color: #64748b;">Loading order details...</p>' +
            '</div>'
        );
    }

    function renderStatus(status) {
        const statusConfig = {
            'PLACED': { class: 'status-placed', icon: 'fa-clock', text: 'Placed' },
            'ACCEPTED': { class: 'status-accepted', icon: 'fa-check-circle', text: 'Accepted' },
            'PREPARING': { class: 'status-preparing', icon: 'fa-utensils', text: 'Preparing' },
            'READY': { class: 'status-ready', icon: 'fa-check-double', text: 'Ready' },
            'OUT_FOR_DELIVERY': { class: 'status-out_for_delivery', icon: 'fa-truck', text: 'Out for Delivery' },
            'DELIVERED': { class: 'status-delivered', icon: 'fa-check-circle', text: 'Delivered' },
            'REJECTED': { class: 'status-rejected', icon: 'fa-times-circle', text: 'Rejected' }
        };

        const config = statusConfig[status] || { class: 'status-placed', icon: 'fa-question-circle', text: status };

        return '<span class="status-badge ' + config.class + '">' +
               '<i class="fas ' + config.icon + '"></i>' +
               '<span>' + config.text + '</span>' +
               '</span>';
    }

    // Update stats with clickable cards
    function updateStats(orders) {
        if (!orders || !Array.isArray(orders)) {
            orders = [];
        }

        const stats = {
            total: orders.length,
            placed: orders.filter(o => o && o.status === 'PLACED').length,
            outForDelivery: orders.filter(o => o && o.status === 'OUT_FOR_DELIVERY').length,
            delivered: orders.filter(o => o && o.status === 'DELIVERED').length
        };

        $('#totalOrdersCount').text(stats.total);

        const statsHtml =
            '<div class="stat-card" onclick="filterByStatus(null)">' +
            '<div class="stat-icon"><i class="fas fa-shopping-bag"></i></div>' +
            '<div class="stat-info">' +
            '<h3>' + stats.total + '</h3>' +
            '<p>Total Orders</p>' +
            '</div>' +
            (stats.total > 0 ? '<span class="stat-trend">↗️ All</span>' : '') +
            '</div>' +

            '<div class="stat-card" onclick="filterByStatus(\'PLACED\')">' +
            '<div class="stat-icon"><i class="fas fa-clock"></i></div>' +
            '<div class="stat-info">' +
            '<h3>' + stats.placed + '</h3>' +
            '<p>Placed</p>' +
            '</div>' +
            (stats.placed > 0 ? '<span class="stat-trend">↗️ ' + stats.placed + '</span>' : '') +
            '</div>' +

            '<div class="stat-card" onclick="filterByStatus(\'OUT_FOR_DELIVERY\')">' +
            '<div class="stat-icon"><i class="fas fa-truck"></i></div>' +
            '<div class="stat-info">' +
            '<h3>' + stats.outForDelivery + '</h3>' +
            '<p>Out for Delivery</p>' +
            '</div>' +
            (stats.outForDelivery > 0 ? '<span class="stat-trend">↗️ ' + stats.outForDelivery + '</span>' : '') +
            '</div>' +

            '<div class="stat-card" onclick="filterByStatus(\'DELIVERED\')">' +
            '<div class="stat-icon"><i class="fas fa-check-circle"></i></div>' +
            '<div class="stat-info">' +
            '<h3>' + stats.delivered + '</h3>' +
            '<p>Delivered</p>' +
            '</div>' +
            (stats.delivered > 0 ? '<span class="stat-trend">↗️ ' + stats.delivered + '</span>' : '') +
            '</div>';

        $('#statsGrid').html(statsHtml);

        // Highlight active filter
        highlightActiveFilter();
    }

    // Filter by status
    function filterByStatus(status) {
        currentFilter = status;
        const table = $('#ordersTable').DataTable();

        if (status === null) {
            table.column(2).search('').draw();
        } else {
            table.column(2).search('^' + status + '$', true, false).draw();
        }

        highlightActiveFilter();
        showMessage('Filtered: Showing ' + (status || 'all') + ' orders', 'success');
    }

    // Highlight active filter card
    function highlightActiveFilter() {
        $('.stat-card').removeClass('active');

        if (currentFilter === null) {
            $('.stat-card:first').addClass('active');
        } else if (currentFilter === 'PLACED') {
            $('.stat-card:eq(1)').addClass('active');
        } else if (currentFilter === 'OUT_FOR_DELIVERY') {
            $('.stat-card:eq(2)').addClass('active');
        } else if (currentFilter === 'DELIVERED') {
            $('.stat-card:eq(3)').addClass('active');
        }
    }

    // Clear all filters
    function clearAllFilters() {
        currentFilter = null;
        const table = $('#ordersTable').DataTable();
        table.column(2).search('').draw();
        highlightActiveFilter();
        showMessage('All filters cleared', 'success');
    }

    // Refresh table
    function refreshTable() {
        $('#ordersTable').DataTable().ajax.reload();
        showMessage('Orders refreshed', 'success');
    }

    $(document).ready(function () {
        const table = $('#ordersTable').DataTable({
            ajax: {
                url: contextPath + "/customer/orders/get-all-orders",
                dataSrc: function(json) {
                    console.log("API Response:", json);

                    let orders = [];

                    if (json && Array.isArray(json)) {
                        orders = json;
                    } else if (json && json.data && Array.isArray(json.data)) {
                        orders = json.data;
                    } else if (json && json.orders && Array.isArray(json.orders)) {
                        orders = json.orders;
                    } else if (json && json.content && Array.isArray(json.content)) {
                        orders = json.content;
                    }

                    // Store orders data for stats
                    ordersData = orders;

                    orders.forEach(function(order, index) {
                        if (!order.orderId) {
                            if (order.id) {
                                order.orderId = order.id;
                            } else if (order.order_id) {
                                order.orderId = order.order_id;
                            }
                        }
                    });

                    if (orders.length > 0) {
                        updateStats(orders);
                    }

                    return orders;
                },
                error: function(xhr, error, thrown) {
                    console.error("DataTable AJAX error:", error, thrown);
                    if (xhr.status === 401) {
                        $('#sessionModal').addClass('active');
                    } else {
                        showMessage('Failed to load orders. Please refresh the page.', 'error');
                    }
                }
            },
            ordering: false,
            columns: [
                 {
                       data: null,
                       render: function(data, type, row, meta) {

                           return '<span class="order-id">' + (meta.row + 1) + '</span>';
                       },
                       title: "S.No"
                   },
                {
                    data: "totalAmount",
                    render: function(data, type, row) {
                        let amount = data;
                        if (!amount && row) {
                            amount = row.totalAmount || row.total_Amount || row.total || row.amount;
                        }
                        if (!amount && amount !== 0) return '<span style="font-weight: 600; color: #f97316;">₹ 0.00</span>';
                        return '<span style="font-weight: 600; color: #f97316;">₹ ' + parseFloat(amount).toFixed(2) + '</span>';
                    }
                },
                {
                    data: "status",
                    render: function(data, type, row) {
                        let status = data;
                        if (!status && row) {
                            status = row.status || row.orderStatus || row.order_Status;
                        }
                        return renderStatus(status || 'UNKNOWN');
                    }
                },
                {
                                    data: "lastUpdated",
                                    render: function(data, type, row) {
                                        let lastUpdated = data;
                                        if (!lastUpdated && row) {
                                            lastUpdated = row.lastUpdated || row.last_Updated || row.updatedAt || row.updateDate;
                                        }
                                        if (!lastUpdated) return '-';
                                        try {
                                            return new Date(lastUpdated).toLocaleString();
                                        } catch(e) {
                                            return lastUpdated;
                                        }
                                    }
                },
                {
                    data: null,
                    render: function(data, type, row) {
                        const orderId = data?.orderId || data?.id || data?.order_id || data?.orderID;
                        const status = data?.status || data?.orderStatus || data?.order_Status;

                        if (status === 'OUT_FOR_DELIVERY' && orderId) {
                            return '<button class="action-btn confirm" onclick="confirmDelivery(' + orderId + ', this, event)"><i class="fas fa-check-circle"></i> Confirm Delivery</button>';
                        }
                        return '';
                    }
                }
            ],
            language: {
                emptyTable: "No orders found",
                info: "Showing _START_ to _END_ of _TOTAL_ orders",
                infoEmpty: "Showing 0 to 0 of 0 orders",
                infoFiltered: "(filtered from _MAX_ total orders)",
                lengthMenu: "Show _MENU_ orders",
                loadingRecords: '<i class="fas fa-spinner fa-spin"></i> Loading orders...',
                processing: '<i class="fas fa-spinner fa-spin"></i> Processing...',
                search: '<i class="fas fa-search"></i> Search Orders:',
                zeroRecords: "No matching orders found",
                paginate: {
                    first: '<i class="fas fa-angle-double-left"></i>',
                    previous: '<i class="fas fa-angle-left"></i>',
                    next: '<i class="fas fa-angle-right"></i>',
                    last: '<i class="fas fa-angle-double-right"></i>'
                }
            },
            pageLength: 10,
            lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
            initComplete: function() {
                console.log("DataTable initialized");
            }
        });

        // Row click handler
        $('#ordersTable tbody').on('click', 'tr', function() {
            const data = table.row(this).data();

            if (!data) {
                showMessage('Error: No data found for this row', 'error');
                return;
            }

            const orderId = data.orderId;

            if (!orderId) {
                showMessage('Error: Order ID not found', 'error');
                return;
            }

            openOrderDetails(orderId);
        });

        // Modal click outside handler
        $(window).on('click', function(event) {
            if ($(event.target).hasClass('order-details-modal')) {
                closeOrderDetails();
            }
        });

        // ESC key handler
        $(document).on('keydown', function(event) {
            if (event.key === 'Escape' && $('#orderDetailsModal').hasClass('active')) {
                closeOrderDetails();
            }
        });
    });

    // Sidebar toggle functionality
    document.addEventListener("DOMContentLoaded", function() {
        const hamburger = document.getElementById("hamburgerBtn");
        const sidebar = document.getElementById("sidebar");
        const mainContent = document.getElementById("mainContent");

        if (hamburger && sidebar && mainContent) {
            hamburger.addEventListener("click", function (e) {
                e.stopPropagation();
                sidebar.classList.toggle("open");
                mainContent.classList.toggle("shift");
            });

            document.addEventListener('click', function(event) {
                if (!sidebar.contains(event.target) &&
                    !hamburger.contains(event.target) &&
                    sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    mainContent.classList.remove('shift');
                }
            });
        }
    });
</script>

</body>
</html>