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
        <!-- Page Header -->
        <div class="page-header">
            <i class="fas fa-store"></i>
            <h1>Add Restaurant</h1>
        </div>

        <!-- Form Card -->
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

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane"></i> Submit for Approval
                </button>
            </form>

            <!-- Message Area -->
            <div id="message" class="message-area"></div>

            <!-- Helper Text -->
            <div class="helper-text">
                <i class="fas fa-info-circle"></i>
                Your restaurant will be reviewed by admin before being published
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {

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


        $("#addRestaurantForm").on("submit", function (e) {
            e.preventDefault();

            const formData = {
                name: $("input[name='name']").val(),
                area: $("input[name='area']").val(),
                phone: $("input[name='phone']").val(),
                location: $("input[name='location']").val()
            };

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
                    $("#message")
                        .removeClass('error')
                        .addClass('success')
                        .html('<i class="fas fa-check-circle"></i> ' + (response.message || "Restaurant request submitted. Awaiting admin approval."));

                    $("#addRestaurantForm")[0].reset();

                    btn.prop('disabled', false).html(originalText);

                    setTimeout(() => {
                        $("#message").fadeOut();
                    }, 5000);
                },
                error: function (xhr) {
                    let msg = "Something went wrong";
                    if (xhr.status === 403) msg = "You are not authorized to add a restaurant.";
                    if (xhr.status === 401) {
                        window.location.href = "${pageContext.request.contextPath}/login";
                        return;
                    }
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        msg = xhr.responseJSON.message;
                    }

                    $("#message")
                        .removeClass('success')
                        .addClass('error')
                        .html('<i class="fas fa-exclamation-circle"></i> ' + msg);

                    btn.prop('disabled', false).html(originalText);

                    setTimeout(() => {
                        $("#message").fadeOut();
                    }, 5000);
                }
            });
        });
    });
</script>

</body>
</html>