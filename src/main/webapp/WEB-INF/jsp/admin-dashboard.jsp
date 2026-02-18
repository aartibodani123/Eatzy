<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<a href="${pageContext.request.contextPath}/logout">Logout</a>

<script>
fetch("${pageContext.request.contextPath}/admin/countUsers")
.then(res => res.json())
.then(data=>{
    document.getElementById("totalCustomers").innerText=data.totalCustomers;
    });
fetch("${pageContext.request.contextPath}/admin/countRestaurants")
.then(res => res.json())
.then(data=>{
    document.getElementById("totalRestaurants").innerText=data.totalRestaurant;
    });
document.getElementById("hamburgerBtn").addEventListener("click", function () {
        document.getElementById("sidebar").classList.toggle("open");
            document.querySelector(".dashboard").classList.toggle("shift");
        });
</script>

</body>
</html>
