<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Eatzy – Fast Food Delivery</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home-page.css" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

      <!-- jQuery -->
      <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Inter:wght@400;500&display=swap" rel="stylesheet">
</head>
<body>
  <header class="navbar">
    <div class="logo">
      <img src="${pageContext.request.contextPath}/images/logo.png" alt="Eatzy Logo" />
      <span>Eatzy</span>
    </div>
    <nav>
      <a class="active" href="#">Home</a>
      <a href="#">Menu</a>
      <a href="#">Offers</a>
      <a href="#">Contact</a>
      <button id ="signin" class="btn-outline">Sign In</button>
    </nav>
  </header>

  <main class="hero">
    <div class="hero-left">
      <h1>
        Order Food <br />
        <span class="highlight">Delivered Fast ⚡</span>
      </h1>
      <p>
        Fresh meals from your favorite restaurants, delivered hot and fast to your doorstep.
      </p>

      <div class="hero-actions">
        <button class="btn-primary">Get Started</button>
        <button class="btn-secondary">Explore Menu</button>
      </div>

      <div class="search-box">
        <input type="text" placeholder="Enter your location..." />
        <button>Find Food</button>
      </div>
    </div>
    <div class="hero-right">
        <img src="${pageContext.request.contextPath}/images/hero-image1.png" alt="Featured Food" />
    </div>
  </main>
  <script>
      $("#signin").click(function () {
          window.location.href = "/login-page";
      });
  </script>
</body>
</html>