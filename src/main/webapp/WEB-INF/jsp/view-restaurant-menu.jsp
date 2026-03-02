<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String restaurantId = String.valueOf(request.getParameter("restaurantId"));
%>
<!DOCTYPE html>
<html>
<head>
    <style>
            .card {
                border: 1px solid #ddd;
                padding: 12px;
                margin: 10px;
                width: 200px;
                display: inline-block;
                border-radius: 6px;
            }
            .btn {
                background: #ff6b6b;
                color: white;
                border: none;
                padding: 6px 10px;
                cursor: pointer;
                border-radius: 4px;
            }
    </style>
    <title>Menu</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/jsp/area-restaurants.jsp">← Back</a>

    <h2>Restaurant Menu</h2>
    <div id="message" style="margin:10px 0; font-weight:bold;"></div>
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
                '<p>Price: ₹' + item.price + '</p>' +
                '<p>' + (item.description || '') + '</p>' +
                '<button class="btn add-to-cart" ' +
                'data-restaurant-id="' + restaurantId + '" ' +
                'data-menu-item-id="' + item.id + '">' +
                'Add to Cart 🛒' +
                '</button>' +
                '</div>';
            });

            $("#menuGrid").html(html);
        },
        error: function() {
            alert("Failed to load menu");
        }
    });
    $(document).on("click", ".add-to-cart", function () {
        const btn = $(this);
        const restaurantId = btn.data("restaurant-id");
        const menuItemId = btn.data("menu-item-id");

        const token = sessionStorage.getItem("jwt");

        if (!token) {
            window.location.href = "${pageContext.request.contextPath}/login";
            return;
        }

        $.ajax({
            url: contextPath + "/customer/cart/add",
            method: "POST",
            headers: {
                "Authorization": "Bearer " + token
            },
            contentType: "application/json",
            data: JSON.stringify({ restaurantId, menuItemId }),
            success: function(res) {
                $("#message").text(res.message).css("color", "green");
                btn.text("Added ✅").prop("disabled", true);
            },
            error: function(xhr) {
                if (xhr.status === 401) {
                    sessionStorage.removeItem("jwt");
                    window.location.href = contextPath + "/login";
                    return;
                }
                const msg = xhr.responseJSON?.message || "Failed to add to cart";
                $("#message").text(msg).css("color", "red");
            }
        });
    });
});

</script>
</body>
</html>