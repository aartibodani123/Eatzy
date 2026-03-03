<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Eatzy Theme Admin Dashboard CSS */
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

        /* Dashboard Main Content */
        .dashboard {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .dashboard.shift {
            margin-left: 280px;
        }

        /* Dashboard Title */
        .dashboard-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            margin-bottom: 2rem;
            letter-spacing: -0.02em;
            position: relative;
            display: inline-block;
        }

        .dashboard-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        /* Stat Cards */
        .stat-card {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            box-shadow: 0 15px 35px -15px rgba(0, 0, 0, 0.15);
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
            border: 2px solid #eaeef2;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: #f97316;
            transform: scaleX(0);
            transition: transform 0.3s ease;
            transform-origin: left;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            border-color: #f97316;
            box-shadow: 0 25px 40px -18px rgba(249, 115, 22, 0.4);
        }

        .stat-card:hover::before {
            transform: scaleX(1);
        }

        .stat-card.customers {
            background: linear-gradient(135deg, #fff6ed, white);
        }

        .stat-info {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .stat-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #6b6b6b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-value {
            font-size: 3.2rem;
            font-weight: 800;
            color: #1e1e1e;
            line-height: 1;
        }

        .stat-icon {
            font-size: 4rem;
            background: #fff6ed;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #f97316;
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.3);
        }

        /* Quick Actions Section */
        .actions-section {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            box-shadow: 0 15px 35px -15px rgba(0, 0, 0, 0.15);
            margin-bottom: 3rem;
            border: 2px solid #eaeef2;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .section-title i {
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
            font-weight: 600;
            transition: all 0.2s;
        }

        .action-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateX(5px);
        }

        .action-btn i {
            color: #f97316;
        }

        /* Recent Activity Section */
        .activity-section {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            box-shadow: 0 15px 35px -15px rgba(0, 0, 0, 0.15);
            border: 2px solid #eaeef2;
        }

        .activity-list {
            margin-top: 1.5rem;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #f0e4d5;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            background: #fff6ed;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #f97316;
        }

        .activity-details {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: #1e1e1e;
            margin-bottom: 0.2rem;
        }

        .activity-time {
            font-size: 0.85rem;
            color: #6b6b6b;
        }

        /* Logout Button */
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
            margin-top: 2rem;
        }

        .logout-btn:hover {
            background: #ffe1d6;
            border-color: #b34033;
            transform: translateY(-2px);
        }

        .logout-btn i {
            color: #b34033;
        }

        /* Loading States */
        .loading {
            opacity: 0.6;
            position: relative;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            right: -20px;
            width: 20px;
            height: 20px;
            border: 2px solid #f97316;
            border-top-color: transparent;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dashboard {
                padding: 1rem 1rem 1rem 4rem;
            }

            .dashboard.shift {
                margin-left: 0;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .dashboard-title {
                font-size: 1.8rem;
            }

            .stat-value {
                font-size: 2.5rem;
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .action-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Animation for cards */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card {
            animation: fadeInUp 0.5s ease forwards;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <!-- Main Dashboard Content -->
    <div class="dashboard" id="dashboard">
        <!-- Welcome Header -->
        <h2 class="dashboard-title">
            <i class="fas fa-crown" style="color: #f97316; margin-right: 0.5rem;"></i>
            Admin Dashboard
        </h2>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <!-- Total Customers Card -->
            <div class="stat-card customers">
                <div class="stat-info">
                    <span class="stat-title">
                        <i class="fas fa-users" style="color: #f97316; margin-right: 0.3rem;"></i>
                        Total Clients
                    </span>
                    <span class="stat-value" id="totalCustomers">0</span>
                    <span style="color: #6b6b6b; font-size: 0.9rem;">
                        <i class="fas fa-arrow-up" style="color: #2e7d32;"></i> +12% this month
                    </span>
                </div>
                <div class="stat-icon">👥</div>
            </div>

            <!-- Total Restaurants Card -->
            <div class="stat-card customers">
                <div class="stat-info">
                    <span class="stat-title">
                        <i class="fas fa-store" style="color: #f97316; margin-right: 0.3rem;"></i>
                        Total Restaurants
                    </span>
                    <span class="stat-value" id="totalRestaurants">0</span>
                    <span style="color: #6b6b6b; font-size: 0.9rem;">
                        <i class="fas fa-arrow-up" style="color: #2e7d32;"></i> +5 new this week
                    </span>
                </div>
                <div class="stat-icon">🍽️</div>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="actions-section">
            <h3 class="section-title">
                <i class="fas fa-bolt"></i>
                Quick Actions
            </h3>
            <div class="action-grid">
                <a href="/admin/pending-restaurants-page" class="action-btn">
                    <i class="fas fa-clock"></i>
                    Pending Requests
                </a>
                <a href="/admin/users" class="action-btn">
                    <i class="fas fa-users-cog"></i>
                    Manage Users
                </a>
                <a href="/admin/restaurants" class="action-btn">
                    <i class="fas fa-store-alt"></i>
                    All Restaurants
                </a>
                <a href="/admin/reports" class="action-btn">
                    <i class="fas fa-chart-bar"></i>
                    Reports
                </a>
            </div>
        </div>

        <!-- Recent Activity Section -->
        <div class="activity-section">
            <h3 class="section-title">
                <i class="fas fa-history"></i>
                Recent Activity
            </h3>
            <div class="activity-list">
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-store"></i>
                    </div>
                    <div class="activity-details">
                        <div class="activity-title">New restaurant pending approval</div>
                        <div class="activity-time">2 minutes ago</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="activity-details">
                        <div class="activity-title">5 new customers registered</div>
                        <div class="activity-time">1 hour ago</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon">
                        <i class="fas fa-clipboard-check"></i>
                    </div>
                    <div class="activity-details">
                        <div class="activity-title">3 restaurants approved</div>
                        <div class="activity-time">3 hours ago</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Logout Button -->
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

    <script>
        // Fetch total customers
        fetch("${pageContext.request.contextPath}/admin/countUsers")
            .then(res => res.json())
            .then(data => {
                document.getElementById("totalCustomers").innerText = data.totalCustomers || 0;
            })
            .catch(error => {
                console.error("Error fetching customers:", error);
                document.getElementById("totalCustomers").innerText = "Error";
            });

        // Fetch total restaurants
        fetch("${pageContext.request.contextPath}/admin/countRestaurants")
            .then(res => res.json())
            .then(data => {
                document.getElementById("totalRestaurants").innerText = data.totalRestaurant || 0;
            })
            .catch(error => {
                console.error("Error fetching restaurants:", error);
                document.getElementById("totalRestaurants").innerText = "Error";
            });

        // Sidebar toggle functionality
        document.getElementById("hamburgerBtn").addEventListener("click", function () {
            document.getElementById("sidebar").classList.toggle("open");
            document.querySelector(".dashboard").classList.toggle("shift");
        });

        // Close sidebar when clicking outside
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const hamburger = document.getElementById('hamburgerBtn');

            if (!sidebar.contains(event.target) && !hamburger.contains(event.target) && sidebar.classList.contains('open')) {
                sidebar.classList.remove('open');
                document.querySelector(".dashboard").classList.remove("shift");
            }
        });
    </script>
</body>
</html>