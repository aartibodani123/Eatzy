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
        <a href="/admin/users">Users</a>
    </c:if>

    <!-- Owner Menu -->
    <c:if test="${pageContext.request.isUserInRole('RESTAURANT_OWNER')}">
            <a href="/restaurant/dashboard" class="nav-link" data-page="">Dashboard</a>
            <a href="/restaurant/profile" class="nav-link" >Restaurant Profile</a>
            <a href="/restaurant/menuManagement" class="nav-link" >Menu Management</a>
            <a href="/restaurant/gallery" class="nav-link">Gallery</a>
            <a href="/restaurant/hours" class="nav-link">Opening Hours</a>
            <a href="/restaurant/menuManagement" class="nav-link">Menu Management</a>
            <a href="/restaurant/get/all/restaurants" class="nav-link">manage restaurants</a>
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

