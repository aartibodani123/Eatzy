<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurant Management Portal</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .portal-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .portal-header {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .portal-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .portal-header p {
            color: #666;
            font-size: 16px;
        }

        .restaurant-info {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
            color: #555;
            font-size: 14px;
        }

        .restaurant-info strong {
            color: #667eea;
        }

        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }

        .management-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .management-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .card-header {
            padding: 30px;
            text-align: center;
            position: relative;
        }

        .orders-card .card-header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
        }

        .coupons-card .card-header {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
        }

        .card-icon {
            font-size: 64px;
            margin-bottom: 15px;
        }

        .card-header h2 {
            color: white;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .card-header p {
            color: rgba(255,255,255,0.9);
            font-size: 14px;
        }

        .card-body {
            padding: 25px;
            background: white;
        }

        .stats-preview {
            margin-bottom: 20px;
        }

        .stat-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
        }

        .stat-value {
            color: #333;
            font-weight: bold;
            font-size: 16px;
        }

        .card-button {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }

        .card-button:hover {
            background: #5a67d8;
        }

        .orders-card .card-button {
            background: #4CAF50;
        }

        .orders-card .card-button:hover {
            background: #45a049;
        }

        .coupons-card .card-button {
            background: #2196F3;
        }

        .coupons-card .card-button:hover {
            background: #1976D2;
        }

        .quick-actions {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .quick-actions h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 10px 20px;
            background: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .action-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .loading {
            text-align: center;
            padding: 20px;
            color: #666;
        }

        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 8px;
            margin-top: 10px;
            display: none;
            text-align: center;
        }

        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 8px;
            margin-top: 10px;
            display: none;
            text-align: center;
        }

        @media (max-width: 768px) {
            .management-grid {
                grid-template-columns: 1fr;
            }

            body {
                padding: 10px;
            }

            .portal-header h1 {
                font-size: 24px;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .management-card {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>
    <div class="portal-container">
        <input type="hidden" id="restaurantId" value="${restaurantId}">

        <div class="portal-header">
            <h1>🏪 Restaurant Management Portal</h1>
            <p>Manage your restaurant operations efficiently from one place</p>
            <div id="restaurantInfo" class="restaurant-info"></div>
        </div>

        <div class="management-grid">
            <!-- Orders Management Card -->
            <div class="management-card orders-card" onclick="navigateToOrders()">
                <div class="card-header">
                    <div class="card-icon">📦</div>
                    <h2>Order Management</h2>
                    <p>Track, process and manage all orders</p>
                </div>
                <div class="card-body">
                    <div class="stats-preview" id="orderStats">
                        <div class="loading">Loading order stats...</div>
                    </div>
                    <button class="card-button" onclick="event.stopPropagation(); navigateToOrders()">
                        Manage Orders →
                    </button>
                </div>
            </div>

            <!-- Coupons Management Card -->
            <div class="management-card coupons-card" onclick="navigateToCoupons()">
                <div class="card-header">
                    <div class="card-icon">🎫</div>
                    <h2>Coupon Management</h2>
                    <p>Create and manage discount coupons</p>
                </div>
                <div class="card-body">
                    <div class="stats-preview" id="couponStats">
                        <div class="loading">Loading coupon stats...</div>
                    </div>
                    <button class="card-button" onclick="event.stopPropagation(); navigateToCoupons()">
                        Manage Coupons →
                    </button>
                </div>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="quick-actions">
            <h3>⚡ Quick Actions</h3>
            <div class="action-buttons">
                <button class="action-btn" onclick="quickAction('orders')">View Pending Orders</button>
                <button class="action-btn" onclick="quickAction('create-coupon')">Create New Coupon</button>
                <button class="action-btn" onclick="quickAction('active-coupons')">View Active Coupons</button>
                <button class="action-btn" onclick="refreshData()">Refresh Statistics</button>
            </div>
        </div>

        <div id="errorMessage" class="error-message"></div>
        <div id="successMessage" class="success-message"></div>
    </div>

    <script>
        var restaurantId = $("#restaurantId").val();

        $(document).ready(function() {
            console.log("Restaurant ID:", restaurantId);

            if(!restaurantId || restaurantId === "") {
                showError("Restaurant ID is missing. Please check your session.");
                return;
            }

            // Load restaurant info and stats
            loadRestaurantInfo();
            loadOrderStats();
            loadCouponStats();
        });

        function navigateToOrders() {
            if(!restaurantId) {
                showError("Cannot navigate: Restaurant ID is missing");
                return;
            }

            console.log("Navigating to orders management for restaurant:", restaurantId);
            window.location.href = '/restaurant/' + restaurantId + '/orders';
        }

        function navigateToCoupons() {
            if(!restaurantId) {
                showError("Cannot navigate: Restaurant ID is missing");
                return;
            }

            console.log("Navigating to coupons management for restaurant:", restaurantId);
            window.location.href = '/restaurant/' + restaurantId + '/coupons';
        }

        function quickAction(action) {
            switch(action) {
                case 'orders':
                    navigateToOrders();
                    break;
                case 'create-coupon':
                    navigateToCoupons();
                    break;
                case 'active-coupons':
                    navigateToCoupons();
                    break;
                default:
                    console.log("Unknown action:", action);
            }
        }

        function loadRestaurantInfo() {
            $.ajax({
                url: '/api/restaurants/' + restaurantId,
                type: 'GET',
                success: function(response) {
                    console.log("Restaurant info:", response);
                    if(response.status === 200 && response.data) {
                        var restaurant = response.data;
                        var infoHtml = '<strong>' + escapeHtml(restaurant.name) + '</strong> | ' +
                            (restaurant.address ? escapeHtml(restaurant.address) : 'Address not set') + ' | ' +
                            (restaurant.phone ? escapeHtml(restaurant.phone) : 'Phone not set');
                        $("#restaurantInfo").html(infoHtml);
                    } else {
                        $("#restaurantInfo").html('Restaurant ID: <strong>' + restaurantId + '</strong>');
                    }
                },
                error: function(xhr) {
                    console.error("Failed to load restaurant info:", xhr);
                    $("#restaurantInfo").html('Restaurant ID: <strong>' + restaurantId + '</strong>');
                }
            });
        }

        function loadOrderStats() {
            $.ajax({
                url: '/api/restaurants/' + restaurantId + '/orders/stats',
                type: 'GET',
                success: function(response) {
                    console.log("Order stats:", response);
                    if(response.status === 200 && response.data) {
                        displayOrderStats(response.data);
                    } else {
                        $("#orderStats").html('<div class="stat-item"><span class="stat-label">No order data available</span></div>');
                    }
                },
                error: function(xhr) {
                    console.log("Order stats API not available, showing placeholder");
                    $("#orderStats").html(`
                        <div class="stat-item">
                            <span class="stat-label">Pending Orders</span>
                            <span class="stat-value">-</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-label">Completed Today</span>
                            <span class="stat-value">-</span>
                        </div>
                    `);
                }
            });
        }

        function loadCouponStats() {
            $.ajax({
                url: '/api/restaurants/' + restaurantId + '/coupons/stats',
                type: 'GET',
                success: function(response) {
                    console.log("Coupon stats:", response);
                    if(response.status === 200 && response.data) {
                        displayCouponStats(response.data);
                    } else {
                        $("#couponStats").html('<div class="stat-item"><span class="stat-label">No coupon data available</span></div>');
                    }
                },
                error: function(xhr) {
                    console.log("Coupon stats API not available, showing placeholder");
                    $("#couponStats").html(`
                        <div class="stat-item">
                            <span class="stat-label">Active Coupons</span>
                            <span class="stat-value">-</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-label">Total Coupons</span>
                            <span class="stat-value">-</span>
                        </div>
                    `);
                }
            });
        }

        function displayOrderStats(stats) {
            var html = '';

            if(stats.pendingOrders !== undefined) {
                html += '<div class="stat-item">' +
                    '<span class="stat-label">Pending Orders</span>' +
                    '<span class="stat-value">' + (stats.pendingOrders || 0) + '</span>' +
                    '</div>';
            }

            if(stats.completedToday !== undefined) {
                html += '<div class="stat-item">' +
                    '<span class="stat-label">Completed Today</span>' +
                    '<span class="stat-value">' + (stats.completedToday || 0) + '</span>' +
                    '</div>';
            }

            if(stats.totalOrders !== undefined) {
                html += '<div class="stat-item">' +
                    '<span class="stat-label">Total Orders</span>' +
                    '<span class="stat-value">' + (stats.totalOrders || 0) + '</span>' +
                    '</div>';
            }

            if(html === '') {
                html = '<div class="stat-item"><span class="stat-label">No data available</span></div>';
            }

            $("#orderStats").html(html);
        }

        function displayCouponStats(stats) {
            var html = '';

            if(stats.activeCoupons !== undefined) {
                html += '<div class="stat-item">' +
                    '<span class="stat-label">Active Coupons</span>' +
                    '<span class="stat-value">' + (stats.activeCoupons || 0) + '</span>' +
                    '</div>';
            }

            if(stats.totalCoupons !== undefined) {
                html += '<div class="stat-item">' +
                    '<span class="stat-label">Total Coupons</span>' +
                    '<span class="stat-value">' + (stats.totalCoupons || 0) + '</span>' +
                    '</div>';
            }

            if(stats.usedCoupons !== undefined) {
                html += '<div class="stat-item">' +
                    '<span class="stat-label">Coupons Used</span>' +
                    '<span class="stat-value">' + (stats.usedCoupons || 0) + '</span>' +
                    '</div>';
            }

            if(html === '') {
                html = '<div class="stat-item"><span class="stat-label">No data available</span></div>';
            }

            $("#couponStats").html(html);
        }

        function refreshData() {
            showSuccess("Refreshing statistics...");
            loadOrderStats();
            loadCouponStats();
            setTimeout(function() {
                showSuccess("Statistics updated successfully!");
                setTimeout(function() {
                    $("#successMessage").fadeOut();
                }, 2000);
            }, 500);
        }

        function showError(message) {
            $("#errorMessage").html(message).show();
            setTimeout(function() {
                $("#errorMessage").fadeOut();
            }, 5000);
        }

        function showSuccess(message) {
            $("#successMessage").html(message).show();
            setTimeout(function() {
                $("#successMessage").fadeOut();
            }, 3000);
        }

        function escapeHtml(text) {
            if(!text) return '';
            return String(text)
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;");
        }

        // Make cards focusable for keyboard navigation
        $('.management-card').attr('tabindex', '0');

        // Add keyboard navigation (Enter key on cards)
        $(document).on('keypress', '.management-card', function(e) {
            if(e.which === 13) { // Enter key
                $(this).click();
            }
        });
    </script>
</body>
</html>