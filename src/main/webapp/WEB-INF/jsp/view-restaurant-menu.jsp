<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String restaurantId = String.valueOf(request.getParameter("restaurantId"));
%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/jsp/area-restaurants.jsp">← Back</a>

    <h2>Restaurant Menu</h2>
    <div id="menuGrid"></div>
</div>

<script>
$(document).ready(function () {
    const restaurantId = "<%= restaurantId %>";
    const contextPath = "${pageContext.request.contextPath}";

    $.ajax({
        url: contextPath + "/customer/restaurants/" + restaurantId + "/menu",
        method: "GET",
        success: function(response) {
            const menuItems = response.data;
            let html = "";

            $.each(menuItems, function(i, item) {
                html += '<div class="card">' +
                        '<h3>' + item.name + '</h3>' +
                        '<p>Price: ' + item.price + '</p>' +
                        '<p>' + (item.description || '') + '</p>' +
                        '</div>';
            });

            $("#menuGrid").html(html);
        },
        error: function() {
            alert("Failed to load menu");
        }
    });
});
</script>
</body>
</html>