<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/auth-check.js"></script>
    <script src="${pageContext.request.contextPath}/js/ajax-setup.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer-dashboard.css">
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <div class="dashboard" id="dashboard">
        <!-- Welcome Card -->
        <div class="welcome-card">
            <h2>
                <i class="fas fa-hand-peace"></i>
                Welcome to Dashboard
            </h2>
            <p>You are logged in as <strong id="userEmail">Loading...</strong></p>
            <div style="display: flex; gap: 1rem; align-items: center;">
                <span style="background: #f97316; color: white; padding: 0.3rem 1rem; border-radius: 40px; font-size: 0.9rem;">
                    <i class="fas fa-circle" style="font-size: 0.5rem; margin-right: 0.3rem; vertical-align: middle;"></i>
                    Active Session
                </span>
            </div>
        </div>

        <!-- Stats Overview -->
        <div class="stats-container">
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-content">
                    <h3 id="avgDeliveryTime">30 min</h3>
                    <p>Avg. Delivery Time</p>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="stat-content">
                    <h3 id="totalOrders">0</h3>
                    <p>Total Orders</p>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <div class="stat-content">
                    <h3 id="favorites">0</h3>
                    <p>Favorites</p>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-icon">
                    <i class="fas fa-tag"></i>
                </div>
                <div class="stat-content">
                    <h3 id="activeOffers">0</h3>
                    <p>Active Offers</p>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="actions-section">
            <h3>
                <i class="fas fa-bolt"></i>
                Quick Actions
            </h3>
            <div class="action-grid">
                <a href="${pageContext.request.contextPath}/customer/restaurants" class="action-btn">
                    <i class="fas fa-utensils"></i>
                    Browse Restaurants
                </a>
                <a href="${pageContext.request.contextPath}/customer/cart" class="action-btn">
                    <i class="fas fa-shopping-cart"></i>
                    View Cart
                </a>
                <a href="${pageContext.request.contextPath}/customer/orders" class="action-btn">
                    <i class="fas fa-history"></i>
                    Order History
                </a>
                <a href="${pageContext.request.contextPath}/customer/profile" class="action-btn">
                    <i class="fas fa-user"></i>
                    My Profile
                </a>
            </div>
        </div>

        <!-- Info Cards -->
        <div class="info-grid">
            <div class="info-card">
                <h4>
                    <i class="fas fa-info-circle"></i>
                    Account Info
                </h4>
                <div class="info-item">
                    <span class="info-label">User ID</span>
                    <span class="info-value" id="userId">Loading...</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Member Since</span>
                    <span class="info-value" id="memberSince">Loading...</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Last Login</span>
                    <span class="info-value" id="lastLogin">Loading...</span>
                </div>
            </div>

            <div class="info-card">
                <h4>
                    <i class="fas fa-crown"></i>
                    Your Benefits
                </h4>
                <div class="info-item">
                    <span class="info-label">Free Delivery</span>
                    <span class="info-value" id="freeDelivery">Loading...</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Member Discount</span>
                    <span class="info-value" id="memberDiscount">Loading...</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Reward Points</span>
                    <span class="info-value" id="rewardPoints">Loading...</span>
                </div>
            </div>
        </div>

        <!-- Logout Link -->
        <a class="logout-btn" id="logoutBtn">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

    <script>

    const TokenManager = {

        getToken: function(){
            return localStorage.getItem("eatzy_token");
        },

        getEmail: function(){
            return localStorage.getItem("eatzy_email");
        },

        setUserInfo: function(email, role){
            localStorage.setItem("eatzy_email", email);
            localStorage.setItem("eatzy_role", role);
        },

        clearToken: function(){
            localStorage.removeItem("eatzy_token");
            localStorage.removeItem("eatzy_email");
            localStorage.removeItem("eatzy_role");
        }

    };


    $(document).ready(function(){

        loadUserData();

    });


    function loadUserData(){

        let email = TokenManager.getEmail();

        if(email){

            $("#userEmail").text(email);

        }else{

            $.ajax({
                url: "${pageContext.request.contextPath}/auth/check",
                type: "GET",

                success: function(data){

                    if(data.authenticated){

                        $("#userEmail").text(data.email);

                        TokenManager.setUserInfo(data.email, data.role);

                    }

                },

                error: function(){

                    $("#userEmail").text("Customer");

                }

            });

        }

        loadDashboardStats();

    }


    function loadDashboardStats(){

        $.ajax({

            url: "${pageContext.request.contextPath}/customer/dashboard/stats",
            type: "GET",

            success: function(data){

                $("#totalOrders").text(data.totalOrders || "0");

                $("#favorites").text(data.favorites || "0");

                $("#activeOffers").text(data.activeOffers || "0");

            },

            error: function(xhr){

                if(xhr.status === 401){

                    TokenManager.clearToken();

                    window.location.href = "${pageContext.request.contextPath}/login-page";

                }

            }

        });

    }


    // Sidebar toggle

    document.getElementById("hamburgerBtn").addEventListener("click", function(){

        document.getElementById("sidebar").classList.toggle("open");

        document.querySelector(".dashboard").classList.toggle("shift");

    });


    // Logout

    $("#logoutBtn").click(function(){

        if(confirm("Are you sure you want to logout?")){

            TokenManager.clearToken();

            window.location.href = "${pageContext.request.contextPath}/login-page";

        }

    });

    </script>
</body>
</html>