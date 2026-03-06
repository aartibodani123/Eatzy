<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Restaurants | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
    <style>
        /* Additional styles for sidebar shifting (add to your CSS file or keep here) */
        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
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

        $(document).ready(function () {
            const contextPath = "${pageContext.request.contextPath}";

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
        });

        // Card click handler
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
            // Small delay to ensure sidebar is loaded from include
            setTimeout(initSidebarToggle, 100);
        });
    </script>
</body>
</html>