<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Restaurant</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<h2>Add Restaurant</h2>
<form id="addRestaurantForm">
    <input type="text" name="name" placeholder="Restaurant Name" required/>
    <input type="text" name="area" placeholder="area" required/>
    <input type="text" name="location" placeholder="Address" required/>
    <input type="text" name="phone" placeholder="Contact No" required/>
    <button type="submit"> Submit for Approval</button>
</form>

<p id="message"></p>
<script>
    $("#addRestaurantForm").on("submit", function (e) {
        e.preventDefault();

        const formData = {
            name: $("input[name='name']").val(),
            area: $("input[name='area']").val(),
            phone: $("input[name='phone']").val(),
            location: $("input[name='location']").val()
        };

        $.ajax({
            url: "/restaurant/addRestaurant",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function (response) {
                $("#message").css("color", "green").text("Restaurant request submitted. Awaiting admin approval.");
                $("#addRestaurantForm")[0].reset();
            },
            error: function (xhr) {
                let msg = "Something went wrong";
                if (xhr.status === 403) msg = "You are not authorized to add a restaurant.";
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    msg = xhr.responseJSON.message;
                }
                $("#message").css("color", "red").text(msg);
            }
        });
    });
</script>
</body>
</html>