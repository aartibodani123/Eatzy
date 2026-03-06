<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Management | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Eatzy Theme Menu Management CSS */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        body {
            background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
            min-height: 100vh;
        }

        /* Content with Sidebar Shift */
        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .page-header i {
            font-size: 2.5rem;
            color: #f97316;
            background: #fff6ed;
            padding: 1rem;
            border-radius: 50%;
        }

        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }

        .page-header h1::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
            margin-top: 0.5rem;
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
        }

        /* Form Cards */
        .form-card {
            background: white;
            border-radius: 2rem;
            padding: 2rem;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.15);
            border: 2px solid #eaeef2;
        }

        .form-card h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-card h2 i {
            color: #f97316;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select {
            width: 100%;
            padding: 1rem 1.2rem;
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 60px;
            font-size: 1rem;
            outline: none;
            transition: all 0.2s;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #f97316;
            background: white;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .form-group input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-right: 0.5rem;
            accent-color: #f97316;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
        }

        /* Helper Text */
        .helper-text {
            font-size: 0.85rem;
            color: #6b6b6b;
            margin-top: 0.3rem;
        }

        /* Buttons */
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 60px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
        }

        .btn-primary {
            background: #f97316;
            color: white;
            width: 100%;
            justify-content: center;
        }

        .btn-primary:hover {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .btn-primary i {
            font-size: 1.1rem;
        }

        /* Category Select Dropdown */
        #categorySelect {
            width: 100%;
            padding: 1rem 1.2rem;
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 60px;
            font-size: 1rem;
            outline: none;
            transition: all 0.2s;
            max-height: 200px;
            overflow-y: auto;
        }

        #categorySelect option {
            padding: 0.5rem;
        }

        /* Message Area */
        .message-area {
            margin-top: 2rem;
            padding: 1rem;
            border-radius: 60px;
            display: none;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease;
        }

        .message-area.success {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
            display: flex;
        }

        .message-area.error {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
            display: flex;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Loading State */
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #f0e4d5;
            border-top-color: #f97316;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .content {
                padding: 1rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<div class="content" id="mainContent">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <i class="fas fa-book-open"></i>
            <h1>Menu Management</h1>
        </div>

        <!-- Message Area -->
        <div id="message" class="message-area"></div>

        <!-- Form Grid -->
        <div class="form-grid">
            <!-- Add Category Form -->
            <div class="form-card">
                <h2><i class="fas fa-folder-plus"></i> Add Category</h2>
                <form id="addCategoryForm">
                    <div class="form-group">
                        <label>Restaurant ID</label>
                        <input type="number" id="catRestaurantId" placeholder="Enter restaurant ID" required />
                    </div>

                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" id="categoryName" placeholder="e.g. Starters, Main Course" required />
                    </div>

                    <div class="form-group">
                        <label>Category Description</label>
                        <input type="text" id="categoryDescription" placeholder="Brief description of category" required />
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle"></i> Add Category
                    </button>
                </form>
            </div>

            <!-- Add Menu Item Form -->
            <div class="form-card">
                <h2><i class="fas fa-utensils"></i> Add Menu Item</h2>
                <form id="addMenuItemForm">
                    <div class="form-group">
                        <label>Restaurant ID</label>
                        <input type="number" id="menuRestaurantId" placeholder="Enter restaurant ID" required />
                        <div class="helper-text">Enter restaurant ID to load categories</div>
                    </div>

                    <div class="form-group">
                        <label>Select Categories</label>
                        <select id="categorySelect" multiple size="4">
                            <option value="">Enter Restaurant ID first</option>
                        </select>
                        <div class="helper-text">Hold Ctrl/Cmd to select multiple categories</div>
                    </div>

                    <div class="form-group">
                        <label>Category IDs (comma separated)</label>
                        <input type="text" id="categoryIdsInput" placeholder="e.g. 1,2,5" required />
                        <div class="helper-text">Or enter category IDs manually</div>
                    </div>

                    <div class="form-group">
                        <label>Item Name</label>
                        <input type="text" id="itemName" placeholder="e.g. Paneer Butter Masala" required />
                    </div>

                    <div class="form-group">
                        <label>Price (₹)</label>
                        <input type="number" id="itemPrice" placeholder="e.g. 299" step="0.01" required />
                    </div>

                    <div class="form-group checkbox-group">
                        <input type="checkbox" id="available" checked />
                        <label for="available" style="display: inline; margin: 0;">Available for ordering</label>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus-circle"></i> Add Menu Item
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    const BASE_URL = "http://localhost:8080";

    function getToken() {
        return localStorage.getItem("token");
    }

    function showMessage(message, type) {
        const msgDiv = $('#message');
        msgDiv.removeClass('success error')
              .addClass(type)
              .html('<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + message)
              .show();

        setTimeout(() => {
            msgDiv.fadeOut();
        }, 5000);
    }

    // Load categories when restaurantId changes
    $(document).on("input", "#menuRestaurantId", function () {
        const restaurantId = parseInt($(this).val());

        if (!restaurantId) {
            $("#categorySelect").html('<option value="">Enter Restaurant ID first</option>');
            return;
        }

        // Show loading in select
        $("#categorySelect").html('<option value="">Loading categories...</option>');

        $.ajax({
            url: BASE_URL + "/restaurant/" + restaurantId + "/categories",
            type: "GET",
            xhrFields: {
                withCredentials: true
            },
            success: function (res) {
                const categories = res?.data || [];

                if (!categories.length) {
                    $("#categorySelect").html('<option value="">No categories found</option>');
                    return;
                }

                let options = '';
                categories.forEach(cat => {
                    options += `<option value="${cat.id}">${cat.name} (ID: ${cat.id})</option>`;
                });
                $("#categorySelect").html(options);
            },
            error: function (xhr) {
                console.error("Failed categories API:", xhr.status, xhr.responseText);
                $("#categorySelect").html('<option value="">Failed to load categories</option>');
                showMessage("Failed to load categories", "error");
            }
        });
    });

    // Add Category
    $("#addCategoryForm").submit(function (e) {
        e.preventDefault();

        const data = {
            name: $("#categoryName").val(),
            restaurantId: parseInt($("#catRestaurantId").val()),
            description: $("#categoryDescription").val()
        };

        const btn = $(this).find('button[type="submit"]');
        const originalText = btn.html();
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Adding...');

        $.ajax({
            url: BASE_URL + "/restaurant/add/category",
            type: "POST",
            contentType: "application/json",
            headers: {
                "Authorization": "Bearer " + getToken()
            },
            data: JSON.stringify(data),
            success: function (res) {
                showMessage(res.message || "Category added successfully!", "success");
                $("#categoryName").val("");
                $("#categoryDescription").val("");

                // Reload categories if the restaurant ID matches
                const menuRestId = $("#menuRestaurantId").val();
                if (menuRestId && parseInt(menuRestId) === data.restaurantId) {
                    $("#menuRestaurantId").trigger('input');
                }
            },
            error: function (xhr) {
                showMessage(xhr.responseJSON?.message || "Category add failed", "error");
            },
            complete: function() {
                btn.prop('disabled', false).html(originalText);
            }
        });
    });

    // Add Menu Item
    $("#addMenuItemForm").submit(function (e) {
        e.preventDefault();

        const rawCategoryIds = $("#categoryIdsInput").val().trim();
        const selectedOptions = $("#categorySelect").val();

        let categoryIds = [];

        // Use selected options from dropdown if available
        if (selectedOptions && selectedOptions.length > 0) {
            categoryIds = selectedOptions.map(id => parseInt(id));
        }
        // Otherwise use comma-separated input
        else if (rawCategoryIds) {
            categoryIds = rawCategoryIds
                .split(",")
                .map(id => id.trim())
                .filter(id => id !== "")
                .map(Number);
        }

        if (categoryIds.length === 0) {
            showMessage("Please select at least one category", "error");
            return;
        }

        if (categoryIds.some(isNaN)) {
            showMessage("Category IDs must be numbers only", "error");
            return;
        }

        const data = {
            name: $("#itemName").val(),
            price: parseFloat($("#itemPrice").val()),
            available: $("#available").is(":checked"),
            restaurantId: parseInt($("#menuRestaurantId").val()),
            categoryIds: categoryIds
        };

        const btn = $(this).find('button[type="submit"]');
        const originalText = btn.html();
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Adding...');

        $.ajax({
            url: BASE_URL + "/restaurant/add/MenuItem",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            xhrFields: { withCredentials: true },
            success: function (res) {
                showMessage(res.message || "Menu item added successfully!", "success");
                $("#itemName").val("");
                $("#itemPrice").val("");
                $("#categoryIdsInput").val("");
                $("#available").prop('checked', true);
            },
            error: function (xhr) {
                showMessage(xhr.responseJSON?.message || "Menu item add failed", "error");
            },
            complete: function() {
                btn.prop('disabled', false).html(originalText);
            }
        });
    });

    // Sidebar toggle functionality
    document.addEventListener("DOMContentLoaded", function() {
        const hamburger = document.getElementById("hamburgerBtn");
        const sidebar = document.getElementById("sidebar");
        const mainContent = document.getElementById("mainContent");

        if (hamburger && sidebar && mainContent) {
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
        }
    });
</script>

</body>
</html>