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

        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
        }


        .restaurant-image {
            height: 160px;
            background-size: cover;
            background-position: center;
            position: relative;
            transition: transform 0.5s ease;
        }

        .card:hover .restaurant-image {
            transform: scale(1.05);
        }

        .restaurant-image::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.4) 100%);
        }

        .restaurant-info {
            padding: 1rem;
        }

        .restaurant-meta {
            display: flex;
            gap: 1rem;
            margin: 0.5rem 0;
            color: #6b6b6b;
            font-size: 0.9rem;
        }

        .restaurant-meta i {
            color: #f97316;
            margin-right: 0.3rem;
        }

        .rating-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            background: #fff6ed;
            color: #f97316;
            padding: 0.2rem 0.8rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .rating-badge i {
            color: #f9b43a;
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
            margin-bottom: 1.5rem;
        }

        .back-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateX(-5px);
        }

        .back-btn i {
            color: #f97316;
        }

        .area-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .area-header h2 {
            margin-bottom: 0;
        }

        .area-header h2::after {
            display: none;
        }

        .area-badge {
            background: #fff6ed;
            color: #f97316;
            padding: 0.5rem 1.5rem;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            border: 1px solid #f97316;
        }

        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <div class="content" id="mainContent">
        <div class="container">
            <!-- Header with Back Button and Area -->
            <div class="area-header">
                <a href="javascript:history.back()" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <h2>Restaurants in</h2>
                <span class="area-badge"><i class="fas fa-map-marker-alt"></i> <%= area %></span>
            </div>

            <!-- Restaurant Grid -->
            <div id="restaurantGrid" class="grid"></div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            let area = "<%= area %>";
            const contextPath = "${pageContext.request.contextPath}";


            $("#restaurantGrid").html('<div class="loading">Finding restaurants in ' + area + '</div>');

            $.ajax({
                url: contextPath + "/customer/restaurants",
                method: "GET",
                data: { area: area },
                success: function (response) {
                    let restaurants = response.data;

                    if (!restaurants || restaurants.length === 0) {
                        $("#restaurantGrid").html('<div class="no-areas"><i class="fas fa-store"></i>No restaurants found in ' + area + '</div>');
                        return;
                    }

                    let html = "";

                    $.each(restaurants, function (i, r) {

                        const imageUrl = r.imageUrl || 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=600';


                        const rating = (Math.random() * 1.5 + 3.5).toFixed(1);

                        html += '<div class="card" data-id="' + r.id + '">' +
                                    '<div class="restaurant-image" style="background-image: linear-gradient(45deg, rgba(0,0,0,0.2), rgba(0,0,0,0.2)), url(\'' + imageUrl + '\');">' +
                                    '</div>' +
                                    '<div class="card-content">' +
                                        '<h3>' + r.name + '</h3>' +
                                        '<div class="restaurant-meta">' +
                                            '<span><i class="fas fa-map-marker-alt"></i> ' + r.area + '</span>' +
                                            '<span class="rating-badge"><i class="fas fa-star"></i> ' + rating + '</span>' +
                                        '</div>' +
                                        '<p><i class="fas fa-location-dot"></i> ' + (r.location || 'Location available') + '</p>' +
                                        '<span class="explore-badge"><i class="fas fa-utensils"></i> View Menu</span>' +
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


            $(document).on("click", ".card", function () {
                const restaurantId = $(this).attr("data-id");

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