<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String area = request.getParameter("area");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurants in <%= area %></title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
</head>
<body>

<div class="container">
    <a href="browseAreas.jsp">← Back</a>
    <h2>Restaurants in <%= area %></h2>

    <div id="restaurantGrid" class="grid"></div>
</div>

<script>
$(document).ready(function () {
    let area = "<%= area %>";

    $.ajax({
        url: "${pageContext.request.contextPath}/customer/restaurants",
        method: "GET",
        data: { area: area },
        success: function (response) {
            let restaurants = response.data;

            let html = "";
            $.each(restaurants, function (i, r) {
                 html += '<div class="card" data-id="' + r.id + '">' +
                         '<img src="' + (r.imageUrl || "images/food.jpg") + '" />' +
                         '<h3>' + r.name + '</h3>' +
                         '<p>' + r.area + '</p>' +
                         '<p>' + r.location + '</p>' +
                         '</div>';
            });
            $("#restaurantGrid").html(html);
        },
        error: function () {
            alert("Failed to load restaurants");
        }
    });
    $(document).on("click", ".card", function () {
        const restaurantId = $(this).attr("data-id");

        if (!restaurantId) {
            alert("Invalid restaurant");
            return;
        }

        window.location.href =
            "${pageContext.request.contextPath}/customer/view-restaurant-menu?restaurantId=" +
            encodeURIComponent(restaurantId);
    });
});
</script>

</body>
</html>