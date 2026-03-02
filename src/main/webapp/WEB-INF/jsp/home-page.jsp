<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eatzy - Order Food Delivered Fast</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home-page.css">
</head>
<body>

<!-- Navbar -->
<header class="navbar">
    <div class="logo">🍔 Eatzy</div>
    <nav>
        <a class="active" href="#">Home</a>
        <a href="#">Menu</a>
        <a href="#">Offers</a>
        <a href="#">Contact</a>
        <a class="btn-signin" href="/login-page">Sign In</a>
    </nav>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="hero-left">
        <h1>Order Food<br><span>Delivered Fast ⚡</span></h1>
        <p>Fresh meals from your favorite restaurants, delivered hot and fast to your doorstep.</p>

        <div class="hero-buttons">
            <button class="btn-primary">Get Started</button>
            <button class="btn-outline">Explore Menu</button>
        </div>

        <div class="search-box">
            <input type="text" placeholder="Enter your location..." />
            <button>Find Food</button>
        </div>
    </div>

    <div class="hero-right">
        <img src="${pageContext.request.contextPath}/images/burger.png" alt="Burger" />
    </div>
</section>

</body>
</html>