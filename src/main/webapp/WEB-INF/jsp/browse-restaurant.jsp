<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Restaurants</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/browse-restaurants.css">
</head>
<body>

<div class="container">
    <h2>Browse Restaurants</h2>
    <p>Select your area</p>

    <div id="areasGrid" class="grid"></div>
</div>

<script>
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
            html += '<div class="card" data-area="' + area + '">' +
                    '<h3>' + area + '</h3>' +
                    '<p>Explore Restaurants</p>' +
                    '</div>';
            });

            $("#areasGrid").html(html);
        },
        error: function () {
            alert("Failed to load areas");
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