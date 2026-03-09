<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/ajax-setup.js"></script>
    <script src="${pageContext.request.contextPath}/js/auth-check.js"></script>

     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
<div id="dashboard-layout">


    <!-- Main Content -->
    <div id="main-content">
        <h2>Welcome to your Dashboard</h2>
        <div id="page-content">
            <!-- Pages will load here -->
        </div>
    </div>
</div>
<script>
<script>
document.getElementById("hamburgerBtn").addEventListener("click", function () {
        document.getElementById("sidebar").classList.toggle("open");
            document.querySelector(".dashboard").classList.toggle("shift");
 });
</script>



</body>
</html>
