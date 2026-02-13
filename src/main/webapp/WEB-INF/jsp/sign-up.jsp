<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Signup</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign-up.css">
</head>

<body>
<div class="center">
    <div class="card">
        <h2>Create Account</h2>

        <form action="/auth/signup" method="post">
            <input type="text" name="firstName" placeholder="First Name" required>
            <input type="text" name="lastName" placeholder="Last Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>


            <div class="role-selection">
                <label class="role-card">
                    <input type="radio" name="role" value="CUSTOMER" hidden>
                    <div class="role-content">
                        <div class="icon">👤</div>
                        <div>
                            <h4>Customer</h4>
                            <p>Order delicious food easily</p>
                        </div>
                    </div>
                </label>

                <label class="role-card">
                    <input type="radio" name="role" value="RESTAURANT_OWNER" hidden>
                    <div class="role-content">
                        <div class="icon">🏪</div>
                        <div>
                            <h4>Restaurant Owner</h4>
                            <p>Manage your restaurant & orders</p>
                        </div>
                    </div>
                </label>
            </div>


            <button class="btn">Sign Up</button>
        </form>
    </div>
</div>
</body>
</html>
