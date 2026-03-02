<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
<div class="dashboard">

    <h2 class="dashboard-title">Welcome to Admin Dashboard</h2>

    <div class="stats-grid">
        <!-- Total Customers Card -->
        <div class="stat-card customers">
            <div class="stat-info">
                <span class="stat-title">Total Clients</span>
                <span class="stat-value" id="totalCustomers">0</span>
            </div>
            <div class="stat-icon">👥</div>
        </div>
        <div class="stat-card customers">
            <div class="stat-info">
                 <span class="stat-title">Total Restaurants</span>
                 <span class="stat-value" id="totalRestaurants">0</span>
            </div>
            <div class="stat-icon">🍽️</div>
        </div>
    </div>
</div>

<a href="#" id="logoutBtn">Logout</a>

<script>
    const BASE_URL = "${pageContext.request.contextPath}";
    const token = sessionStorage.getItem("jwt");

    function authFetch(url) {
        return fetch(url, {
            headers: {
                "Authorization": "Bearer " + token
            }
        });
    }

    authFetch(BASE_URL + "/admin/countUsers")
        .then(res => {
            if (res.status === 401 || res.status === 403) {
                window.location.href = BASE_URL + "/login-page";
                return;
            }
            return res.json();
        })
        .then(data => {
            if (data) {
                document.getElementById("totalCustomers").innerText = data.totalCustomers;
            }
        });

    authFetch(BASE_URL + "/admin/countRestaurants")
        .then(res => {
            if (res.status === 401 || res.status === 403) {
                sessionStorage.removeItem("jwt");
                window.location.href = BASE_URL + "/login-page";
                return;
            }
            return res.json();
        })
        .then(data => {
            if (data) {
                document.getElementById("totalRestaurants").innerText = data.totalRestaurant;
            }
        });

    document.getElementById("hamburgerBtn").addEventListener("click", function () {
        document.getElementById("sidebar").classList.toggle("open");
        document.querySelector(".dashboard").classList.toggle("shift");
    });
    document.getElementById("logoutBtn").addEventListener("click", function () {
        sessionStorage.removeItem("jwt");
        window.location.href = "${pageContext.request.contextPath}/login-page";
    });
</script>

</body>
</html>
