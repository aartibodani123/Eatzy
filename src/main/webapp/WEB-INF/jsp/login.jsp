<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | Eatzy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home-page.css">
</head>

<body class="auth-page">

<div class="auth-container">

    <div class="auth-card">
        <h2>Welcome Back 👋</h2>
        <p class="subtitle">Sign in to your Eatzy account</p>

        <c:if test="${not empty message}">
            <p class="success-msg">${message}</p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="error-msg">${error}</p>
        </c:if>

        <form id="loginForm">
            <input type="email" id="email" placeholder="Email address" required>
            <input type="password" id="password" placeholder="Password" required>

            <button type="submit" class="primary-btn full-width">
                Sign In
            </button>
        </form>

        <p class="signup-text">
            New user?
            <a href="${pageContext.request.contextPath}/customers/signup">
                Create an account
            </a>
        </p>
    </div>

</div>

<script>
function loadProtectedPage(url) {
    const token = sessionStorage.getItem("jwt"); // Get JWT from sessionStorage
    if (!token) {
        window.location.href = "${pageContext.request.contextPath}/login-page"; // Redirect if JWT is missing
        return;
    }

    fetch(url, {
        method: "GET",
        headers: {
            "Authorization": "Bearer " + token // Send JWT token in Authorization header
        }
    })
    .then(res => {
        if (!res.ok) throw new Error("Unauthorized");  // Handle 401 Unauthorized
        return res.text();
    })
    .then(html => {
        document.open();
        document.write(html);
        document.close();
    })
    .catch(() => {
        sessionStorage.removeItem("jwt");  // Remove invalid JWT
        window.location.href = "${pageContext.request.contextPath}/login-page";  // Redirect to login page on failure
    });
}
document.getElementById("loginForm").addEventListener("submit", function(e) {
    e.preventDefault();

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    fetch("${pageContext.request.contextPath}/auth/login", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            email: email,
            password: password
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Invalid credentials");
        }
        return response.json();
    })
    .then(data => {
      if (!data.accessToken) {
        throw new Error("Token missing in response");
      }
      sessionStorage.setItem("jwt", data.accessToken);

      loadProtectedPage(
        "${pageContext.request.contextPath}" + data.redirectUrl
      );
    })
    .catch(error => {
        alert("Invalid Email or Password");
    });
});
</script>

</body>
</html>