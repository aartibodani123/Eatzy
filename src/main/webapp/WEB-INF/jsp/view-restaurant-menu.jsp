<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String restaurantId = String.valueOf(request.getParameter("restaurantId"));
    String restaurantName = request.getParameter("restaurantName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Menu | Eatzy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Eatzy Theme Menu Page CSS */
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

        .container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: 2.5rem;
            box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15);
        }

        /* Header Section */
        .menu-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1.5rem;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0e4d5;
            flex-wrap: wrap;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background: #f9f9fb;
            border: 1.5px solid #eaeef2;
            border-radius: 40px;
            color: #2e2e2e;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }

        .back-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateX(-5px);
        }

        .back-btn i {
            color: #f97316;
        }

        .header-content {
            flex: 1;
        }

        .header-content h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            margin-bottom: 0.3rem;
            letter-spacing: -0.02em;
        }

        .header-content p {
            color: #6b6b6b;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .header-content p i {
            color: #f97316;
        }

        .restaurant-badge {
            background: #fff6ed;
            color: #f97316;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-size: 0.9rem;
            font-weight: 600;
            border: 1px solid #f97316;
        }

        /* Cart Icon */
        .cart-icon {
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background: #f97316;
            color: white;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }

        .cart-icon:hover {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #2e7d32;
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 700;
            border: 2px solid white;
        }

        /* Message Alert */
        #message {
            padding: 1rem 1.5rem;
            border-radius: 40px;
            margin: 1rem 0 2rem 0;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease;
        }

        #message.success {
            background: #e6f7e6;
            color: #2e7d32 !important;
            border: 1px solid #b7ebc3;
        }

        #message.error {
            background: #fff1f0;
            color: #b34033 !important;
            border: 1px solid #ffcdc7;
        }

        #message i {
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

        /* Menu Grid */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.8rem;
            margin-top: 2rem;
        }

        /* Menu Card */
        .card {
            background: white;
            border: 2px solid #eaeef2;
            border-radius: 24px;
            padding: 0;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px -8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-8px);
            border-color: #f97316;
            box-shadow: 0 20px 30px -12px rgba(249, 115, 22, 0.3);
        }

        .card-image {
            height: 160px;
            background: linear-gradient(45deg, #f97316, #ff8c42);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-image i {
            font-size: 3rem;
            color: white;
            opacity: 0.8;
        }

        .card-content {
            padding: 1.5rem;
        }

        .card h3 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 0.8rem;
        }

        .card p {
            color: #6b6b6b;
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .card p i {
            color: #f97316;
            width: 18px;
        }

        .price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #f97316;
            margin: 1rem 0 1.2rem 0;
        }

        .price small {
            font-size: 0.9rem;
            font-weight: 500;
            color: #6b6b6b;
        }

        /* Quantity Selector */
        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .qty-btn {
            width: 36px;
            height: 36px;
            border: 2px solid #eaeef2;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            color: #f97316;
            font-weight: 700;
        }

        .qty-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
        }

        .qty-input {
            width: 50px;
            text-align: center;
            border: 2px solid #eaeef2;
            border-radius: 40px;
            padding: 0.3rem;
            font-weight: 600;
        }

        /* Add to Cart Button */
        .btn {
            width: 100%;
            padding: 1rem;
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
        }

        .btn:hover:not(:disabled) {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .btn:disabled {
            background: #b7ebc3;
            color: #2e7d32;
            cursor: not-allowed;
            opacity: 0.8;
        }

        .btn i {
            font-size: 1.1rem;
        }

        /* Loading State */
        .loading {
            text-align: center;
            padding: 4rem;
            color: #6b6b6b;
            font-size: 1.1rem;
            grid-column: 1 / -1;
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

        /* Empty State */
        .empty-menu {
            text-align: center;
            padding: 4rem;
            background: #f9f9fb;
            border-radius: 30px;
            color: #6b6b6b;
            font-size: 1.1rem;
            border: 2px dashed #eaeef2;
            grid-column: 1 / -1;
        }

        .empty-menu i {
            font-size: 3rem;
            color: #f97316;
            margin-bottom: 1rem;
            display: block;
        }

        /* Animation for cards */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeInUp 0.5s ease forwards;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .container {
                padding: 1.5rem;
            }

            .menu-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-left {
                width: 100%;
            }

            .cart-icon {
                align-self: flex-end;
            }

            .header-content h2 {
                font-size: 1.8rem;
            }

            .menu-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .header-content h2 {
                font-size: 1.5rem;
            }

            .card-image {
                height: 140px;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <!-- Main Content with Sidebar Shift -->
    <div class="content" id="mainContent">
        <div class="container">
            <!-- Header with Back Button and Cart -->
            <div class="menu-header">
                <div class="header-left">
                    <a href="javascript:history.back()" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                    <div class="header-content">
                        <h2><%= restaurantName != null ? restaurantName : "Restaurant Menu" %></h2>
                        <p>
                            <i class="fas fa-store"></i> <span class="restaurant-badge">ID: <%= restaurantId %></span>
                            <i class="fas fa-clock"></i> 30-40 min
                        </p>
                    </div>
                </div>

                <!-- View Cart Button with Count -->
                <a href="${pageContext.request.contextPath}/customer/cart-page" class="cart-icon">
                    <i class="fas fa-shopping-cart"></i> View Cart
                    <span class="cart-count" id="cartCount">0</span>
                </a>
            </div>

            <!-- Message Area for Cart Alerts -->
            <div id="message" style="display: none;"></div>

            <!-- Menu Grid -->
            <div id="menuGrid" class="menu-grid">
                <div class="loading">Loading delicious menu</div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            const restaurantId = "<%= restaurantId %>";
            const contextPath = "${pageContext.request.contextPath}";

            // Load cart count on page load
            loadCartCount();

            // Function to load cart count
            function loadCartCount() {
                $.ajax({
                    url: contextPath + "/customer/cart/view",
                    method: "GET",
                    success: function(res) {
                        if (res && res.data) {
                            const cart = res.data;
                            if (cart && cart.items) {
                                const totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
                                $('#cartCount').text(totalItems);
                            }
                        }
                    },
                    error: function(xhr) {
                        console.log("Could not load cart count:", xhr.status);
                        if (xhr.status === 401) {
                            window.location.href = contextPath + "/login";
                        }
                    }
                });
            }

            // Show loading state
            $("#menuGrid").html('<div class="loading">Loading delicious menu</div>');

            $.ajax({
                url: contextPath + "/customer/restaurants/" + restaurantId + "/menu",
                method: "GET",
                success: function(response) {
                    if (!response || !response.data) {
                        $("#menuGrid").html('<div class="empty-menu"><i class="fas fa-exclamation-circle"></i>Invalid response from server</div>');
                        return;
                    }

                    const menuItems = response.data;

                    if (!menuItems || menuItems.length === 0) {
                        $("#menuGrid").html('<div class="empty-menu"><i class="fas fa-utensils"></i>No menu items available</div>');
                        return;
                    }

                    let html = "";

                    $.each(menuItems, function(i, item) {
                        // Generate food icon based on category
                        const foodIcon = item.category === 'Beverage' ? 'fa-mug-hot' :
                                        item.category === 'Dessert' ? 'fa-cake-candles' :
                                        item.category === 'Starters' ? 'fa-leaf' : 'fa-utensils';

                        html += '<div class="card" data-item-id="' + item.id + '">' +
                                    '<div class="card-image">' +
                                        '<i class="fas ' + foodIcon + '"></i>' +
                                    '</div>' +
                                    '<div class="card-content">' +
                                        '<h3>' + item.name + '</h3>' +
                                        (item.description ? '<p><i class="fas fa-info-circle"></i> ' + item.description + '</p>' : '') +
                                        '<div class="price">' +
                                            '<i class="fas fa-indian-rupee-sign"></i> ' + item.price +
                                            ' <small>per item</small>' +
                                        '</div>' +
                                        '<div class="quantity-selector">' +
                                            '<button class="qty-btn minus-btn" data-item-id="' + item.id + '">−</button>' +
                                            '<input type="number" class="qty-input" id="qty-' + item.id + '" value="1" min="1" max="99" readonly>' +
                                            '<button class="qty-btn plus-btn" data-item-id="' + item.id + '">+</button>' +
                                        '</div>' +
                                        '<button class="btn add-to-cart" ' +
                                            'data-restaurant-id="' + restaurantId + '" ' +
                                            'data-menu-item-id="' + item.id + '">' +
                                            '<i class="fas fa-shopping-cart"></i> Add to Cart' +
                                        '</button>' +
                                    '</div>' +
                                '</div>';
                    });

                    $("#menuGrid").html(html);
                },
                error: function(xhr, status, error) {
                    console.error("Error loading menu:", {
                        status: xhr.status,
                        statusText: xhr.statusText,
                        error: error
                    });

                    let errorMsg = "Failed to load menu. ";
                    if (xhr.status === 401) {
                        errorMsg = "Your session has expired. Please login again.";
                        setTimeout(() => {
                            window.location.href = contextPath + "/login";
                        }, 2000);
                    } else if (xhr.status === 404) {
                        errorMsg = "Restaurant not found.";
                    } else if (xhr.status === 500) {
                        errorMsg = "Server error. Please try again later.";
                    }

                    $("#menuGrid").html('<div class="empty-menu"><i class="fas fa-exclamation-circle"></i>' + errorMsg + '</div>');
                }
            });

            // Quantity selector - Plus button
            $(document).on('click', '.plus-btn', function() {
                const itemId = $(this).data('item-id');
                const input = $('#qty-' + itemId);
                let val = parseInt(input.val()) || 1;
                if (val < 99) {
                    input.val(val + 1);
                }
            });

            // Quantity selector - Minus button
            $(document).on('click', '.minus-btn', function() {
                const itemId = $(this).data('item-id');
                const input = $('#qty-' + itemId);
                let val = parseInt(input.val()) || 1;
                if (val > 1) {
                    input.val(val - 1);
                }
            });

            // Add to Cart functionality with quantity
            $(document).on("click", ".add-to-cart", function () {
                const btn = $(this);
                const card = btn.closest('.card');
                const itemId = card.data('item-id');
                const restaurantId = $(this).data("restaurant-id");
                const menuItemId = $(this).data("menu-item-id");
                const quantity = parseInt($('#qty-' + itemId).val()) || 1;

                btn.prop("disabled", true);
                btn.html('<i class="fas fa-spinner fa-spin"></i> Adding...');

                if (quantity === 1) {
                    // Single item
                    $.ajax({
                        url: contextPath + "/customer/cart/add",
                        method: "POST",
                        contentType: "application/json",
                        data: JSON.stringify({
                            restaurantId: restaurantId,
                            menuItemId: menuItemId
                        }),
                        success: function(res) {
                            handleAddToCartSuccess(res, quantity, card, btn, itemId);
                        },
                        error: function(xhr) {
                            handleAddToCartError(xhr, btn);
                        }
                    });
                } else {
                    // Multiple items - using promise to handle all requests
                    const promises = [];
                    for (let i = 0; i < quantity; i++) {
                        promises.push(
                            $.ajax({
                                url: contextPath + "/customer/cart/add",
                                method: "POST",
                                contentType: "application/json",
                                data: JSON.stringify({
                                    restaurantId: restaurantId,
                                    menuItemId: menuItemId
                                })
                            })
                        );
                    }

                    Promise.all(promises)
                        .then(results => {
                            handleAddToCartSuccess(results[0], quantity, card, btn, itemId);
                        })
                        .catch(error => {
                            handleAddToCartError(error, btn);
                        });
                }

                function handleAddToCartSuccess(res, quantity, card, btn, itemId) {
                    // Show success message
                    $("#message")
                        .removeClass('error')
                        .addClass('success')
                        .html('<i class="fas fa-check-circle"></i> ' + quantity + ' x ' + card.find('h3').text() + ' added to cart!')
                        .css("display", "flex");

                    // Update button
                    btn.html('<i class="fas fa-check"></i> Added to Cart');
                    btn.css("background", "#2e7d32");

                    // Update cart count
                    loadCartCount();

                    // Auto-hide message after 3 seconds
                    setTimeout(() => {
                        $("#message").fadeOut();
                    }, 3000);

                    // Re-enable button after 2 seconds
                    setTimeout(() => {
                        btn.prop("disabled", false);
                        btn.html('<i class="fas fa-shopping-cart"></i> Add to Cart');
                        btn.css("background", "");
                        // Reset quantity to 1
                        $('#qty-' + itemId).val(1);
                    }, 2000);
                }

                function handleAddToCartError(xhr, btn) {
                    const msg = xhr.responseJSON?.message || "Failed to add to cart";
                    $("#message")
                        .removeClass('success')
                        .addClass('error')
                        .html('<i class="fas fa-exclamation-circle"></i> ' + msg)
                        .css("display", "flex");

                    // Re-enable button on error
                    btn.prop("disabled", false);
                    btn.html('<i class="fas fa-shopping-cart"></i> Add to Cart');

                    // Auto-hide message after 3 seconds
                    setTimeout(() => {
                        $("#message").fadeOut();
                    }, 3000);
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

        // Initialize sidebar toggle when DOM is ready
        $(document).ready(function() {
            setTimeout(initSidebarToggle, 100);
        });
    </script>
</body>
</html>