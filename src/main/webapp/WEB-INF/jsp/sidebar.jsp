<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <c:if test="${pageContext.request.isUserInRole('OWNER')}">
        <a href="/owner/add-restaurant">Add Restaurant</a>
        <a href="/owner/my-restaurants">My Restaurants</a>
    </c:if>

    <a href="/logout">Logout</a>
</div>
</body>
</html>

