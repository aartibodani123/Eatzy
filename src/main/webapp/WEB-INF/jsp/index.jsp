<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Eatzy | Food Delivery</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            height: 100vh;
            background:
                    linear-gradient(
                            rgba(255, 241, 230, 0.85),
                            rgba(255, 241, 230, 0.85)
                    ),
                    url("${pageContext.request.contextPath}/images/food-doodles.png");
            /*background-repeat: repeat;*/
            /*background-size: 300px;*/
        }

        .card {
            width: 420px;
            padding: 36px 32px;
            border-radius: 18px;
            border: none;
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
        }

        .logo {
            margin-bottom: 24px;
            height: fit-content;
        }

        .tagline {
            font-size: 15px;
            color: #6c757d;
            margin-bottom: 28px;
        }

        .primary-btn,
        .outline-btn {
            width: 100%;
            padding: 12px 0;
            font-size: 16px;
            border-radius: 10px;
        }

        .primary-btn {
            background-color: #ff6b00;
            color: white;
        }

        .primary-btn:hover {
            background-color: #e85f00;
            color: white;
        }

        .outline-btn {
            border: 2px solid #ff6b00;
            color: #ff6b00;
            background-color: transparent;
        }

        .outline-btn:hover {
            background-color: #ff6b00;
            color: white;
        }

        .signup-text {
            font-size: 14px;
            color: #777;
            margin-top: 28px;
        }

        .signup-text a {
            color: #ff6b00;
            text-decoration: none;
            font-weight: 500;
        }

        .signup-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body class="d-flex justify-content-center align-items-center">

<div class="card text-center">

    <!-- LOGO -->
    <img src="${pageContext.request.contextPath}/images/logo.png"
         alt="Eatzy Logo"
         class="logo"
         height="58">

    <p class="tagline">
        Delicious food, delivered fast 🚀
    </p>

    <div class="d-flex flex-column gap-3">
        <button class="btn primary-btn" id="customerBtn">
            🔐 Sign In
        </button>

        <button class="btn outline-btn" id="deliveryBtn">
            📝 Sign Up
        </button>
    </div>

    <p class="signup-text">
        New here?
        <a href="/customers/signup">Create an account</a>
    </p>

</div>

<script>
    $("#customerBtn").click(function () {
        window.location.href = "/login-page";
    });

    $("#deliveryBtn").click(function () {
        window.location.href = "/signup-page";
    });
</script>

</body>
</html>
