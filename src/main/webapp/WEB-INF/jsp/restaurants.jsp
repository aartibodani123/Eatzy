<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String area = request.getParameter("area");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurants in <%= area %></title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
    <style>
        .toast-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #b34033;
            color: white;
            padding: 1rem 2rem;
            border-radius: 40px;
            box-shadow: 0 10px 25px -8px rgba(0,0,0,0.3);
            z-index: 10001;
            animation: slideIn 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <a href="browseAreas.jsp">← Back</a>
    <h2>Restaurants in <%= area %></h2>

    <div id="restaurantGrid" class="grid"></div>
</div>

<script>
function showToast(message) {
    const toast = $('<div class="toast-message"></div>')
        .html('<i class="fas fa-exclamation-circle"></i> ' + message)
        .css({
            position: 'fixed',
            top: '20px',
            right: '20px',
            background: '#b34033',
            color: 'white',
            padding: '1rem 2rem',
            borderRadius: '40px',
            boxShadow: '0 10px 25px -8px rgba(0,0,0,0.3)',
            zIndex: 10001,
            animation: 'slideIn 0.3s ease',
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem',
            fontWeight: '500'
        });

    $('body').append(toast);

    setTimeout(() => {
        toast.fadeOut(300, function() {
            $(this).remove();
        });
    }, 3000);
}

$(document).ready(function () {
    let area = "<%= area %>";

    $.ajax({
        url: "/customer/restaurants",
        method: "GET",
        data: { area: area },
        success: function (response) {
            let restaurants = response.data;

            let html = "";
            $.each(restaurants, function (i, r) {
            html += '<div class="card" data-id="' + r.id + '">' +
                    '<img src="' + (r.imageUrl || 'images/food.jpg') + '" />' +
                    '<h3>' + r.name + '</h3>' +
                    '<p>' + r.area + '</p>' +
                    '<p>' + r.location + '</p>' +
                    '</div>';
            });
            $("#restaurantGrid").html(html);
        },
        error: function () {
            showToast("Failed to load restaurants");
        }
    });
});

$(document).on("click", ".card", function () {
    const restaurantId = $(this).attr("data-id");

    if (!restaurantId) {
        showToast("Invalid restaurant");
        return;
    }

    window.location.href =
        "${pageContext.request.contextPath}/customer/restaurant-menu?restaurantId=" +
        encodeURIComponent(restaurantId);
});
</script>

</body>
</html>