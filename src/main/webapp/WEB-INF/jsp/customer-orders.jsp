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
            background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
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
            border-radius: 2.5rem;
            box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15);
        }


        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0e4d5;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-title i {
            font-size: 2.5rem;
            color: #f97316;
            background: #fff6ed;
            padding: 1rem;
            border-radius: 50%;
        }

        .page-title h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }

        .page-title h2::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
            margin-top: 0.5rem;
        }


        .stats-summary {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .stat-badge {
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 40px;
            padding: 0.8rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 5px 15px -8px rgba(0, 0, 0, 0.1);
        }

        .stat-badge i {
            color: #f97316;
            font-size: 1.2rem;
        }

        .stat-badge span {
            font-weight: 600;
            color: #1e1e1e;
        }

        .stat-badge .count {
            background: #f97316;
            color: white;
            padding: 0.2rem 0.8rem;
            border-radius: 40px;
            font-size: 0.9rem;
            margin-left: 0.5rem;
        }


        .table-container {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.1);
            border: 2px solid #eaeef2;
            margin-top: 2rem;
        }


        .dataTables_wrapper {
            font-family: 'Inter', sans-serif;
        }

        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter {
            margin-bottom: 1.5rem;
        }

        .dataTables_wrapper .dataTables_length label,
        .dataTables_wrapper .dataTables_filter label {
            color: #1e1e1e;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .dataTables_wrapper .dataTables_length select,
        .dataTables_wrapper .dataTables_filter input {
            border: 2px solid #eaeef2;
            border-radius: 40px;
            padding: 0.5rem 1rem;
            font-family: 'Inter', sans-serif;
            outline: none;
            transition: all 0.2s;
        }

        .dataTables_wrapper .dataTables_length select:focus,
        .dataTables_wrapper .dataTables_filter input:focus {
            border-color: #f97316;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .dataTables_filter input {
            min-width: 250px;
        }


        #ordersTable {
            border-collapse: separate;
            border-spacing: 0 0.8rem;
            margin-top: 0.5rem;
        }

        #ordersTable thead th {
            background: #f9f9fb;
            color: #1e1e1e;
            font-weight: 700;
            font-size: 0.9rem;
            padding: 1rem;
            border: none;
            border-bottom: 2px solid #f97316;
        }

        #ordersTable thead th:first-child {
            border-radius: 40px 0 0 40px;
        }

        #ordersTable thead th:last-child {
            border-radius: 0 40px 40px 0;
        }

        #ordersTable tbody tr {
            background: white;
            border-radius: 40px;
            transition: all 0.2s;
            box-shadow: 0 5px 15px -8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }

        #ordersTable tbody tr:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -10px rgba(249, 115, 22, 0.3);
        }

        #ordersTable tbody td {
            padding: 1.2rem 1rem;
            border: 2px solid transparent;
            border-bottom: 2px solid #eaeef2;
            color: #2e2e2e;
        }

        #ordersTable tbody td:first-child {
            border-radius: 40px 0 0 40px;
            border-left: 2px solid transparent;
        }

        #ordersTable tbody td:last-child {
            border-radius: 0 40px 40px 0;
            border-right: 2px solid transparent;
        }


        .order-id {
            font-weight: 700;
            color: #f97316;
            background: #fff6ed;
            padding: 0.3rem 0.8rem;
            border-radius: 40px;
            display: inline-block;
            font-size: 0.9rem;
        }


        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-badge i {
            font-size: 0.5rem;
        }

        .status-placed {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-accepted {
            background: #cce5ff;
            color: #004085;
            border: 1px solid #b8daff;
        }

        .status-preparing {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-ready {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .status-out_for_delivery {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-delivered {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
        }

        .status-rejected {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
        }


        .action-btn {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            z-index: 10;
        }

        .action-btn:hover {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px -8px #f97316;
        }

        .action-btn i {
            font-size: 0.9rem;
        }

        .action-btn:disabled {
            background: #b7ebc3;
            color: #2e7d32;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .action-btn.confirm {
            background: #2e7d32;
        }

        .action-btn.confirm:hover {
            background: #1e5f22;
        }


        .message-area {
            margin: 1rem 0;
            padding: 1rem;
            border-radius: 40px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease;
        }

        .message-area.success {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
        }

        .message-area.error {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
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


        .order-details-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 10000;
            align-items: center;
            justify-content: center;
        }

        .order-details-modal.active {
            display: flex;
        }

        .modal-window {
            background: white;
            border-radius: 24px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow: hidden;
            box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease;
        }

        .modal-header {
            background: #f97316;
            color: white;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-header h3 {
            font-size: 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .close-btn {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 1.2rem;
        }

        .close-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 1.5rem;
            max-height: calc(90vh - 80px);
            overflow-y: auto;
        }


        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10001;
        }

        .loading-overlay.active {
            display: flex;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 3px solid #f0e4d5;
            border-top-color: #f97316;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }


        .session-modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 10002;
        }

        .session-modal-overlay.active {
            display: flex;
        }

        .session-modal-content {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease;
            text-align: center;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .session-modal-content i {
            font-size: 4rem;
            color: #f97316;
            margin-bottom: 1rem;
        }

        .session-modal-content h3 {
            color: #1e1e1e;
            margin-bottom: 1rem;
        }

        .session-modal-content p {
            color: #6b6b6b;
            margin-bottom: 2rem;
        }

        .modal-btn {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.8rem 2rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }


        .dataTables_info {
            color: #6b6b6b;
            font-size: 0.9rem;
            padding-top: 1rem;
        }

        .dataTables_paginate {
            padding-top: 1rem;
        }

        .dataTables_paginate .paginate_button {
            border-radius: 40px !important;
            margin: 0 0.2rem;
            border: 1px solid #eaeef2 !important;
            background: white !important;
            color: #2e2e2e !important;
        }

        .dataTables_paginate .paginate_button.current {
            background: #f97316 !important;
            border-color: #f97316 !important;
            color: white !important;
        }

        .dataTables_paginate .paginate_button:hover {
            background: #fff6ed !important;
            border-color: #f97316 !important;
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

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title h2 {
                font-size: 1.8rem;
            }

            .dataTables_filter input {
                min-width: 150px;
            }
        }

        .order-details-container {
            padding: 1rem;
        }

        .detail-row {
            display: flex;
            align-items: center;
            margin-bottom: 1.2rem;
            padding: 0.5rem 0;
            border-bottom: 1px solid #f0e4d5;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #6b6b6b;
            width: 120px;
            font-size: 0.95rem;
        }

        .detail-value {
            color: #1e1e1e;
            font-weight: 500;
            flex: 1;
        }

        .order-id-value {
            color: #f97316;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .amount-value {
            color: #2e7d32;
            font-weight: 700;
            font-size: 1.1rem;
        }


        .items-table-container {
            margin-top: 1.5rem;
            overflow-x: auto;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
        }

        .items-table thead {
            background: #f97316;
            color: white;
        }

        .items-table thead th {
            padding: 1rem;
            font-weight: 600;
            font-size: 0.95rem;
            text-align: left;
        }

        .items-table thead th:first-child {
            border-radius: 12px 0 0 0;
        }

        .items-table thead th:last-child {
            border-radius: 0 12px 0 0;
        }

        .items-table tbody tr {
            background: #f9f9fb;
            transition: all 0.2s;
        }

        .items-table tbody tr:hover {
            background: #fff6ed;
        }

        .items-table tbody td {
            padding: 1rem;
            border-bottom: 1px solid #eaeef2;
            color: #1e1e1e;
        }

        .items-table tbody tr:last-child td {
            border-bottom: none;
        }

        .items-table tbody tr:last-child td:first-child {
            border-radius: 0 0 0 12px;
        }

        .items-table tbody tr:last-child td:last-child {
            border-radius: 0 0 12px 0;
        }


        .detail-text {
            color: #1e1e1e;
            line-height: 1.6;
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #f9f9fb;
            border-radius: 8px;
        }


        @media (max-width: 600px) {
            .detail-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .detail-label {
                width: 100%;
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
                <h2>My Orders</h2>
            </div>
            <div class="stats-summary" id="statsSummary">
                <!-- Stats will be populated by JavaScript -->
            </div>
        </div>

        <!-- Orders Table -->
        <div class="table-container">
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
            <!-- Order details will be loaded here -->
            <div style="text-align: center; padding: 2rem;">
                <i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #f97316;"></i>
                <p style="margin-top: 1rem; color: #6b6b6b;">Loading order details...</p>
            </div>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner"></div>
</div>

<!-- Session Expired Modal -->
<div class="session-modal-overlay" id="sessionModal">
    <div class="session-modal-content">
        <i class="fas fa-clock"></i>
        <h3>Session Expired</h3>
        <p>Your session has expired. Please login again to continue.</p>
        <a href="${pageContext.request.contextPath}/login" class="modal-btn">Go to Login</a>
    </div>
</div>

<script>
    const contextPath = "${pageContext.request.contextPath}";

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
        $(button).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i>');

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
                        '<div style="text-align: center; padding: 2rem; color: #b34033;">' +
                        '<i class="fas fa-exclamation-circle" style="font-size: 3rem; margin-bottom: 1rem;"></i>' +
                        '<p>Order not found. The order may have been deleted.</p>' +
                        '</div>'
                    );
                } else {
                    $('#orderDetailsContent').html(
                        '<div style="text-align: center; padding: 2rem; color: #b34033;">' +
                        '<i class="fas fa-exclamation-circle" style="font-size: 3rem; margin-bottom: 1rem;"></i>' +
                        '<p>Failed to load order details. Please try again.</p>' +
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
            '<p style="margin-top: 1rem; color: #6b6b6b;">Loading order details...</p>' +
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

        const config = statusConfig[status] || { class: '', icon: 'fa-question-circle', text: status };

        return '<span class="status-badge ' + config.class + '">' +
               '<i class="fas ' + config.icon + '"></i>' +
               '<span>' + config.text + '</span>' +
               '</span>';
    }


    function updateStats(orders) {
        if (!orders || !Array.isArray(orders)) {
            return;
        }

        const stats = {
            total: orders.length,
            placed: orders.filter(o => o && o.status === 'PLACED').length,
            outForDelivery: orders.filter(o => o && o.status === 'OUT_FOR_DELIVERY').length,
            delivered: orders.filter(o => o && o.status === 'DELIVERED').length
        };

        const statsHtml =
            '<div class="stat-badge">' +
            '<i class="fas fa-shopping-bag"></i>' +
            '<span>Total Orders <span class="count">' + stats.total + '</span></span>' +
            '</div>' +
            '<div class="stat-badge">' +
            '<i class="fas fa-clock"></i>' +
            '<span>Placed <span class="count">' + stats.placed + '</span></span>' +
            '</div>' +
            '<div class="stat-badge">' +
            '<i class="fas fa-truck"></i>' +
            '<span>Out for Delivery <span class="count">' + stats.outForDelivery + '</span></span>' +
            '</div>' +
            '<div class="stat-badge">' +
            '<i class="fas fa-check-circle"></i>' +
            '<span>Delivered <span class="count">' + stats.delivered + '</span></span>' +
            '</div>';

        $('#statsSummary').html(statsHtml);
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
                        orders = json.content; // For paginated responses
                    }


                    orders.forEach(function(order, index) {
                        if (!order.orderId) {
                            console.warn("Order at index " + index + " is missing orderId:", order);

                            if (order.id) {
                                console.log("Found 'id' field instead of 'orderId':", order.id);

                                order.orderId = order.id;
                            } else if (order.order_id) {
                                console.log("Found 'order_id' field instead of 'orderId':", order.order_id);
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
                    data: "orderId",
                    render: function(data, type, row) {

                        let orderId = data;
                        if (!orderId && row) {
                            orderId = row.orderId || row.id || row.order_id || row.orderID;
                        }

                        if (!orderId) {
                            console.warn("Missing orderId in row:", row);
                            return '<span class="order-id">#N/A</span>';
                        }
                        return '<span class="order-id">#' + orderId + '</span>';
                    }
                },
                {
                    data: "totalAmount",
                    render: function(data, type, row) {
                        let amount = data;
                        if (!amount && row) {
                            amount = row.totalAmount || row.total_Amount || row.total || row.amount;
                        }
                        if (!amount && amount !== 0) return '₹ 0.00';
                        return '₹ ' + parseFloat(amount).toFixed(2);
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


       $('#ordersTable tbody').on('click', 'tr', function() {

           const data = table.row(this).data();

           console.log("Row clicked data:", data);

           if (!data) {
               showMessage('Error: No data found for this row', 'error');
               return;
           }

           const orderId = data.orderId;

           console.log("Extracted Order ID:", orderId);

           if (!orderId) {
               showMessage('Error: Order ID not found', 'error');
               return;
           }

           openOrderDetails(orderId);
       });


        $(window).on('click', function(event) {
            if ($(event.target).hasClass('order-details-modal')) {
                closeOrderDetails();
            }
        });


        $(document).on('keydown', function(event) {
            if (event.key === 'Escape' && $('#orderDetailsModal').hasClass('active')) {
                closeOrderDetails();
            }
        });


        $('.page-header').append(
            '<button class="action-btn" onclick="$(\'#ordersTable\').DataTable().ajax.reload()" style="margin-left: auto;">' +
            '<i class="fas fa-sync-alt"></i> Refresh' +
            '</button>'
        );
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