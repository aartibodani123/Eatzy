<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        body {
            background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
            min-height: 100vh;
        }


        .dashboard {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .dashboard.shift {
            margin-left: 280px;
        }


        .welcome-card {
            background: white;
            border-radius: 30px;
            padding: 2.5rem;
            box-shadow: 0 20px 40px -15px rgba(249, 115, 22, 0.2);
            margin-bottom: 2rem;
            border: 1px solid #f0e4d5;
        }

        .welcome-card h2 {
            font-size: 2.2rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 0.8rem;
        }

        .welcome-card h2 i {
            color: #f97316;
            margin-right: 0.5rem;
        }

        .welcome-card p {
            font-size: 1.1rem;
            color: #6b6b6b;
            margin-bottom: 1.5rem;
        }


        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-box {
            background: white;
            border-radius: 24px;
            padding: 1.8rem;
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 1.2rem;
            transition: transform 0.2s;
        }

        .stat-box:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: #fff6ed;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: #f97316;
        }

        .stat-content h3 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1e1e1e;
            line-height: 1.2;
        }

        .stat-content p {
            color: #6b6b6b;
            font-size: 0.9rem;
            font-weight: 500;
        }


        .actions-section {
            background: white;
            border-radius: 30px;
            padding: 2rem;
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .actions-section h3 {
            font-size: 1.3rem;
            color: #1e1e1e;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .actions-section h3 i {
            color: #f97316;
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem 1.5rem;
            background: #f9f9fb;
            border: 1.5px solid #eaeef2;
            border-radius: 40px;
            color: #2e2e2e;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
        }

        .action-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateX(5px);
        }

        .action-btn i {
            color: #f97316;
            font-size: 1.1rem;
        }


        .logout-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem 2rem;
            background: #ffefe5;
            border: 1.5px solid #ffcdc7;
            border-radius: 40px;
            color: #b34033;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
            margin-top: 1rem;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: #ffe1d6;
            border-color: #b34033;
        }

        .logout-btn i {
            color: #b34033;
        }


        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .info-card {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.1);
        }

        .info-card h4 {
            color: #1e1e1e;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-card h4 i {
            color: #f97316;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f0e4d5;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #6b6b6b;
        }

        .info-value {
            color: #1e1e1e;
            font-weight: 600;
        }

        /* Toast Container */
        #toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 99999;
            display: flex;
            flex-direction: column;
            gap: 10px;
            pointer-events: none;
        }

        .toast {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 290px;
            max-width: 380px;
            padding: 14px 16px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            color: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            pointer-events: all;
            opacity: 0;
            transform: translateX(50px);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .toast.show {
            opacity: 1;
            transform: translateX(0);
        }

        .toast.hide {
            opacity: 0;
            transform: translateX(50px);
        }

        .toast.success {
            background: linear-gradient(135deg, #16a34a, #15803d);
        }

        .toast.error {
            background: linear-gradient(135deg, #dc2626, #b91c1c);
        }

        .toast.info {
            background: linear-gradient(135deg, #f97316, #e85d0e);
        }

        .toast-icon {
            font-size: 16px;
            flex-shrink: 0;
        }

        .toast-msg {
            flex: 1;
            line-height: 1.4;
        }

        .toast-close {
            cursor: pointer;
            opacity: 0.7;
            font-size: 15px;
            flex-shrink: 0;
            background: none;
            border: none;
            color: white;
            padding: 0;
        }

        .toast-close:hover {
            opacity: 1;
        }

        /* Custom Confirmation Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 100000;
            backdrop-filter: blur(5px);
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 24px;
            padding: 28px;
            max-width: 380px;
            width: 90%;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            animation: modalSlideIn 0.3s ease;
            text-align: center;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-icon {
            width: 64px;
            height: 64px;
            background: #fff6ed;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }

        .modal-icon i {
            font-size: 32px;
            color: #f97316;
        }

        .modal-content h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 8px;
        }

        .modal-content p {
            color: #6b6b6b;
            margin-bottom: 24px;
            font-size: 1rem;
        }

        .modal-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .modal-btn {
            padding: 12px 24px;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            flex: 1;
        }

        .modal-btn.cancel {
            background: #f9f9fb;
            color: #2e2e2e;
            border: 1.5px solid #eaeef2;
        }

        .modal-btn.cancel:hover {
            background: #fff6ed;
            border-color: #f97316;
        }

        .modal-btn.confirm {
            background: #b34033;
            color: white;
        }

        .modal-btn.confirm:hover {
            background: #8c2f24;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .dashboard {
                padding: 1rem 1rem 1rem 4rem;
            }

            .dashboard.shift {
                margin-left: 0;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .welcome-card h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <!-- Toast Container -->
    <div id="toast-container"></div>

    <!-- Custom Confirmation Modal -->
    <div class="modal-overlay" id="logoutModal">
        <div class="modal-content">
            <div class="modal-icon">
                <i class="fas fa-sign-out-alt"></i>
            </div>
            <h3>Confirm Logout</h3>
            <p>Are you sure you want to logout?</p>
            <div class="modal-actions">
                <button class="modal-btn cancel" id="cancelLogout">Cancel</button>
                <button class="modal-btn confirm" id="confirmLogout">Logout</button>
            </div>
        </div>
    </div>

    <div class="dashboard" id="dashboard">

        <div class="welcome-card">
            <h2>
                <i class="fas fa-hand-peace"></i>
                Welcome to Dashboard
            </h2>
            <p>You are logged in as <strong>${pageContext.request.userPrincipal.name}</strong></p>
            <div style="display: flex; gap: 1rem; align-items: center;">
                <span style="background: #f97316; color: white; padding: 0.3rem 1rem; border-radius: 40px; font-size: 0.9rem;">
                    <i class="fas fa-circle" style="font-size: 0.5rem; margin-right: 0.3rem; vertical-align: middle;"></i>
                    Active Session
                </span>
            </div>
        </div>


        <div class="stats-container">
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <h3>30 min</h3>
                    <p>Avg. Delivery Time</p>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="stat-content">
                    <h3>12</h3>
                    <p>Total Orders</p>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <div class="stat-content">
                    <h3>5</h3>
                    <p>Favorites</p>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-tag"></i>
                </div>
                <div class="stat-content">
                    <h3>3</h3>
                    <p>Active Offers</p>
                </div>
            </div>
        </div>


        <div class="actions-section">
            <h3>
                <i class="fas fa-bolt"></i>
                Quick Actions
            </h3>
            <div class="action-grid">
                <a href="#" class="action-btn">
                    <i class="fas fa-utensils"></i>
                    Browse Restaurants
                </a>
                <a href="#" class="action-btn">
                    <i class="fas fa-shopping-cart"></i>
                    View Cart
                </a>
                <a href="#" class="action-btn">
                    <i class="fas fa-history"></i>
                    Order History
                </a>
                <a href="#" class="action-btn">
                    <i class="fas fa-user"></i>
                    My Profile
                </a>
            </div>
        </div>


        <div class="info-grid">
            <div class="info-card">
                <h4>
                    <i class="fas fa-info-circle"></i>
                    Account Info
                </h4>
                <div class="info-item">
                    <span class="info-label">User ID</span>
                    <span class="info-value">#12345</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Member Since</span>
                    <span class="info-value">Jan 2024</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Last Login</span>
                    <span class="info-value">Today</span>
                </div>
            </div>

            <div class="info-card">
                <h4>
                    <i class="fas fa-crown"></i>
                    Your Benefits
                </h4>
                <div class="info-item">
                    <span class="info-label">Free Delivery</span>
                    <span class="info-value">✓ Active</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Member Discount</span>
                    <span class="info-value">10% OFF</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Reward Points</span>
                    <span class="info-value">250 pts</span>
                </div>
            </div>
        </div>


        <a class="logout-btn" id="logoutBtn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

    <script>
        // Toast function from the example
        function showToast(msg, type) {
            // Remove any existing toasts first
            $('#toast-container').empty();

            const icons = {
                success: '✅',
                error: '❌',
                info: 'ℹ️'
            };

            const toast = $('<div class="toast ' + type + '"><span class="toast-icon">' + (icons[type] || 'ℹ️') + '</span><span class="toast-msg">' + msg + '</span><button class="toast-close">✕</button></div>');

            $('#toast-container').append(toast);

            requestAnimationFrame(() => requestAnimationFrame(() => toast.addClass('show')));

            const tmr = setTimeout(() => dismiss(toast), 3500);

            toast.find('.toast-close').on('click', () => {
                clearTimeout(tmr);
                dismiss(toast);
            });
        }

        function dismiss(toast) {
            toast.removeClass('show').addClass('hide');
            setTimeout(() => toast.remove(), 350);
        }

        document.getElementById("hamburgerBtn").addEventListener("click", function () {
            document.getElementById("sidebar").classList.toggle("open");
            document.querySelector(".dashboard").classList.toggle("shift");
        });

        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const hamburger = document.getElementById('hamburgerBtn');

            if (!sidebar.contains(event.target) && !hamburger.contains(event.target) && sidebar.classList.contains('open')) {
                sidebar.classList.remove('open');
                document.querySelector(".dashboard").classList.remove("shift");
            }
        });

        // Show logout confirmation modal
        $("#logoutBtn").off('click').on('click', function(e) {
            e.preventDefault();
            $('#logoutModal').addClass('show');
        });

        // Cancel logout
        $("#cancelLogout").off('click').on('click', function() {
            $('#logoutModal').removeClass('show');
        });

        // Confirm logout
        $("#confirmLogout").off('click').on('click', function() {
            $('#logoutModal').removeClass('show');

            $.ajax({
               url: "/auth/logout",
               type: "POST",
               success: function (response) {
                  showToast("Logged out successfully!", "success");
                  setTimeout(() => {
                      window.location.href = "/login-page";
                  }, 1500);
               },
               error: function (xhr) {
                  let msg = "Error while logging out.";
                  if (xhr.responseJSON && xhr.responseJSON.message) {
                      msg = xhr.responseJSON.message;
                  }
                  showToast(msg, "error");
               }
            });
        });

        // Close modal when clicking outside
        $('#logoutModal').on('click', function(e) {
            if ($(e.target).hasClass('modal-overlay')) {
                $(this).removeClass('show');
            }
        });
    </script>
</body>
</html>