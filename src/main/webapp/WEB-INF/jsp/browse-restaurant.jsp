<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Restaurants | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
</head>
<body>

<div class="container">
    <h2>Browse Restaurants</h2>
    <p>Select your area</p>

    <div id="areasGrid" class="grid"></div>
</div>

<script>
// Indian areas/cities with relevant images from Unsplash India collection
// Ahmedabad areas with unique, reliable images
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
    // Ahmedabad
    'Bodakdev': '450+',
    'Navrangpura': '380+',
    'Satellite': '520+',
    'Vastrapur': '410+',
    'CG Road': '320+',
    'Paldi': '280+',
    'Maninagar': '350+'
};

// Default image for areas not in the list (Indian street food theme)
const defaultImage = 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80';

$(document).ready(function () {
    const contextPath = "${pageContext.request.contextPath}";

    $.ajax({
        url: contextPath + "/customer/getAreas",
        method: "GET",
        success: function (response) {
            let areas = response.data;
            console.log("areas", areas);

            let html = "";

            areas.forEach(function(area) {
                // Clean area name for lookup (remove extra spaces)
                const trimmedArea = area.trim();
                const imageUrl = areaImages[trimmedArea] || defaultImage;
                const count = restaurantCounts[trimmedArea] || '300+';

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
        error: function () {
            $("#areasGrid").html('<div class="error-message"><i class="fas fa-exclamation-circle"></i>Failed to load areas. Please try again.</div>');
        }
    });
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
</script>

</body>
</html>