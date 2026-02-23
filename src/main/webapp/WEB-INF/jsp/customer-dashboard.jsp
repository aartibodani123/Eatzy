<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>

 <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />
  <div class="dashboard">
    <h2>Welcome to Dashboard</h2>
    <p>You are logged in!</p>
   <a href="/logout">Logout</a>
   </div>
<script>
document.getElementById("hamburgerBtn").addEventListener("click", function () {
        document.getElementById("sidebar").classList.toggle("open");
            document.querySelector(".dashboard").classList.toggle("shift");
 });
</script>
</body>
</html>
