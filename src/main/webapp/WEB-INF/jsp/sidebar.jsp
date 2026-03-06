<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slidebar.css">
<body>
<div class="hamburger" id="hamburgerBtn">☰</div>

<div class="sidebar" id="sidebar">
    <div class="title">Eatzy</div>

    <!-- Admin Menu -->
    <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
        <a href="/admin/pending-restaurants-page" id="pendingRequestsLink">Pending Requests</a>
        <a href="/admin/customer-details">All Customer</a>
    </c:if>

    <!-- Owner Menu -->
    <c:if test="${pageContext.request.isUserInRole('RESTAURANT_OWNER')}">
            <a href="/restaurant/menuManagement" class="nav-link" >Menu Management</a>
            <a href="/restaurant/add/details" class="nav-link">Add Details</a>
            <a href="/restaurant/get/all/restaurants" class="nav-link">Manage Orders</a>

    </c:if>
    <c:if test="${pageContext.request.isUserInRole('CUSTOMER')}">
            <a href="/customer/browse-restaurant" id="/browserestaurant">Browse restaurant</a>
            <a href="/customer/cart-page">My cart</a>
            <a href="/customer/orders">Orders </a>
     </c:if>

    <a href="javascript:void(0)" class="logoutBtn">Logout</a>
</div>
<script>
        $(".logoutBtn").click(function () {
            $.ajax({
               url: "/auth/logout",
               type: "POST",
               success: function (response) {
                  alert("Logged out successfully!");
                  window.location.href = "/login-page";
               },
               error: function () {
                  alert("Error while logging out.");
               }
            });
        });
</script>
</body>
</html>

