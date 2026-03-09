<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link rel="icon" href="data:,">

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
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

            /* Main Content with Sidebar Shift */
            .content {
                margin-left: 0;
                padding: 2rem 2rem 2rem 5rem;
                transition: margin-left 0.3s ease;
                min-height: 100vh;
            }

            .content.shift {
                margin-left: 280px;
            }

            /* Dashboard Container */
            .dashboard-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 2rem;
                background: white;
                border-radius: 2.5rem;
                box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15);
            }

            /* Page Header */
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

            /* Stats Summary */
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

            /* Table Container */
            .table-container {
                background: white;
                border-radius: 24px;
                padding: 1.5rem;
                box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.1);
                border: 2px solid #eaeef2;
                margin-top: 2rem;
            }

            /* DataTable Customization */
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

            /* Table Styling */
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

            /* Order ID styling */
            .order-id {
                font-weight: 700;
                color: #f97316;
                background: #fff6ed;
                padding: 0.3rem 0.8rem;
                border-radius: 40px;
                display: inline-block;
                font-size: 0.9rem;
            }

            /* Status Badges */
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

            /* Action Buttons */
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

            /* Message Area */
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

            /* Session Expired Modal */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: none;
                align-items: center;
                justify-content: center;
                z-index: 10000;
            }

            .modal-overlay.active {
                display: flex;
            }

            .modal-content {
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

            .modal-content i {
                font-size: 4rem;
                color: #f97316;
                margin-bottom: 1rem;
            }

            .modal-content h3 {
                color: #1e1e1e;
                margin-bottom: 1rem;
            }

            .modal-content p {
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

            /* Loading Overlay */
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
                z-index: 9999;
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

            /* DataTable Pagination */
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

            /* Responsive Design */
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

    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
<div class="content" id="mainContent">
<div class="dashboard">
    <h2>My Orders</h2>

    <table id="ordersTable" class="display" style="width:100%">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>LastUpdated</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>
</div>

<script>

    const contextPath = "${pageContext.request.contextPath}";

    function confirmDelivery(orderId, button) {
        if (!confirm('Have you received your order? Click OK to confirm delivery.')) {
            return;
        }

        const originalText = $(button).html();
        $(button).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i>');

        $.ajax({
            url: contextPath + "/customer/orders/" + orderId + "/confirm-delivery",
            type: "POST",
            success: function(response) {
                alert('Delivery confirmed successfully!');
                $('#ordersTable').DataTable().ajax.reload();
            },
            error: function(xhr) {
                alert('Failed to confirm delivery. Please try again.');
                $(button).prop('disabled', false).html(originalText);
                if (xhr.status === 401) {
                    window.location.href = contextPath + "/login";
                }
            }
        });
    }

    $(document).ready(function () {

        const table = $('#ordersTable').DataTable({
            ajax: {
                url: contextPath + "/customer/orders/get-all-orders",
                dataSrc: "data"
            },
            columns: [
                { data: "orderId" },
                {
                    data: "totalAmount",
                    render: function(data){
                        return "₹ " + data;
                    }
                },
                {
                    data: "status",
                    render: function(status){
                        return renderStatus(status);
                    }
                },
                { data: "lastUpdated" },
                {
                    data: null,
                    render: function(data) {
                        if (data.status === 'OUT_FOR_DELIVERY') {
                            return '<button class="action-btn confirm" onclick="confirmDelivery(' + data.orderId + ', this)"><i class="fas fa-check-circle"></i> Confirm Delivery</button>';
                        }
                        return '';
                    }
                }
            ]
        });


        function renderStatus(status) {

            if (status === "PLACED") {
                return `<span style="color:orange; font-weight:bold;">Placed</span>`;
            }

            if (status === "ACCEPTED") {
                return `<span style="color:blue;">Accepted</span>`;
            }

            if (status === "PREPARING") {
                return `<span style="color:purple;">Preparing</span>`;
            }

            if (status === "READY") {
                return `<span style="color:teal;">Ready</span>`;
            }

            if (status === "OUT_FOR_DELIVERY") {
                return `<span style="color:green;">Out for Delivery</span>`;
            }

            if (status === "DELIVERED") {
                return `<span style="color:gray;">Delivered</span>`;
            }

            if (status === "REJECTED") {
                return `<span style="color:red;">Rejected</span>`;
            }

            return status;
        }

    });
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