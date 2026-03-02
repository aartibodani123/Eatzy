<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<html>
<head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slidebar.css">
<body>
<div class="hamburger" id="hamburgerBtn">☰</div>

<div class="sidebar" id="sidebar">
  <div class="title">Eatzy</div>

  <!-- Admin Menu -->
  <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
       <a href="#" onclick="navigateWithJwt('/admin/pending-restaurants-page')">
            Pending Requests
        </a>
        <a href="#" onclick="loadPage('/admin/users-page')">
            Users
        </a>
  </c:if>

  <!-- Owner Menu -->
  <c:if test="${pageContext.request.isUserInRole('RESTAURANT_OWNER')}">
        <a href="#" onclick="loadPage('/restaurant/dashboard')">Dashboard</a>
        <a href="#" onclick="loadPage('/restaurant/profile')">Restaurant Profile</a>
        <a href="#" onclick="loadPage('/restaurant/menuManagement')">Menu Management</a>
        <a href="#" onclick="loadPage('/restaurant/gallery')">Gallery</a>
        <a href="#" onclick="loadPage('/restaurant/hours')">Opening Hours</a>
  </c:if>

  <!-- Customer Menu -->
  <c:if test="${pageContext.request.isUserInRole('CUSTOMER')}">
            <a href="#" onclick="loadPage('/customer/browse-restaurant')">Browse Restaurants</a>
            <a href="#" onclick="loadPage('/customer/cart-page')">My Cart</a>
            <a href="#" onclick="loadPage('/customer/orders')">Orders</a>
  </c:if>

  <a href="#" onclick="logout()">Logout</a>
  <script>
  function loadProtectedPage(url) {
    fetch(url, {
      method: "GET",
      headers: {
        "Authorization": "Bearer " + sessionStorage.getItem("jwt")
      }
    })
    .then(res => {
      if (!res.ok) throw new Error("Unauthorized");
      return res.text();
    })
    .then(html => {
      document.open();
      document.write(html);
      document.close();
    })
    .catch(() => {
      sessionStorage.removeItem("jwt");
      window.location.href = "${pageContext.request.contextPath}/login-page";
    });
  }</script>
</div>
</body>
</html>

