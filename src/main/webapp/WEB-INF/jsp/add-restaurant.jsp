<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Restaurant | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

        .container {
            max-width: 600px;
            margin: 0 auto;
        }

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

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
        }

        .form-group label i {
            color: #f97316;
            margin-right: 0.5rem;
        }

        .form-group input {
            width: 100%;
            padding: 1rem 1.2rem;
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 60px;
            font-size: 1rem;
            outline: none;
            transition: all 0.2s;
            color: #1e1e1e;
        }

        .form-group input:focus {
            border-color: #f97316;
            background: white;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .form-group input::placeholder {
            color: #9ca3af;
            font-weight: 400;
        }

        .image-upload-group {
            margin-bottom: 1.5rem;
        }

        .image-upload-group label {
            display: block;
            font-weight: 600;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
        }

        .image-upload-group label i {
            color: #f97316;
            margin-right: 0.5rem;
        }

        .file-input-wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .file-input-wrapper input[type="file"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
            z-index: 2;
        }

        .file-input-label {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem 1.2rem;
            background: #f9f9fb;
            border: 2px dashed #eaeef2;
            border-radius: 60px;
            cursor: pointer;
            transition: all 0.2s;
            color: #6b6b6b;
        }

        .file-input-label i {
            font-size: 1.2rem;
            color: #f97316;
        }

        .file-input-label span {
            flex: 1;
        }

        .file-input-wrapper:hover .file-input-label {
            border-color: #f97316;
            background: #fff6ed;
        }

        .image-preview {
            margin-top: 1rem;
            display: none;
            position: relative;
            border-radius: 1rem;
            overflow: hidden;
            background: #f9f9fb;
            border: 2px solid #eaeef2;
        }

        .image-preview img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            display: block;
        }

        .remove-image {
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            border: none;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .remove-image:hover {
            background: #f97316;
            transform: scale(1.05);
        }

        .image-preview.active {
            display: block;
        }

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
            margin-top: 0.5rem;
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .btn-primary:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .btn-primary i {
            font-size: 1.1rem;
        }

        .btn-primary:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .message-area {
            margin-top: 1.5rem;
            padding: 1rem;
            border-radius: 60px;
            display: none;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease;
            font-weight: 500;
        }

        .message-area.success {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
            display: flex;
        }

        .message-area.warning {
            background: #fff9e6;
            color: #b37400;
            border: 1px solid #ffe8b3;
            display: flex;
        }

        .message-area.error {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
            display: flex;
        }

        .message-area i {
            font-size: 1.2rem;
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

        .helper-text {
            font-size: 0.85rem;
            color: #6b6b6b;
            margin-top: 0.5rem;
            text-align: center;
        }

        .helper-text i {
            color: #f97316;
            margin-right: 0.3rem;
        }

        @media (max-width: 768px) {
            .content {
                padding: 1rem;
            }
            .content.shift {
                margin-left: 0;
            }
            .page-header h1 {
                font-size: 1.8rem;
            }
            .form-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<div class="content" id="mainContent">
    <div class="container">
        <div class="page-header">
            <i class="fas fa-store"></i>
            <h1>Add Restaurant</h1>
        </div>

        <div class="form-card">
            <h2><i class="fas fa-plus-circle"></i> Restaurant Details</h2>

            <form id="addRestaurantForm">
                <div class="form-group">
                    <label><i class="fas fa-utensils"></i> Restaurant Name</label>
                    <input type="text" name="name" placeholder="e.g. The Spice Kitchen" required/>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-map-marker-alt"></i> Area</label>
                    <input type="text" name="area" placeholder="e.g. Bodakdev, Navrangpura" required/>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-location-dot"></i> Full Address</label>
                    <input type="text" name="location" placeholder="Street, building, landmark" required/>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-phone"></i> Contact Number</label>
                    <input type="text" name="phone" placeholder="e.g. +91 98765 43210" required/>
                </div>

                <div class="image-upload-group">
                    <label><i class="fas fa-image"></i> Restaurant Image (Optional)</label>
                    <div class="file-input-wrapper">
                        <input type="file" id="restaurantImage" name="image" accept="image/*"/>
                        <div class="file-input-label">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <span>Choose an image...</span>
                            <i class="fas fa-chevron-down" style="font-size: 0.9rem;"></i>
                        </div>
                    </div>
                    <div id="imagePreview" class="image-preview">
                        <img id="previewImg" src="" alt="Preview"/>
                        <button type="button" class="remove-image" id="removeImageBtn">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane"></i> Submit for Approval
                </button>
            </form>

            <div id="message" class="message-area"></div>

            <div class="helper-text">
                <i class="fas fa-info-circle"></i>
                Your restaurant will be reviewed by admin before being published
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Sidebar toggle functionality
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

        // Image preview functionality
        let selectedFile = null;

        $('#restaurantImage').on('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
                if (!validTypes.includes(file.type)) {
                    showMessage("Invalid file type. Please upload JPEG, PNG, GIF, or WEBP images only.", "error");
                    $(this).val('');
                    return;
                }

                const maxSize = 5 * 1024 * 1024;
                if (file.size > maxSize) {
                    showMessage("File too large. Maximum size is 5MB.", "error");
                    $(this).val('');
                    return;
                }

                selectedFile = file;
                $(this).siblings('.file-input-label').find('span').text(file.name);

                const reader = new FileReader();
                reader.onload = function(event) {
                    $('#previewImg').attr('src', event.target.result);
                    $('#imagePreview').addClass('active');
                };
                reader.readAsDataURL(file);
            } else {
                selectedFile = null;
                $(this).siblings('.file-input-label').find('span').text('Choose an image...');
                $('#imagePreview').removeClass('active');
                $('#previewImg').attr('src', '');
            }
        });

        $('#removeImageBtn').on('click', function() {
            selectedFile = null;
            $('#restaurantImage').val('');
            $('#restaurantImage').siblings('.file-input-label').find('span').text('Choose an image...');
            $('#imagePreview').removeClass('active');
            $('#previewImg').attr('src', '');
        });

        function showMessage(message, type) {
            const messageDiv = $("#message");
            messageDiv
                .removeClass('success warning error')
                .addClass(type)
                .html('<i class="fas ' +
                    (type === 'success' ? 'fa-check-circle' :
                     type === 'warning' ? 'fa-exclamation-triangle' :
                     'fa-exclamation-circle') + '"></i> ' + message)
                .fadeIn();

            setTimeout(() => {
                messageDiv.fadeOut();
            }, 5000);
        }

        function uploadImage(restaurantId, imageFile, successCallback, errorCallback) {
            const uploadUrl = "/restaurant/" + restaurantId + "/upload-image";

            const formData = new FormData();
            formData.append('image', imageFile);

            $.ajax({
                url: uploadUrl,
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                xhrFields: {
                    withCredentials: true
                },
                success: function(response) {
                    if (successCallback) successCallback(response);
                },
                error: function(xhr) {
                    let errorMsg = "Image upload failed";
                    try {
                        if (xhr.responseText) {
                            const errorResponse = JSON.parse(xhr.responseText);
                            errorMsg = errorResponse.message || errorMsg;
                        }
                    } catch(e) {
                        errorMsg = `Upload failed with status ${xhr.status}`;
                    }

                    if (xhr.status === 401) {
                        errorMsg = "Session expired. Please refresh the page and try again.";
                    } else if (xhr.status === 403) {
                        errorMsg = "You don't have permission to upload images for this restaurant.";
                    } else if (xhr.status === 404) {
                        errorMsg = "Restaurant not found. Please try again.";
                    }

                    if (errorCallback) errorCallback({ message: errorMsg, details: xhr });
                }
            });
        }

        function resetForm() {
            $("#addRestaurantForm")[0].reset();
            selectedFile = null;
            $('#imagePreview').removeClass('active');
            $('#restaurantImage').val('');
            $('#restaurantImage').siblings('.file-input-label').find('span').text('Choose an image...');
            $('#previewImg').attr('src', '');
        }

        // Main form submission
        $("#addRestaurantForm").on("submit", function (e) {
            e.preventDefault();

            const formData = {
                name: $("input[name='name']").val().trim(),
                area: $("input[name='area']").val().trim(),
                phone: $("input[name='phone']").val().trim(),
                location: $("input[name='location']").val().trim()
            };

            if (!formData.name || !formData.area || !formData.phone || !formData.location) {
                showMessage("Please fill in all required fields", "error");
                return;
            }

            const btn = $(this).find('button[type="submit"]');
            const originalText = btn.html();
            btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Submitting...');

            $.ajax({
                url: "/restaurant/addRestaurant",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(formData),
                xhrFields: {
                    withCredentials: true
                },
                success: function (response) {
                    let restaurantId = response?.data?.id || response?.id || null;

                    if (response.data && response.data.id) {
                        restaurantId = response.data.id;
                    } else if (response.id) {
                        restaurantId = response.id;
                    } else if (response.data && typeof response.data === 'number') {
                        restaurantId = response.data;
                    } else if (typeof response === 'number') {
                        restaurantId = response;
                    }

                    if (!restaurantId) {
                        showMessage(response.message || "Restaurant added successfully!", "success");
                        resetForm();
                        btn.prop('disabled', false).html(originalText);
                        return;
                    }

                    if (selectedFile) {
                        showMessage("Restaurant created! Uploading image...", "warning");

                        uploadImage(
                            restaurantId,
                            selectedFile,
                            function(uploadResponse) {
                                showMessage(
                                    (response.message || "Restaurant added successfully!") + " Image uploaded to Cloudinary.",
                                    "success"
                                );
                                resetForm();
                                btn.prop('disabled', false).html(originalText);
                            },
                            function(error) {
                                showMessage(
                                    (response.message || "Restaurant added successfully!") +
                                    " Warning: " + error.message + ". You can add the image later from restaurant settings.",
                                    "warning"
                                );
                                resetForm();
                                btn.prop('disabled', false).html(originalText);
                            }
                        );
                    } else {
                        showMessage(response.message || "Restaurant added successfully! Awaiting admin approval.", "success");
                        resetForm();
                        btn.prop('disabled', false).html(originalText);
                    }
                },
                error: function (xhr) {
                    let msg = "Something went wrong. Please try again.";

                    if (xhr.status === 403) {
                        msg = "You are not authorized to add a restaurant.";
                    } else if (xhr.status === 401) {
                        msg = "Please login to add a restaurant.";
                        setTimeout(() => {
                            window.location.href = "${pageContext.request.contextPath}/login";
                        }, 2000);
                        return;
                    } else if (xhr.status === 409) {
                        msg = "A restaurant with this name already exists in this area.";
                    } else if (xhr.responseJSON && xhr.responseJSON.message) {
                        msg = xhr.responseJSON.message;
                    }

                    showMessage(msg, "error");
                    btn.prop('disabled', false).html(originalText);
                }
            });
        });
    });
</script>

</body>
</html>