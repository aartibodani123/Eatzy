<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Restaurants | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
    <style>

        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
        }

        /* Cart Icon Styles */
        .cart-icon-container {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            margin-bottom: 1.5rem;
        }

        .cart-link {
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.8rem 1.5rem;
            background: #f97316;
            color: white;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .cart-link:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .cart-link i {
            font-size: 1.2rem;
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

        .cart-preview {
            position: absolute;
            top: 60px;
            right: 0;
            width: 320px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px -10px rgba(0,0,0,0.2);
            border: 2px solid #eaeef2;
            z-index: 1000;
            display: none;
            overflow: hidden;
        }

        .cart-preview.show {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .cart-preview-header {
            background: #f97316;
            color: white;
            padding: 1rem;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cart-preview-header i {
            cursor: pointer;
        }

        .cart-preview-items {
            max-height: 250px;
            overflow-y: auto;
            padding: 0.5rem;
        }

        .cart-preview-item {
            display: flex;
            align-items: center;
            padding: 0.8rem;
            border-bottom: 1px solid #f0e4d5;
        }

        .cart-preview-item:last-child {
            border-bottom: none;
        }

        .cart-preview-item-img {
            width: 40px;
            height: 40px;
            background: #fff6ed;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.8rem;
            color: #f97316;
        }

        .cart-preview-item-details {
            flex: 1;
        }

        .cart-preview-item-name {
            font-weight: 600;
            color: #1e1e1e;
            font-size: 0.9rem;
        }

        .cart-preview-item-price {
            color: #f97316;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .cart-preview-item-qty {
            color: #6b6b6b;
            font-size: 0.8rem;
        }

        .cart-preview-footer {
            padding: 1rem;
            border-top: 1px solid #f0e4d5;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f9f9fb;
        }

        .cart-preview-total {
            font-weight: 700;
            color: #1e1e1e;
        }

        .cart-preview-total span {
            color: #f97316;
            font-size: 1.2rem;
        }

        .cart-preview-btn {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .cart-preview-btn:hover {
            background: #e85d0e;
        }

        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .cart-preview {
                width: 280px;
                right: 10px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <div class="content" id="mainContent">
        <div class="container">
            <!-- Cart Icon with Count and Preview -->
            <div class="cart-icon-container">
                <div style="position: relative;">
                    <a href="${pageContext.request.contextPath}/customer/cart-page" class="cart-link" id="cartLink">
                        <i class="fas fa-shopping-cart"></i> View Cart
                        <span class="cart-count" id="cartCount">0</span>
                    </a>

                    <!-- Cart Preview Dropdown -->
                    <div class="cart-preview" id="cartPreview">
                        <div class="cart-preview-header">
                            <span><i class="fas fa-shopping-cart"></i> Your Cart</span>
                            <i class="fas fa-times" id="closePreview"></i>
                        </div>
                        <div class="cart-preview-items" id="cartPreviewItems">
                            <div style="text-align: center; padding: 1rem; color: #6b6b6b;">
                                <i class="fas fa-spinner fa-spin"></i> Loading...
                            </div>
                        </div>
                        <div class="cart-preview-footer">
                            <span class="cart-preview-total">Total: <span id="cartPreviewTotal">₹0</span></span>
                            <a href="${pageContext.request.contextPath}/customer/cart-page" class="cart-preview-btn">
                                View Full Cart <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <h2>Browse Restaurants</h2>
            <p>Select your area</p>
            <div id="areasGrid" class="grid"></div>
        </div>
    </div>

    <script>
        const areaImages = {
            'Bodakdev': 'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&w=600',
            'Navrangpura': 'https://images.pexels.com/photos/3586966/pexels-photo-3586966.jpeg?auto=compress&cs=tinysrgb&w=600',
            'Satellite': 'https://images.pexels.com/photos/3586964/pexels-photo-3586964.jpeg?auto=compress&cs=tinysrgb&w=600',
            'Vastrapur': 'https://images.pexels.com/photos/2983101/pexels-photo-2983101.jpeg?auto=compress&cs=tinysrgb&w=600',
            'CG Road': 'https://images.pexels.com/photos/3586961/pexels-photo-3586961.jpeg?auto=compress&cs=tinysrgb&w=600',
            'Paldi': 'https://images.pexels.com/photos/3586965/pexels-photo-3586965.jpeg?auto=compress&cs=tinysrgb&w=600',
            'Maninagar': 'https://images.pexels.com/photos/3586962/pexels-photo-3586962.jpeg?auto=compress&cs=tinysrgb&w=600'
        };

        const restaurantCounts = {
            'Bodakdev': '450+',
            'Navrangpura': '380+',
            'Satellite': '520+',
            'Vastrapur': '410+',
            'CG Road': '320+',
            'Paldi': '280+',
            'Maninagar': '350+'
        };

        const defaultImage = 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600';

        // Function to load cart count and preview
        function loadCartInfo() {
            $.ajax({
                url: "${pageContext.request.contextPath}/customer/cart/view",
                method: "GET",
                success: function(response) {
                    const cart = response.data;
                    console.log("Cart data:", cart);

                    if (cart && cart.items) {
                        // Update cart count
                        const totalItems = cart.items.reduce((sum, item) => sum + item.quantity, 0);
                        $('#cartCount').text(totalItems);

                        // Update cart preview
                        updateCartPreview(cart);
                    }
                },
                error: function(xhr) {
                    console.error("Failed to load cart:", xhr);
                    if (xhr.status === 401) {
                        // Redirect to login if unauthorized
                        window.location.href = "${pageContext.request.contextPath}/login";
                    }
                }
            });
        }

        // Function to update cart preview
        function updateCartPreview(cart) {
            const previewItems = $('#cartPreviewItems');
            const previewTotal = $('#cartPreviewTotal');

            if (!cart.items || cart.items.length === 0) {
                previewItems.html(`
                    <div style="text-align: center; padding: 2rem; color: #6b6b6b;">
                        <i class="fas fa-shopping-cart" style="font-size: 2rem; color: #f97316; margin-bottom: 0.5rem;"></i>
                        <p>Your cart is empty</p>
                    </div>
                `);
                previewTotal.text('₹0');
                return;
            }

            let itemsHtml = '';
            cart.items.forEach(item => {
                itemsHtml += `
                    <div class="cart-preview-item">
                        <div class="cart-preview-item-img">
                            <i class="fas fa-utensils"></i>
                        </div>
                        <div class="cart-preview-item-details">
                            <div class="cart-preview-item-name">${item.name}</div>
                            <div class="cart-preview-item-price">₹${item.price}</div>
                        </div>
                        <div class="cart-preview-item-qty">x${item.quantity}</div>
                    </div>
                `;
            });

            previewItems.html(itemsHtml);
            previewTotal.text('₹' + cart.totalPrice);
        }

        $(document).ready(function () {
            const contextPath = "${pageContext.request.contextPath}";

            // Load cart info on page load
            loadCartInfo();

            // Show loading state
            $("#areasGrid").html('<div class="loading">Loading areas</div>');

            $.ajax({
                url: contextPath + "/customer/getAreas",
                method: "GET",
                success: function (response) {
                    let areas = response.data;
                    console.log("areas", areas);

                    if (!areas || areas.length === 0) {
                        $("#areasGrid").html('<div class="no-areas"><i class="fas fa-map-marker-alt"></i>No areas available</div>');
                        return;
                    }

                    let html = "";

                    areas.forEach(function(area) {
                        const trimmedArea = area.trim();
                        const imageUrl = areaImages[trimmedArea] || defaultImage;
                        const count = restaurantCounts[trimmedArea] || Math.floor(Math.random() * 500 + 200) + '+';

                        html += '<div class="card" data-area="' + area + '">' +
                                    '<div class="card-image" style="background-image: linear-gradient(45deg, rgba(0,0,0,0.2), rgba(0,0,0,0.2)), url(\'' + imageUrl + '\');">' +
                                    '</div>' +
                                    '<div class="card-content">' +
                                        '<h3>' + area + '</h3>' +
                                        '<span class="restaurant-count"><i class="fas fa-utensils"></i> ' + count + ' Restaurants</span>' +
                                        '<span class="explore-badge"><i class="fas fa-arrow-right"></i> Explore</span>' +
                                    '</div>' +
                                '</div>';
                    });

                    $("#areasGrid").html(html);
                },
                error: function (xhr, status, error) {
                    console.error("Error loading areas:", error);
                    $("#areasGrid").html('<div class="error-message"><i class="fas fa-exclamation-circle"></i>Failed to load areas. Please try again.</div>');
                }
            });

            // Cart preview toggle
            let previewTimeout;

            $("#cartLink").hover(
                function() {
                    clearTimeout(previewTimeout);
                    $("#cartPreview").addClass("show");
                },
                function() {
                    previewTimeout = setTimeout(function() {
                        if (!$("#cartPreview:hover").length) {
                            $("#cartPreview").removeClass("show");
                        }
                    }, 200);
                }
            );

            $("#cartPreview").hover(
                function() {
                    clearTimeout(previewTimeout);
                },
                function() {
                    previewTimeout = setTimeout(function() {
                        $("#cartPreview").removeClass("show");
                    }, 200);
                }
            );

            $("#closePreview").click(function() {
                $("#cartPreview").removeClass("show");
            });

            // Refresh cart info periodically (every 30 seconds)
            setInterval(loadCartInfo, 30000);
        });

        $(document).on("click", ".card", function () {
            const area = $(this).attr("data-area");

            console.log("Selected area:", area);

            if (!area || area.trim() === "") {
                alert("Invalid area selected");
                return;
            }

            window.location.href =
                "${pageContext.request.contextPath}/customer/area-restaurants?area=" +
                encodeURIComponent(area);
        });

        function initSidebarToggle() {
            const hamburger = document.getElementById("hamburgerBtn");
            const sidebar = document.getElementById("sidebar");
            const mainContent = document.getElementById("mainContent");

            if (!hamburger || !sidebar || !mainContent) {
                console.error("Sidebar elements not found");
                return;
            }

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

            sidebar.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        $(document).ready(function() {
            setTimeout(initSidebarToggle, 100);
        });
    </script>
</body>
</html>