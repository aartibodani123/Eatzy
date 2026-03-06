<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Your Cart | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Eatzy Theme Cart CSS */
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

        /* Main Container */
        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: 2.5rem;
            box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15);
        }

        /* Header */
        .cart-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0e4d5;
            flex-wrap: wrap;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .cart-header i {
            font-size: 2.5rem;
            color: #f97316;
            background: #fff6ed;
            padding: 1rem;
            border-radius: 50%;
        }

        .cart-header h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }

        .cart-header h2::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
            margin-top: 0.5rem;
        }

        /* View Orders Button */
        .view-orders-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.8rem 1.5rem;
            background: #f9f9fb;
            border: 1.5px solid #eaeef2;
            border-radius: 40px;
            color: #2e2e2e;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }

        .view-orders-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateY(-2px);
        }

        .view-orders-btn i {
            color: #f97316;
        }

        /* Table Styling */
        .table-wrapper {
            overflow-x: auto;
            margin-bottom: 2rem;
            border-radius: 20px;
            border: 2px solid #eaeef2;
            background: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1rem;
        }

        thead tr {
            background: #f9f9fb;
            border-bottom: 2px solid #f97316;
        }

        thead th {
            padding: 1.2rem 1rem;
            text-align: left;
            font-weight: 700;
            color: #1e1e1e;
            font-size: 1rem;
        }

        thead th:first-child {
            padding-left: 2rem;
            border-radius: 20px 0 0 0;
        }

        thead th:last-child {
            padding-right: 2rem;
            border-radius: 0 20px 0 0;
        }

        tbody tr {
            border-bottom: 1px solid #f0e4d5;
            transition: background 0.2s;
        }

        tbody tr:hover {
            background: #fff6ed;
        }

        tbody td {
            padding: 1.2rem 1rem;
            color: #2e2e2e;
        }

        tbody td:first-child {
            padding-left: 2rem;
        }

        tbody td:last-child {
            padding-right: 2rem;
        }

        /* Item Name with Icon */
        .item-name {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .item-name i {
            color: #f97316;
            font-size: 1.2rem;
        }

        /* Quantity Badge */
        .quantity-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            background: #f9f9fb;
            border: 1px solid #eaeef2;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-weight: 600;
        }

        .quantity-badge i {
            color: #f97316;
        }

        /* Price Styling */
        .price {
            font-weight: 700;
            color: #f97316;
        }

        /* Cart Summary */
        .cart-summary {
            background: #f9f9fb;
            border-radius: 20px;
            padding: 1.5rem;
            margin: 2rem 0;
            border: 2px solid #eaeef2;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .total-label {
            font-size: 1.2rem;
            font-weight: 600;
            color: #1e1e1e;
        }

        .total-amount {
            font-size: 2.2rem;
            font-weight: 800;
            color: #f97316;
        }

        .total-amount small {
            font-size: 1rem;
            font-weight: 500;
            color: #6b6b6b;
        }

        /* Action Buttons */
        .cart-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
        }

        .btn-primary {
            background: #f97316;
            color: white;
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .btn-primary:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .btn-primary:disabled {
            background: #b7ebc3;
            color: #2e7d32;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-secondary {
            background: #f9f9fb;
            color: #2e2e2e;
            border: 1.5px solid #eaeef2;
        }

        .btn-secondary:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateY(-2px);
        }

        .btn-outline {
            background: transparent;
            color: #f97316;
            border: 2px solid #f97316;
        }

        .btn-outline:hover {
            background: #fff6ed;
            transform: translateY(-2px);
        }

        /* Message Area */
        .message-area {
            margin-top: 2rem;
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

        /* Empty Cart State */
        .empty-cart {
            text-align: center;
            padding: 4rem;
            background: #f9f9fb;
            border-radius: 30px;
            border: 2px dashed #eaeef2;
        }

        .empty-cart i {
            font-size: 4rem;
            color: #f97316;
            margin-bottom: 1rem;
        }

        .empty-cart h3 {
            font-size: 1.5rem;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
        }

        .empty-cart p {
            color: #6b6b6b;
            margin-bottom: 2rem;
        }

        .empty-cart .btn {
            display: inline-flex;
        }

        /* Loading State */
        .loading {
            text-align: center;
            padding: 3rem;
            color: #6b6b6b;
        }

        .loading::after {
            content: '...';
            animation: dots 1.5s steps(4, end) infinite;
        }

        @keyframes dots {
            0%, 20% { content: '.'; }
            40% { content: '..'; }
            60%, 100% { content: '...'; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .cart-container {
                padding: 1.5rem;
            }

            .cart-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-left {
                width: 100%;
            }

            .cart-header h2 {
                font-size: 1.8rem;
            }

            .cart-header i {
                font-size: 2rem;
                padding: 0.8rem;
            }

            .view-orders-btn {
                width: 100%;
                justify-content: center;
            }

            .cart-summary {
                flex-direction: column;
                text-align: center;
            }

            .total-amount {
                font-size: 1.8rem;
            }

            .cart-actions {
                justify-content: center;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            thead th {
                font-size: 0.9rem;
                padding: 1rem 0.5rem;
            }

            tbody td {
                padding: 1rem 0.5rem;
            }

            thead th:first-child,
            tbody td:first-child {
                padding-left: 1rem;
            }

            thead th:last-child,
            tbody td:last-child {
                padding-right: 1rem;
            }
        }

        /* Animation for table rows */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateX(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        tbody tr {
            animation: fadeIn 0.3s ease forwards;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <!-- Main Content with Sidebar Shift -->
    <div class="content" id="mainContent">
        <div class="cart-container">
            <!-- Header with View Orders Button -->
            <div class="cart-header">
                <div class="header-left">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Your Cart</h2>
                </div>
                <a href="${pageContext.request.contextPath}/customer/orders" class="view-orders-btn">
                    <i class="fas fa-clipboard-list"></i>
                    View My Orders
                </a>
            </div>

            <!-- Cart Table -->
            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Item</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                    </thead>
                    <tbody id="cart-body">
                        <!-- Will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>

            <!-- Cart Summary -->
            <div class="cart-summary">
                <span class="total-label">Total Amount</span>
                <span class="total-amount" id="total">
                    0 <small>₹</small>
                </span>
            </div>

            <!-- Cart Actions -->
            <div class="cart-actions">
                <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/customer/browse-restaurant'">
                    <i class="fas fa-arrow-left"></i>
                    Continue Shopping
                </button>
                <button class="btn btn-primary" id="place-order">
                    <i class="fas fa-check-circle"></i>
                    Place Order
                </button>
            </div>

            <!-- Message Area -->
            <div id="message" class="message-area" style="display: none;"></div>

            <!-- Hidden template for empty cart -->
            <div id="empty-cart-template" style="display: none;">
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Your cart is empty</h3>
                    <p>Looks like you haven't added any items to your cart yet.</p>
                    <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                        <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/customer/browse-restaurant'">
                            <i class="fas fa-utensils"></i>
                            Browse Restaurants
                        </button>
                        <a href="${pageContext.request.contextPath}/customer/orders" class="btn btn-outline">
                            <i class="fas fa-clipboard-list"></i>
                            View My Orders
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function loadCart() {
            // Show loading state
            $("#cart-body").html('<tr><td colspan="3" class="loading">Loading your cart</td></tr>');

            $.ajax({
                url: "/customer/cart/view",
                method: "GET",
                success: function (res) {
                    const cart = res.data;
                    console.log("Cart data:", cart);

                    // Check if cart is empty
                    if (!cart.items || cart.items.length === 0) {
                        const emptyTemplate = $("#empty-cart-template").html();
                        $(".table-wrapper").html(emptyTemplate);
                        $(".cart-summary, .cart-actions").hide();
                        return;
                    }

                    // Show summary and actions
                    $(".cart-summary, .cart-actions").show();

                    // Clear and populate table
                    $("#cart-body").empty();

                    cart.items.forEach(function(item, index) {
                        // Add animation delay based on index
                        const delay = index * 0.1;

                        var row = "<tr style='animation-delay: " + delay + "s'>" +
                                    "<td>" +
                                        "<div class='item-name'>" +
                                            "<i class='fas fa-utensils'></i>" +
                                            "<span>" + item.name + "</span>" +
                                        "</div>" +
                                    "</td>" +
                                    "<td>" +
                                        "<span class='quantity-badge'>" +
                                            "<i class='fas fa-times'></i>" +
                                            item.quantity +
                                        "</span>" +
                                    "</td>" +
                                    "<td><span class='price'>₹" + item.price + "</span></td>" +
                                  "</tr>";

                        $("#cart-body").append(row);
                    });

                    $("#total").html(cart.totalPrice + " <small>₹</small>");
                },
                error: function(xhr, status, error) {
                    console.error("Failed to load cart:", error);
                    if (xhr.status === 401) {
                        window.location.href = "${pageContext.request.contextPath}/login";
                    } else {
                        $("#cart-body").html('<tr><td colspan="3" style="text-align: center; color: #b34033; padding: 2rem;"><i class="fas fa-exclamation-circle"></i> Failed to load cart. Please try again.</td></tr>');
                    }
                }
            });
        }

        $("#place-order").click(function () {
            const btn = $(this);

            // Disable button to prevent double clicks
            btn.prop("disabled", true);
            btn.html('<i class="fas fa-spinner fa-spin"></i> Placing Order...');

            $.ajax({
                url: "/customer/orders/place",
                method: "POST",
                success: function (res) {
                    $("#message")
                        .removeClass("error")
                        .addClass("success")
                        .html('<i class="fas fa-check-circle"></i> ' + (res.message || "Order placed successfully!"))
                        .show();

                    // Reload cart
                    loadCart();

                    // Re-enable button
                    btn.prop("disabled", false);
                    btn.html('<i class="fas fa-check-circle"></i> Place Order');

                    // Auto-hide message after 5 seconds
                    setTimeout(() => {
                        $("#message").fadeOut();
                    }, 5000);
                },
                error: function (xhr) {
                    const msg = xhr.responseJSON?.message || "Order failed. Please try again.";

                    $("#message")
                        .removeClass("success")
                        .addClass("error")
                        .html('<i class="fas fa-exclamation-circle"></i> ' + msg)
                        .show();

                    // Re-enable button
                    btn.prop("disabled", false);
                    btn.html('<i class="fas fa-check-circle"></i> Place Order');

                    // Auto-hide message after 5 seconds
                    setTimeout(() => {
                        $("#message").fadeOut();
                    }, 5000);
                }
            });
        });

        // Sidebar toggle functionality
        function initSidebarToggle() {
            const hamburger = document.getElementById("hamburgerBtn");
            const sidebar = document.getElementById("sidebar");
            const mainContent = document.getElementById("mainContent");

            if (!hamburger || !sidebar || !mainContent) {
                console.error("Sidebar elements not found");
                return;
            }

            // Toggle sidebar on hamburger click
            hamburger.addEventListener("click", function (e) {
                e.stopPropagation();
                sidebar.classList.toggle("open");
                mainContent.classList.toggle("shift");
            });

            // Close sidebar when clicking outside
            document.addEventListener('click', function(event) {
                if (!sidebar.contains(event.target) &&
                    !hamburger.contains(event.target) &&
                    sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    mainContent.classList.remove('shift');
                }
            });

            // Prevent clicks inside sidebar from closing it
            sidebar.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        // Load cart on page load
        $(document).ready(function() {
            loadCart();
            setTimeout(initSidebarToggle, 100);
        });
    </script>
</body>
</html>