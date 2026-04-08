<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Dashboard | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Eatzy Theme Restaurant Dashboard CSS */
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

        /* Dashboard Layout */
        #dashboard-layout {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        #dashboard-layout.shift {
            margin-left: 280px;
        }

        /* Main Content */
        #main-content {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 2.5rem;
            padding: 2rem;
            box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15);
        }

        /* Welcome Header */
        .welcome-header {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0e4d5;
        }

        .welcome-header i {
            font-size: 2.5rem;
            color: #f97316;
            background: #fff6ed;
            padding: 1rem;
            border-radius: 50%;
        }

        .welcome-header h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }

        .welcome-header h2::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
            margin-top: 0.5rem;
        }

        /* Restaurant Selector */
        .restaurant-selector {
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 40px;
            padding: 0.5rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .restaurant-selector select {
            flex: 1;
            padding: 0.8rem 1rem;
            border: none;
            background: transparent;
            font-size: 1rem;
            font-weight: 500;
            color: #1e1e1e;
            outline: none;
            cursor: pointer;
        }

        .restaurant-selector button {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.8rem 1.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .restaurant-selector button:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .stat-card {
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 24px;
            padding: 1.5rem;
            transition: all 0.2s;
        }

        .stat-card:hover {
            border-color: #f97316;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px -10px rgba(249, 115, 22, 0.3);
        }

        .stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .stat-header i {
            font-size: 2rem;
            color: #f97316;
            background: white;
            padding: 0.8rem;
            border-radius: 18px;
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
        }

        .stat-label {
            color: #6b6b6b;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Quick Actions */
        .quick-actions {
            background: #f9f9fb;
            border-radius: 24px;
            padding: 1.5rem;
            margin-bottom: 2.5rem;
            border: 2px solid #eaeef2;
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: #f97316;
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .action-card {
            background: white;
            border: 2px solid #eaeef2;
            border-radius: 20px;
            padding: 1.5rem;
            text-decoration: none;
            color: inherit;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .action-card:hover {
            border-color: #f97316;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px -10px rgba(249, 115, 22, 0.4);
        }

        .action-icon {
            width: 50px;
            height: 50px;
            background: #fff6ed;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: #f97316;
        }

        .action-info h4 {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 0.2rem;
        }

        .action-info p {
            color: #6b6b6b;
            font-size: 0.85rem;
        }

        /* Orders Section */
        .orders-section {
            background: #f9f9fb;
            border-radius: 24px;
            padding: 1.5rem;
            border: 2px solid #eaeef2;
            margin-bottom: 2rem;
        }

        .orders-tabs {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #eaeef2;
            padding-bottom: 1rem;
        }

        .tab-btn {
            background: none;
            border: none;
            padding: 0.5rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            color: #6b6b6b;
            cursor: pointer;
            border-radius: 40px;
            transition: all 0.2s;
        }

        .tab-btn.active {
            background: #f97316;
            color: white;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-table th {
            text-align: left;
            padding: 1rem;
            background: white;
            color: #1e1e1e;
            font-weight: 600;
            border-bottom: 2px solid #f97316;
        }

        .orders-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0e4d5;
            color: #2e2e2e;
        }

        .status-badge {
            display: inline-block;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-PLACED { background: #cce5ff; color: #004085; }
        .status-ACCEPTED { background: #d4edda; color: #155724; }
        .status-PREPARING { background: #fff3cd; color: #856404; }
        .status-READY { background: #d1ecf1; color: #0c5460; }
        .status-OUT_FOR_DELIVERY { background: #fff3cd; color: #856404; }
        .status-DELIVERED { background: #e6f7e6; color: #2e7d32; }
        .status-REJECTED { background: #fff1f0; color: #b34033; }

        .action-btn {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.4rem 1rem;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            margin: 0 0.2rem;
        }

        .action-btn:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .action-btn.secondary {
            background: #6c757d;
        }

        .action-btn.secondary:hover {
            background: #5a6268;
        }

        /* Message Area */
        .message-area {
            margin: 1rem 0;
            padding: 1rem;
            border-radius: 40px;
            display: none;
            align-items: center;
            gap: 0.8rem;
        }

        .message-area.success {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
            display: flex;
        }

        .message-area.error {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
            display: flex;
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

        /* Responsive */
        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            #dashboard-layout {
                padding: 1rem;
            }

            #dashboard-layout.shift {
                margin-left: 0;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .action-grid {
                grid-template-columns: 1fr;
            }

            .orders-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner"></div>
</div>

<div id="dashboard-layout">
    <!-- Main Content -->
    <div id="main-content">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <i class="fas fa-store"></i>
            <h2>Restaurant Dashboard</h2>
        </div>

        <!-- Restaurant Selector (Loads your restaurants from /restaurant/get/all/restaurants) -->
        <div class="restaurant-selector" id="restaurantSelector" style="display: none;">
            <select id="restaurantSelect">
                <option value="">Select a restaurant</option>
            </select>
            <button onclick="loadRestaurantData()">Load Dashboard</button>
        </div>

        <!-- Stats Grid (Dynamic) -->
        <div class="stats-grid" id="statsGrid">
            <div class="stat-card">
                <div class="stat-header">
                    <i class="fas fa-utensils"></i>
                    <span class="stat-value" id="menuCount">0</span>
                </div>
                <div class="stat-label">Menu Items</div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <i class="fas fa-clock"></i>
                    <span class="stat-value" id="incomingOrders">0</span>
                </div>
                <div class="stat-label">Incoming Orders</div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <i class="fas fa-fire"></i>
                    <span class="stat-value" id="activeOrders">0</span>
                </div>
                <div class="stat-label">Active Orders</div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <i class="fas fa-check-circle"></i>
                    <span class="stat-value" id="completedToday">0</span>
                </div>
                <div class="stat-label">Completed Today</div>
            </div>
        </div>

        <!-- Quick Actions - Your Two Sidebar APIs -->
        <div class="quick-actions">
            <div class="section-title">
                <i class="fas fa-bolt"></i>
                Quick Actions
            </div>
            <div class="action-grid">
                <!-- Menu Management -->
                <a href="/restaurant/menuManagement" class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <div class="action-info">
                        <h4>Menu Management</h4>
                        <p>Add, edit or remove menu items</p>
                    </div>
                </a>

                <!-- Manage Restaurants -->
                <a href="/restaurant/get/all/restaurants" class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-store-alt"></i>
                    </div>
                    <div class="action-info">
                        <h4>Manage Restaurants</h4>
                        <p>View and edit restaurant details</p>
                    </div>
                </a>
            </div>
        </div>

        <!-- Message Area -->
        <div id="message" class="message-area"></div>

        <!-- Incoming Orders Section -->
        <div class="orders-section" id="incomingSection">
            <div class="section-title">
                <i class="fas fa-bell"></i>
                Incoming Orders
            </div>
            <table class="orders-table" id="incomingTable">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Items</th>
                        <th>Total</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="incomingBody">
                    <tr><td colspan="5" style="text-align: center;">Select a restaurant to view orders</td></tr>
                </tbody>
            </table>
        </div>

        <!-- Active Orders Section -->
        <div class="orders-section" id="activeSection">
            <div class="section-title">
                <i class="fas fa-fire"></i>
                Active Orders
            </div>
            <div class="orders-tabs">
                <button class="tab-btn active" onclick="filterActiveOrders('all')">All</button>
                <button class="tab-btn" onclick="filterActiveOrders('ACCEPTED')">Accepted</button>
                <button class="tab-btn" onclick="filterActiveOrders('PREPARING')">Preparing</button>
                <button class="tab-btn" onclick="filterActiveOrders('READY')">Ready</button>
                <button class="tab-btn" onclick="filterActiveOrders('OUT_FOR_DELIVERY')">Out for Delivery</button>
            </div>
            <table class="orders-table" id="activeTable">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Items</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="activeBody">
                    <tr><td colspan="6" style="text-align: center;">Select a restaurant to view orders</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    const contextPath = "${pageContext.request.contextPath}";
    let currentRestaurantId = null;
    let activeOrdersData = [];


    $(document).ready(function() {
        loadRestaurants();
    });

    function loadRestaurants() {
        $.ajax({
            url: "/restaurant/get/all/restaurants",
            method: "GET",
            success: function(response) {
                const restaurants = response.data || response;
                if (restaurants && restaurants.length > 0) {
                    const select = $('#restaurantSelect');
                    select.empty().append('<option value="">Select a restaurant</option>');
                    restaurants.forEach(r => {
                        select.append(`<option value="${r.id}">${r.name}</option>`);
                    });
                    $('#restaurantSelector').show();
                }
            },
            error: function(xhr) {
                if (xhr.status === 401) window.location.href = "/login";
            }
        });
    }

    function loadRestaurantData() {
        const restaurantId = $('#restaurantSelect').val();
        if (!restaurantId) {
            showMessage('Please select a restaurant', 'error');
            return;
        }
        currentRestaurantId = restaurantId;

        $('#loadingOverlay').addClass('active');


        $.ajax({
            url: "/restaurant/" + restaurantId + "/categories",
            method: "GET",
            success: function(response) {
                $('#menuCount').text(response.data?.length || 0);
            }
        });


        $.ajax({
            url: "/restaurant/" + restaurantId + "/incoming/orders",
            method: "GET",
            success: function(response) {
                const orders = response.data || [];
                $('#incomingOrders').text(orders.length);

                let html = '';
                if (orders.length === 0) {
                    html = '<tr><td colspan="5" style="text-align: center;">No incoming orders</td></tr>';
                } else {
                    orders.forEach(order => {
                        html += '<tr>' +
                            '<td>#' + order.orderId + '</td>' +
                            '<td>' + (order.customerName || 'Customer') + '</td>' +
                            '<td>' + (order.itemCount || '1 items') + '</td>' +
                            '<td>₹' + order.totalAmount + '</td>' +
                            '<td>' +
                                '<button class="action-btn" onclick="acceptOrder(' + order.orderId + ')">Accept</button>' +
                                '<button class="action-btn secondary" onclick="rejectOrder(' + order.orderId + ')">Reject</button>' +
                            '</td>' +
                        '</tr>';
                    });
                }
                $('#incomingBody').html(html);
            }
        });


        $.ajax({
            url: "/restaurant/" + restaurantId + "/orders/active",
            method: "GET",
            success: function(orders) {
                activeOrdersData = orders || [];
                $('#activeOrders').text(activeOrdersData.length);
                renderActiveOrders(activeOrdersData);
                $('#loadingOverlay').removeClass('active');
            },
            error: function() {
                $('#loadingOverlay').removeClass('active');
            }
        });
    }

    function renderActiveOrders(orders) {
        if (orders.length === 0) {
            $('#activeBody').html('<tr><td colspan="6" style="text-align: center;">No active orders</td></tr>');
            return;
        }

        let html = '';
        orders.forEach(order => {
            let actionButtons = '';

            switch(order.status) {
                case 'ACCEPTED':
                    actionButtons = '<button class="action-btn" onclick="updateOrderStatus(' + order.orderId + ', \'prepare\')">Start Preparing</button>';
                    break;
                case 'PREPARING':
                    actionButtons = '<button class="action-btn" onclick="updateOrderStatus(' + order.orderId + ', \'ready\')">Mark Ready</button>';
                    break;
                case 'READY':
                    actionButtons = '<button class="action-btn" onclick="updateOrderStatus(' + order.orderId + ', \'out-for-delivery\')">Out for Delivery</button>';
                    break;
                default:
                    actionButtons = '-';
            }

            html += '<tr>' +
                '<td>#' + order.orderId + '</td>' +
                '<td>' + (order.customerName || 'Customer') + '</td>' +
                '<td>' + (order.itemCount || '1 items') + '</td>' +
                '<td>₹' + order.totalAmount + '</td>' +
                '<td><span class="status-badge status-' + order.status + '">' + order.status.replace(/_/g, ' ') + '</span></td>' +
                '<td>' + actionButtons + '</td>' +
            '</tr>';
        });
        $('#activeBody').html(html);
    }

    function filterActiveOrders(status) {
        $('.tab-btn').removeClass('active');
        $(event.target).addClass('active');

        if (status === 'all') {
            renderActiveOrders(activeOrdersData);
        } else {
            const filtered = activeOrdersData.filter(o => o.status === status);
            renderActiveOrders(filtered);
        }
    }

    function acceptOrder(orderId) {
        if (!currentRestaurantId) return;

        $.ajax({
            url: "/restaurant/" + currentRestaurantId + "/orders/" + orderId + "/accept",
            method: "POST",
            success: function() {
                showMessage('Order accepted successfully', 'success');
                loadRestaurantData(); // Reload data
            },
            error: function() {
                showMessage('Failed to accept order', 'error');
            }
        });
    }

    function rejectOrder(orderId) {
        if (!currentRestaurantId) return;

        $.ajax({
            url: "/restaurant/" + currentRestaurantId + "/orders/" + orderId + "/reject",
            method: "POST",
            success: function() {
                showMessage('Order rejected', 'success');
                loadRestaurantData(); // Reload data
            },
            error: function() {
                showMessage('Failed to reject order', 'error');
            }
        });
    }

    function updateOrderStatus(orderId, action) {
        if (!currentRestaurantId) return;

        let url = '';
        switch(action) {
            case 'prepare':
                url = "/restaurant/" + currentRestaurantId + "/orders/" + orderId + "/prepare";
                break;
            case 'ready':
                url = "/restaurant/" + currentRestaurantId + "/orders/" + orderId + "/ready";
                break;
            case 'out-for-delivery':
                url = "/restaurant/" + currentRestaurantId + "/orders/" + orderId + "/out-for-delivery";
                break;
        }

        $.ajax({
            url: url,
            method: "POST",
            success: function() {
                showMessage('Order status updated', 'success');
                loadRestaurantData(); // Reload data
            },
            error: function() {
                showMessage('Failed to update status', 'error');
            }
        });
    }

    function showMessage(text, type) {
        $('#message').removeClass('success error').addClass(type).html('<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + text).show();
        setTimeout(() => $('#message').fadeOut(), 3000);
    }


    document.addEventListener("DOMContentLoaded", function() {
        const hamburger = document.getElementById("hamburgerBtn");
        const sidebar = document.getElementById("sidebar");
        const dashboard = document.getElementById("dashboard-layout");

        if (hamburger && sidebar && dashboard) {
            hamburger.addEventListener("click", function (e) {
                e.stopPropagation();
                sidebar.classList.toggle("open");
                dashboard.classList.toggle("shift");
            });

            document.addEventListener('click', function(event) {
                if (!sidebar.contains(event.target) &&
                    !hamburger.contains(event.target) &&
                    sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    dashboard.classList.remove('shift');
                }
            });
        }
    });
</script>

</body>
</html>