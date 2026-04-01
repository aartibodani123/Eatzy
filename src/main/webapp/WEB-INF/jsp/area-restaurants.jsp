<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String area = request.getParameter("area");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurants in <%= area %> | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #f8f9fc;
            color: #1a1e2b;
        }

        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            min-height: 100vh;
            background: linear-gradient(135deg, #f8f9fc 0%, #ffffff 100%);
        }

        .content.shift {
            margin-left: 280px;
        }

        .container {
            max-width: 1440px;
            margin: 0 auto;
        }

        /* Enhanced Header Section */
        .area-header {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 2.5rem;
            flex-wrap: wrap;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.875rem 1.75rem;
            background: white;
            border: 1px solid rgba(249, 115, 22, 0.1);
            border-radius: 100px;
            color: #2d3748;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
        }

        .back-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateX(-5px);
            box-shadow: 0 8px 20px rgba(249, 115, 22, 0.15);
        }

        .back-btn i {
            color: #f97316;
            font-size: 0.9rem;
            transition: transform 0.2s ease;
        }

        .back-btn:hover i {
            transform: translateX(-3px);
        }

        .area-header h2 {
            font-size: 2rem;
            font-weight: 600;
            background: linear-gradient(135deg, #1a1e2b 0%, #2d3748 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .area-badge {
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            color: white;
            padding: 0.625rem 2rem;
            border-radius: 100px;
            font-size: 1.1rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: 0 10px 20px rgba(249, 115, 22, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
        }

        .area-badge i {
            font-size: 1rem;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
        }

        /* Enhanced Restaurant Grid - More columns with smaller cards */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
            animation: fadeIn 0.6s ease-out;
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

        /* Enhanced Card Styling - Smaller size */
        .card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            border: 1px solid rgba(249, 115, 22, 0.05);
            max-width: 280px;
            display: flex;
            flex-direction: column;
            height: 100%;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }
        .card:nth-child(5) { animation-delay: 0.5s; }
        .card:nth-child(6) { animation-delay: 0.6s; }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 40px rgba(249, 115, 22, 0.12);
            border-color: rgba(249, 115, 22, 0.2);
        }

        /* Enhanced Image Container - Smaller height */
        .restaurant-image {
            width: 100%;
            height: 140px;
            background-size: cover;
            background-position: center;
            position: relative;
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            flex-shrink: 0;
        }

        .card:hover .restaurant-image {
            transform: scale(1.08);
        }

        .restaurant-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.6) 100%);
            z-index: 1;
            opacity: 0.6;
            transition: opacity 0.3s ease;
        }

        .card:hover .restaurant-image::before {
            opacity: 0.8;
        }

        /* Add offer badge - Smaller */
        .restaurant-image::after {
            content: '20% OFF';
            position: absolute;
            top: 12px;
            right: 12px;
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            color: white;
            padding: 4px 10px;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            z-index: 2;
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Enhanced Card Content - Smaller padding */
        .card-content {
            padding: 1rem;
            position: relative;
            flex: 1;
            display: flex;
            flex-direction: column;
            background: white;
        }

        .card-content h3 {
            margin: 0 0 0.35rem 0;
            font-size: 1.1rem;
            font-weight: 700;
            color: #1a1e2b;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            letter-spacing: -0.3px;
        }

        /* Enhanced Restaurant Meta - Smaller */
        .restaurant-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 0.75rem;
            margin: 0.35rem 0;
            color: #64748b;
            font-size: 0.8rem;
        }

        .restaurant-meta span:first-child {
            background: #f1f5f9;
            padding: 0.25rem 0.75rem;
            border-radius: 40px;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            font-weight: 500;
        }

        .restaurant-meta i {
            color: #f97316;
            font-size: 0.7rem;
        }

        /* Enhanced Rating Badge - Smaller */
        .rating-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            background: #fff6ed;
            color: #f97316;
            padding: 0.25rem 0.75rem;
            border-radius: 40px;
            font-size: 0.8rem;
            font-weight: 700;
            border: 1px solid rgba(249, 115, 22, 0.1);
        }

        .rating-badge i {
            color: #ffb83d;
            font-size: 0.65rem;
            filter: drop-shadow(0 2px 4px rgba(249, 115, 22, 0.2));
        }

        /* Enhanced Address Styling - More compact */
        .card-content p {
            margin: 0.5rem 0 0.75rem 0;
            font-size: 0.75rem;
            color: #64748b;
            display: flex;
            align-items: flex-start;
            gap: 0.4rem;
            line-height: 1.4;
            min-height: 45px;
            max-height: 60px;
            overflow-y: auto;
            padding-right: 0.4rem;
            background: #f8fafc;
            padding: 0.5rem;
            border-radius: 10px;
            border: 1px solid #eef2f6;
        }

        /* Custom scrollbar */
        .card-content p::-webkit-scrollbar {
            width: 3px;
        }

        .card-content p::-webkit-scrollbar-track {
            background: #eef2f6;
            border-radius: 4px;
        }

        .card-content p::-webkit-scrollbar-thumb {
            background: #f97316;
            border-radius: 4px;
        }

        .card-content p i {
            color: #f97316;
            font-size: 0.7rem;
            margin-top: 0.15rem;
            flex-shrink: 0;
        }

        /* Enhanced View Menu Button - Smaller */
        .view-menu-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            width: 100%;
            padding: 0.65rem;
            background: linear-gradient(135deg, #f97316 0%, #fb923c 100%);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 0.5rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.2);
            letter-spacing: 0.3px;
            text-transform: uppercase;
        }

        .view-menu-btn:hover {
            background: white;
            color: #f97316;
            border-color: #f97316;
            box-shadow: 0 8px 24px rgba(249, 115, 22, 0.3);
            transform: scale(1.02);
        }

        .view-menu-btn i {
            font-size: 0.75rem;
            transition: transform 0.2s ease;
        }

        .view-menu-btn:hover i {
            transform: translateX(3px);
        }

        /* Enhanced Loading/Error States */
        .loading, .no-areas, .error-message {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
            font-size: 1.1rem;
            background: white;
            border-radius: 24px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.04);
            grid-column: 1 / -1;
            border: 1px solid #eef2f6;
        }

        .loading i, .no-areas i, .error-message i {
            display: block;
            font-size: 3rem;
            color: #f97316;
            margin-bottom: 1.5rem;
        }

        .loading i {
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .no-areas i {
            color: #94a3b8;
            opacity: 0.5;
        }

        /* Delivery time badge - Smaller */
        .delivery-badge {
            position: absolute;
            bottom: 12px;
            left: 12px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px);
            padding: 4px 10px;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 600;
            color: #1a1e2b;
            z-index: 2;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 0.35rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .delivery-badge i {
            color: #f97316;
            font-size: 0.65rem;
        }

        /* Responsive Design - Adjusted for smaller cards */
        @media (max-width: 1024px) {
            .content {
                padding: 1.5rem 1.5rem 1.5rem 4.5rem;
            }

            .grid {
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                gap: 1.25rem;
            }

            .area-header h2 {
                font-size: 1.75rem;
            }

            .card {
                max-width: 260px;
            }
        }

        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .area-header {
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .area-header h2 {
                font-size: 1.5rem;
            }

            .area-badge {
                padding: 0.5rem 1.5rem;
                font-size: 1rem;
            }

            .grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1rem;
            }

            .restaurant-image {
                height: 120px;
            }

            .restaurant-image::after {
                top: 10px;
                right: 10px;
                padding: 3px 8px;
                font-size: 0.65rem;
            }

            .delivery-badge {
                bottom: 10px;
                left: 10px;
                padding: 3px 8px;
                font-size: 0.65rem;
            }

            .card-content {
                padding: 0.85rem;
            }

            .card-content h3 {
                font-size: 1rem;
            }

            .restaurant-meta {
                font-size: 0.75rem;
            }

            .card-content p {
                min-height: 40px;
                max-height: 55px;
                font-size: 0.7rem;
                padding: 0.4rem;
            }
        }

        @media (max-width: 480px) {
            .area-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .back-btn {
                width: 100%;
                justify-content: center;
            }

            .area-header h2 {
                font-size: 1.25rem;
            }

            .area-badge {
                width: 100%;
                justify-content: center;
            }

            .grid {
                grid-template-columns: 1fr;
            }

            .card {
                max-width: 100%;
            }
        }

        /* Smooth hover effects for all interactive elements */
        .card * {
            transition: all 0.2s ease;
        }

        /* Subtle pattern overlay */
        .content::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: radial-gradient(rgba(249, 115, 22, 0.02) 1px, transparent 1px);
            background-size: 30px 30px;
            pointer-events: none;
            z-index: -1;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <div class="content" id="mainContent">
        <div class="container">
            <!-- Enhanced Header with Back Button and Area -->
            <div class="area-header">
                <a href="javascript:history.back()" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Areas
                </a>
                <h2>Restaurants in</h2>
                <span class="area-badge"><i class="fas fa-map-marker-alt"></i> <%= area %></span>
            </div>

            <!-- Restaurant Grid -->
            <div id="restaurantGrid" class="grid"></div>
        </div>
    </div>

    <script>
        // Helper function to escape HTML and prevent XSS attacks
        function escapeHtml(str) {
            if (!str) return '';
            return str
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        $(document).ready(function () {
            let area = "<%= area %>";
            const contextPath = "${pageContext.request.contextPath}";

            $("#restaurantGrid").html('<div class="loading"><i class="fas fa-spinner fa-pulse"></i>Finding restaurants in ' + escapeHtml(area) + '...</div>');

            $.ajax({
                url: contextPath + "/customer/restaurants",
                method: "GET",
                data: { area: area },
                success: function (response) {
                    let restaurants = response.data;

                    if (!restaurants || restaurants.length === 0) {
                        $("#restaurantGrid").html('<div class="no-areas"><i class="fas fa-store-alt"></i>No restaurants found in ' + escapeHtml(area) + '</div>');
                        return;
                    }

                    let html = "";

                    $.each(restaurants, function (i, r) {
                        // Use the imageUrl from backend, fallback to default if not provided
                        const defaultImage = 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600';
                        const imageUrl = r.imageUrl && r.imageUrl.trim() !== ""
                            ? r.imageUrl
                            : defaultImage;

                        const rating = (Math.random() * 1.5 + 3.5).toFixed(1);
                        const deliveryTime = Math.floor(Math.random() * 20 + 25); // Random delivery time between 25-45 mins

                        html += '<div class="card" data-id="' + r.id + '">' +
                                    '<div class="restaurant-image" style="background-image: linear-gradient(45deg, rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url(\'' + imageUrl + '\');">' +
                                        '<span class="delivery-badge"><i class="fas fa-motorcycle"></i> ' + deliveryTime + '-35 min</span>' +
                                    '</div>' +
                                    '<div class="card-content">' +
                                        '<h3>' + escapeHtml(r.name) + '</h3>' +
                                        '<div class="restaurant-meta">' +
                                            '<span><i class="fas fa-map-marker-alt"></i> ' + escapeHtml(r.area) + '</span>' +
                                            '<span class="rating-badge"><i class="fas fa-star"></i> ' + rating + '</span>' +
                                        '</div>' +
                                        '<p><i class="fas fa-location-dot"></i> ' + escapeHtml(r.location || 'Location available') + '</p>' +
                                        '<button class="view-menu-btn"><i class="fas fa-utensils"></i> View Menu <i class="fas fa-arrow-right"></i></button>' +
                                    '</div>' +
                                '</div>';
                    });

                    $("#restaurantGrid").html(html);
                },
                error: function (xhr, status, error) {
                    console.error("Failed to load restaurants:", error);
                    $("#restaurantGrid").html('<div class="error-message"><i class="fas fa-exclamation-circle"></i>Failed to load restaurants. Please try again.</div>');
                }
            });

            // Card click handler
            $(document).on("click", ".card", function (e) {
                if ($(e.target).closest('.view-menu-btn').length) {
                    return;
                }
                const restaurantId = $(this).attr("data-id");
                if (!restaurantId) {
                    alert("Invalid restaurant");
                    return;
                }
                window.location.href =
                    contextPath + "/customer/view-restaurant-menu?restaurantId=" +
                    encodeURIComponent(restaurantId);
            });

            // View menu button click handler
            $(document).on("click", ".view-menu-btn", function (e) {
                e.stopPropagation();
                const card = $(this).closest('.card');
                const restaurantId = card.attr("data-id");
                if (!restaurantId) {
                    alert("Invalid restaurant");
                    return;
                }
                window.location.href =
                    contextPath + "/customer/view-restaurant-menu?restaurantId=" +
                    encodeURIComponent(restaurantId);
            });
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