<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu Management | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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

        /* Toggle Buttons */
        .category-toggle {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #eaeef2;
            padding-bottom: 0.5rem;
        }

        .toggle-btn {
            background: none;
            border: none;
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            color: #6b6b6b;
            transition: all 0.2s;
            border-radius: 8px;
        }

        .toggle-btn.active {
            color: #f97316;
            background: #fff6ed;
        }

        .toggle-btn:hover {
            color: #f97316;
        }

        /* Category Sections */
        .category-section {
            display: none;
        }

        .category-section.active {
            display: block;
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
        .form-group select,
        .form-group input[type="file"],
        .form-group textarea {
            width: 100%;
            padding: 1rem 1.2rem;
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 60px;
            font-size: 1rem;
            outline: none;
            transition: all 0.2s;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        .form-group textarea {
            border-radius: 24px;
            resize: vertical;
            min-height: 80px;
        }

        .form-group input[type="file"] {
            padding: 0.8rem 1.2rem;
            cursor: pointer;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
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

        /* Image Preview */
        .image-preview {
            margin-top: 1rem;
            display: none;
        }

        .image-preview img {
            max-width: 100%;
            max-height: 200px;
            border-radius: 1rem;
            border: 2px solid #eaeef2;
            padding: 0.5rem;
            background: #f9f9fb;
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

        .btn-primary:disabled {
            background: #ffb085;
            cursor: not-allowed;
            transform: none;
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

        /* Manual Category Input */
        .category-input-group {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .category-input-group input {
            flex: 1;
        }

        .btn-add-category {
            padding: 1rem 1.5rem;
            background: #f97316;
            color: white;
            border: none;
            border-radius: 60px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-add-category:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .category-list {
            margin-top: 1rem;
            border: 2px solid #eaeef2;
            border-radius: 1rem;
            padding: 1rem;
            background: #f9f9fb;
        }

        .category-list h4 {
            font-size: 0.9rem;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
        }

        .category-items {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .category-tag {
            background: #fff6ed;
            color: #f97316;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid #ffd9b5;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .category-tag .remove-category {
            cursor: pointer;
            font-size: 1rem;
            color: #f97316;
            font-weight: bold;
            margin-left: 0.3rem;
        }

        .category-tag .remove-category:hover {
            color: #e85d0e;
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

        /* Selected Categories Tags */
        .selected-categories {
            margin-top: 0.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        /* Character Count */
        .char-count {
            text-align: right;
            font-size: 0.75rem;
            color: #6b6b6b;
            margin-top: 0.3rem;
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

            .category-input-group {
                flex-direction: column;
            }

            .btn-add-category {
                justify-content: center;
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

            <!-- Add Menu Item Form with Image Upload -->
            <div class="form-card">
                <h2><i class="fas fa-utensils"></i> Add Menu Item</h2>
                <form id="addMenuItemForm" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>Restaurant ID *</label>
                        <input type="number" id="restaurantId" name="restaurantId" placeholder="Enter restaurant ID" required />
                        <div class="helper-text">Enter restaurant ID to load categories</div>
                    </div>

                    <!-- Category Selection Toggle -->
                    <div class="category-toggle">
                        <button type="button" class="toggle-btn active" data-mode="dropdown">
                            <i class="fas fa-list"></i> Select from List
                        </button>
                        <button type="button" class="toggle-btn" data-mode="manual">
                            <i class="fas fa-keyboard"></i> Enter Manually
                        </button>
                    </div>

                    <!-- Dropdown Selection Mode -->
                    <div id="dropdownMode" class="category-section active">
                        <div class="form-group">
                            <label>Select Categories *</label>
                            <select id="categorySelect" multiple size="4">
                                <option value="">Enter Restaurant ID first</option>
                            </select>
                            <div class="helper-text">Hold Ctrl/Cmd to select multiple categories</div>
                            <div id="selectedCategoriesDisplay" class="selected-categories"></div>
                        </div>
                    </div>

                    <!-- Manual Entry Mode -->
                    <div id="manualMode" class="category-section">
                        <div class="form-group">
                            <label>Add Category IDs *</label>
                            <div class="category-input-group">
                                <input type="number" id="manualCategoryId" placeholder="Enter category ID (e.g., 1, 2, 3)" />
                                <button type="button" id="addCategoryBtn" class="btn-add-category">
                                    <i class="fas fa-plus"></i> Add Category ID
                                </button>
                            </div>
                            <div class="helper-text">Enter category IDs manually (must exist in the system)</div>

                            <div id="manualCategoryList" style="display: none;">
                                <div class="category-list">
                                    <h4><i class="fas fa-tags"></i> Selected Categories:</h4>
                                    <div id="manualCategoriesContainer" class="category-items"></div>
                                </div>
                            </div>
                            <input type="hidden" id="manualCategoryIds" name="categoryIds" value="" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Item Name *</label>
                        <input type="text" id="name" name="name" placeholder="e.g. Paneer Butter Masala" required />
                    </div>

                    <div class="form-group">
                        <label>Price (₹) *</label>
                        <input type="number" id="price" name="price" placeholder="e.g. 299" step="0.01" required />
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea id="description" name="description" rows="3" placeholder="Describe the item (e.g., ingredients, serving size, special instructions)" maxlength="500"></textarea>
                        <div class="helper-text">Brief description of the menu item (optional, max 500 characters)</div>
                        <div class="char-count">
                            <span id="charCount">0</span>/500 characters
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Item Image</label>
                        <input type="file" id="imageFile" name="imageFile" accept="image/jpeg,image/png,image/jpg,image/gif" />
                        <div class="helper-text">Upload image for the menu item (JPEG, PNG, JPG, GIF)</div>
                        <div class="image-preview" id="imagePreview">
                            <img id="previewImage" src="#" alt="Preview">
                        </div>
                    </div>

                    <div class="form-group checkbox-group">
                        <input type="checkbox" id="available" name="available" checked />
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
    let selectedManualCategories = [];

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

    // Character count for description
    $("#description").on('input', function() {
        const length = $(this).val().length;
        $("#charCount").text(length);
        if (length > 500) {
            $(this).val($(this).val().substring(0, 500));
            $("#charCount").text(500);
            showMessage("Description cannot exceed 500 characters", "error");
        }
    });

    // Toggle between dropdown and manual modes
    $(".toggle-btn").click(function() {
        const mode = $(this).data("mode");

        // Update active state
        $(".toggle-btn").removeClass("active");
        $(this).addClass("active");

        // Show appropriate section
        $(".category-section").removeClass("active");
        if (mode === "dropdown") {
            $("#dropdownMode").addClass("active");
        } else {
            $("#manualMode").addClass("active");
            // Refresh display when switching to manual mode
            updateManualCategoriesDisplay();
        }
    });

    // Image preview functionality
    $("#imageFile").change(function() {
        const file = this.files[0];
        if (file) {
            // Validate file type
            const validTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                showMessage("Please select a valid image file (JPEG, PNG, JPG, GIF)", "error");
                $(this).val("");
                return;
            }

            // Validate file size (max 5MB)
            if (file.size > 5 * 1024 * 1024) {
                showMessage("Image size should be less than 5MB", "error");
                $(this).val("");
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                $("#previewImage").attr("src", e.target.result);
                $("#imagePreview").show();
            };
            reader.readAsDataURL(file);
        } else {
            $("#imagePreview").hide();
            $("#previewImage").attr("src", "#");
        }
    });

    // Display selected categories from dropdown
    function updateSelectedCategoriesDisplay() {
        const selectedOptions = $("#categorySelect option:selected");
        const displayDiv = $("#selectedCategoriesDisplay");

        if (selectedOptions.length > 0 && selectedOptions[0].value !== "") {
            let tags = '';
            selectedOptions.each(function() {
                const categoryId = $(this).val();
                const categoryName = $(this).text().split(' (ID:')[0];
                tags += `<span class="category-tag">${categoryName} (ID: ${categoryId})</span>`;
            });
            displayDiv.html(tags);
            displayDiv.show();
        } else {
            displayDiv.hide();
            displayDiv.html('');
        }
    }

    // Manual category management
    function updateManualCategoriesDisplay() {
        const container = $("#manualCategoriesContainer");
        console.log("Updating manual categories display. Current array:", selectedManualCategories);

        if (selectedManualCategories.length > 0) {
            $("#manualCategoryList").show();
            let tags = '';
            selectedManualCategories.forEach(catId => {
                tags += `
                    <span class="category-tag">
                        Category ID: ${catId}
                        <span class="remove-category" data-id="${catId}">&times;</span>
                    </span>
                `;
            });
            container.html(tags);
            $("#manualCategoryIds").val(selectedManualCategories.join(','));
            console.log("Manual category IDs saved:", $("#manualCategoryIds").val());
        } else {
            $("#manualCategoryList").hide();
            $("#manualCategoryIds").val('');
        }

        // Add remove event listeners
        $(".remove-category").off('click').on('click', function() {
            const id = parseInt($(this).data("id"));
            console.log("Removing category ID:", id);
            selectedManualCategories = selectedManualCategories.filter(catId => catId !== id);
            updateManualCategoriesDisplay();
            showMessage(`Category ID ${id} removed`, "success");
        });
    }

    // Add manual category
    $("#addCategoryBtn").click(function() {
        const categoryIdInput = $("#manualCategoryId").val();
        const categoryId = parseInt(categoryIdInput);

        console.log("Add button clicked. Input value:", categoryIdInput, "Parsed ID:", categoryId);

        if (!categoryIdInput || categoryIdInput.trim() === "") {
            showMessage("Please enter a category ID", "error");
            return;
        }

        if (isNaN(categoryId)) {
            showMessage("Please enter a valid number for category ID", "error");
            return;
        }

        if (categoryId <= 0) {
            showMessage("Please enter a positive category ID", "error");
            return;
        }

        if (selectedManualCategories.includes(categoryId)) {
            showMessage(`Category ID ${categoryId} is already added`, "error");
            return;
        }

        // Add the category ID
        selectedManualCategories.push(categoryId);
        console.log("Added category ID:", categoryId, "Updated array:", selectedManualCategories);

        // Update display
        updateManualCategoriesDisplay();

        // Clear input
        $("#manualCategoryId").val("");

        // Show success message
        showMessage(`Category ID ${categoryId} added successfully`, "success");
    });

    // Allow pressing Enter key to add category
    $("#manualCategoryId").keypress(function(e) {
        if (e.which === 13) { // Enter key
            e.preventDefault();
            $("#addCategoryBtn").click();
        }
    });

    // Load categories when restaurantId changes
    $(document).on("input", "#restaurantId", function () {
        const restaurantId = parseInt($(this).val());

        if (!restaurantId || isNaN(restaurantId)) {
            $("#categorySelect").html('<option value="">Enter Restaurant ID first</option>');
            $("#selectedCategoriesDisplay").hide();
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
                    $("#categorySelect").html('<option value="">No categories found for this restaurant</option>');
                    return;
                }

                let options = '';
                categories.forEach(cat => {
                    options += `<option value="${cat.id}">${cat.name} (ID: ${cat.id})</option>`;
                });
                $("#categorySelect").html(options);

                // Add change event listener to update display
                $("#categorySelect").off('change').on('change', updateSelectedCategoriesDisplay);
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

        const restaurantId = parseInt($("#catRestaurantId").val());
        if (!restaurantId || isNaN(restaurantId)) {
            showMessage("Please enter a valid Restaurant ID", "error");
            return;
        }

        const data = {
            name: $("#categoryName").val().trim(),
            restaurantId: restaurantId,
            description: $("#categoryDescription").val().trim()
        };

        if (!data.name || !data.description) {
            showMessage("Please fill all fields", "error");
            return;
        }

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
                const menuRestId = $("#restaurantId").val();
                if (menuRestId && parseInt(menuRestId) === data.restaurantId) {
                    $("#restaurantId").trigger('input');
                }
            },
            error: function (xhr) {
                const errorMsg = xhr.responseJSON?.message || "Category add failed";
                showMessage(errorMsg, "error");
            },
            complete: function() {
                btn.prop('disabled', false).html(originalText);
            }
        });
    });

    // Add Menu Item with Image Upload
    $("#addMenuItemForm").submit(function (e) {
        e.preventDefault();

        // Get common values
        const restaurantId = parseInt($("#restaurantId").val());
        const name = $("#name").val().trim();
        const price = parseFloat($("#price").val());
        const description = $("#description").val().trim();
        const available = $("#available").is(":checked");
        const imageFile = $("#imageFile")[0].files[0];

        let categoryIds = [];

        // Determine which mode is active
        const activeMode = $(".toggle-btn.active").data("mode");

        console.log("Active mode:", activeMode);

        if (activeMode === "dropdown") {
            // Get categories from dropdown
            const selectedOptions = $("#categorySelect").val();
            console.log("Selected options from dropdown:", selectedOptions);

            if (!selectedOptions || selectedOptions.length === 0 || selectedOptions[0] === "" || selectedOptions[0] === "Enter Restaurant ID first") {
                showMessage("Please select at least one category from the list", "error");
                return;
            }
            categoryIds = selectedOptions.map(id => parseInt(id));
            console.log("Category IDs from dropdown:", categoryIds);
        } else {
            // Get categories from manual entry
            console.log("Manual categories array:", selectedManualCategories);
            console.log("Manual categories hidden field value:", $("#manualCategoryIds").val());

            if (selectedManualCategories.length === 0) {
                showMessage("Please add at least one category ID manually", "error");
                return;
            }
            categoryIds = selectedManualCategories;
            console.log("Category IDs from manual entry:", categoryIds);
        }

        // Validate restaurant ID
        if (!restaurantId || isNaN(restaurantId)) {
            showMessage("Please enter a valid Restaurant ID", "error");
            return;
        }

        // Validate name
        if (!name) {
            showMessage("Please enter item name", "error");
            return;
        }

        // Validate price
        if (isNaN(price) || price <= 0) {
            showMessage("Please enter a valid price", "error");
            return;
        }

        // Validate description length
        if (description.length > 500) {
            showMessage("Description cannot exceed 500 characters", "error");
            return;
        }

        // Create FormData - field names must match MenuItemRequest DTO
        const formData = new FormData();
        formData.append("restaurantId", restaurantId);
        formData.append("name", name);
        formData.append("price", price);
        formData.append("available", available);

        // Add description if provided
        if (description) {
            formData.append("description", description);
        }

        // Append each category ID - this will bind to List<Long> categoryIds in MenuItemRequest
        for (let i = 0; i < categoryIds.length; i++) {
            formData.append("categoryIds", categoryIds[i]);
        }

        // Append image if selected
        if (imageFile) {
            formData.append("imageFile", imageFile);
        }

        const btn = $(this).find('button[type="submit"]');
        const originalText = btn.html();
        btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Adding...');

        // Log the data being sent for debugging
        console.log("=== Sending Form Data ===");
        console.log("Mode:", activeMode);
        console.log("Restaurant ID:", restaurantId);
        console.log("Name:", name);
        console.log("Price:", price);
        console.log("Description:", description || "(empty)");
        console.log("Available:", available);
        console.log("Category IDs:", categoryIds);
        console.log("Has Image:", imageFile ? `Yes - ${imageFile.name} (${imageFile.type}, ${imageFile.size} bytes)` : "No");

        for (let pair of formData.entries()) {
            if (pair[0] === "imageFile") {
                console.log(pair[0] + ': [File] ' + (pair[1] ? pair[1].name : 'null'));
            } else {
                console.log(pair[0] + ': ' + pair[1]);
            }
        }

        $.ajax({
            url: BASE_URL + "/restaurant/image/addMenuItem",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            headers: {
                "Authorization": "Bearer " + getToken()
            },
            success: function (res) {
                showMessage(res.message || "Menu item added successfully!", "success");
                // Reset form fields
                $("#name").val("");
                $("#price").val("");
                $("#description").val("");
                $("#charCount").text("0");
                $("#available").prop('checked', true);
                $("#imageFile").val("");
                $("#imagePreview").hide();
                $("#previewImage").attr("src", "#");

                // Reset category selections
                if (activeMode === "dropdown") {
                    $("#categorySelect").val([]);
                    updateSelectedCategoriesDisplay();
                } else {
                    selectedManualCategories = [];
                    updateManualCategoriesDisplay();
                    $("#manualCategoryId").val("");
                }
            },
            error: function (xhr) {
                console.error("Error response:", xhr);
                let errorMessage = "Menu item add failed";
                if (xhr.responseJSON) {
                    errorMessage = xhr.responseJSON.message || errorMessage;
                } else if (xhr.responseText) {
                    try {
                        const response = JSON.parse(xhr.responseText);
                        errorMessage = response.message || errorMessage;
                    } catch(e) {
                        errorMessage = xhr.statusText || errorMessage;
                    }
                }
                showMessage(errorMessage, "error");
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

        // Initialize manual categories display
        updateManualCategoriesDisplay();
    });
</script>

</body>
</html>