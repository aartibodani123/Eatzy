<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login-page.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="login-page center">

<div class="login-card">
    <h2 class="title">Welcome Back !</h2>
    <p class="subtitle">Login to your customer account</p>

    <c:if test="${not empty message}">
        <p class="success-msg">${message}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>

    <form id="loginForm">
        <input type="email" id="email" placeholder="Email" required>
        <input type="password" id="password" placeholder="Password" required>
        <button type="submit" class="primary-btn">Login</button>
    </form>

    <p class="signup-text">
        New user?
        <a href="${pageContext.request.contextPath}/customers/signup">Sign up</a>
    </p>
</div>

</body>
<script>
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
        window.location.href = "${pageContext.request.contextPath}" +data.redirectUrl;
    })
    .catch(error => {
        alert("Invalid Email or Password");
    });
});
</script>

</html>
