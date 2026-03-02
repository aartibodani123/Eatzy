<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h2>Add Category</h2>
<form id="addCategoryForm">
    <input type="number" id="catRestaurantId" placeholder="Restaurant ID" required />
    <input type="text" id="categoryName" placeholder="Category Name" required />
    <input type="text" id="categoryDescription" placeholder="Category Description" required />
    <button type="submit">Add Category</button>
</form>

<hr>

<h2>Add Menu Item</h2>
<form id="addMenuItemForm">
    <input type="number" id="menuRestaurantId" placeholder="Restaurant ID" required />
<label>Category IDs (comma separated)</label><br>
<input type="text" id="categoryIdsInput" placeholder="e.g. 1,2,5" required />
    <br><br>
    <input type="text" id="itemName" placeholder="Item Name" required />
    <input type="number" id="itemPrice" placeholder="Price" required />

    <label>
        <input type="checkbox" id="available" checked /> Available
    </label>

    <br><br>
    <button type="submit">Add Menu Item</button>
</form>

<script>
    const BASE_URL = "http://localhost:8080";

    function getToken() {
        return localStorage.getItem("token");
    }

    // Load categories when restaurantId changes
    $(document).on("input", "#menuRestaurantId", function () {
        const restaurantId = parseInt($(this).val());

        console.log("Selected restaurant:", restaurantId);
        console.log("BASE_URL:", BASE_URL);
        console.log(`${BASE_URL}/restaurant/${restaurantId}/categories`);
        console.log("BASE_URL:", BASE_URL);

        if (!restaurantId) {
            $("#categorySelect").html(`<option value="">Select Category</option>`);
            return;
        }

        $.ajax({
            url: BASE_URL + "/restaurant/" + restaurantId + "/categories",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {
                console.log("Categories API response:", res);

                const categories = res?.data || [];
                console.log("First data ");

                console.log(res.data[0]);
                $("#categorySelect").empty();
                console.log("categories array", categories);

                if (!categories.length) {
                    $("#categorySelect").append(`<option value="">No categories found</option>`);
                    return;
                }

                categories.forEach(cat => {
                    $("#categorySelect").append(
                        `<option value="${cat.id}">${cat.name}</option>`
                    );
                });
                console.log("options added", $("#categorySelect").html());
            },
            error: function (xhr) {
                console.error("Failed categories API:", xhr.status, xhr.responseText);
                alert("Failed to load categories");
            }
        });
    });

    // Add Category
    $("#addCategoryForm").submit(function (e) {
        e.preventDefault();

        const data = {
            name: $("#categoryName").val(),
            restaurantId: $("#catRestaurantId").val(),
            description: $("#categoryDescription").val()
        };

        $.ajax({
            url: BASE_URL + "/restaurant/add/category",
            type: "POST",
            contentType: "application/json",
            headers: {
                "Authorization": "Bearer " + getToken()
            },
            data: JSON.stringify(data),
            success: function (res) {
                alert(res.message);
                $("#categoryName").val("");
            },
            error: function () {
                alert("Category add failed");
            }
        });
    });

    // Add Menu Item
$("#addMenuItemForm").submit(function (e) {
    e.preventDefault();

    const rawCategoryIds = $("#categoryIdsInput").val().trim();

    if (!rawCategoryIds) {
        alert("Please enter at least one category ID");
        return;
    }

    const categoryIds = rawCategoryIds
        .split(",")
        .map(id => id.trim())
        .filter(id => id !== "")
        .map(Number);

    if (categoryIds.some(isNaN)) {
        alert("Category IDs must be numbers only");
        return;
    }

    const data = {
        name: $("#itemName").val(),
        price: parseFloat($("#itemPrice").val()),
        available: $("#available").is(":checked"),
        restaurantId: parseInt($("#menuRestaurantId").val()),
        categoryIds: categoryIds
    };

    $.ajax({
        url: BASE_URL + "/restaurant/add/MenuItem", // make sure case matches backend
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(data),
        xhrFields: { withCredentials: true },
        success: function (res) {
            alert(res.message);
            $("#itemName").val("");
            $("#itemPrice").val("");
            $("#categoryIdsInput").val("");
        },
        error: function (xhr) {
            alert(xhr.responseJSON?.message || "Menu item add failed");
        }
    });
});
</script>

</body>
</html>