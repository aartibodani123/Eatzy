<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
  <title>Eatzy – Fast Food Delivery</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home-page.css" />
      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

      <!-- jQuery -->
      <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Inter:wght@400;500&display=swap" rel="stylesheet">
</head>
<body>
  <nav>
    <a class="logo" href="#">
     <img src="${pageContext.request.contextPath}/images/logo.png" alt="Eatzy Logo"/>
    </a>
    <ul class="nav-links">
      <li><a href="#" class="active">Home</a></li>
      <li><a href="#">Menu</a></li>
      <li><a href="#">Offers</a></li>
      <li><a href="#">Contact</a></li>
    </ul>
    <div class="nav-actions">
      <button id ="signin" class="btn-text">Sign In</button>
      <button id ="signup" class="btn-primary">Sign Up</button>
    </div>
  </nav>

  <!-- HERO -->
  <section class="hero">
    <div class="hero-left">
      <div class="hero-badge">🔥 #1 Food Delivery App</div>
      <h1 class="hero-title">
        Order Food
        <span>Delivered Fast ⚡</span>
      </h1>
      <p class="hero-desc">Fresh meals from your favorite restaurants, delivered hot and fast to your doorstep.</p>
      <div class="hero-btns">
        <button class="btn-cta">Get Started →</button>
        <button class="btn-outline">Explore Menu</button>
      </div>
      <div class="search-bar">
        <input type="text" placeholder="Enter your location...">
        <button class="btn-find">Find Food</button>
      </div>
    </div>

    <div class="hero-right">
      <div class="circle-bg">
        <!-- Image is INSIDE the circle so it's clipped perfectly -->
        <img class="hero-food-img"
          src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=700&h=700&q=90&auto=format&fit=crop&crop=center"
          alt="Delicious Burger"
          onerror="this.src='https://images.unsplash.com/photo-1550547660-d9450f859349?w=700&h=700&q=90&auto=format&fit=crop'">
      </div>

      <div class="float-card card-delivery">
        <div class="float-card-icon">🛵</div>
        <div>
          <div>Fast Delivery</div>
          <small>Avg. 20 min</small>
        </div>
      </div>

      <div class="float-card card-rating">
        <div class="float-card-icon">⭐</div>
        <div>
          <div>4.9 Rating</div>
          <small>50k+ reviews</small>
        </div>
      </div>

      <div class="float-card card-orders">
        <div class="float-card-icon">📦</div>
        <div>
          <div>Orders Today</div>
          <small>2,400+</small>
        </div>
      </div>
    </div>
  </section>

  <!-- STATS -->
  <div class="stats">
    <div class="stat"><strong>500+</strong><span>Restaurants</span></div>
    <div class="stat"><strong>2M+</strong><span>Happy Customers</span></div>
    <div class="stat"><strong>20min</strong><span>Avg. Delivery</span></div>
    <div class="stat"><strong>50+</strong><span>Cities</span></div>
  </div>

  <!-- CATEGORIES -->
  <section class="categories">
    <div class="section-header">
      <h2 class="section-title">Food Categories</h2>
      <a href="#" class="see-all">See all →</a>
    </div>
    <div class="cat-grid">
      <div class="cat-card active"><div class="cat-icon">🍔</div><p>Burgers</p></div>
      <div class="cat-card"><div class="cat-icon">🍕</div><p>Pizza</p></div>
      <div class="cat-card"><div class="cat-icon">🍣</div><p>Sushi</p></div>
      <div class="cat-card"><div class="cat-icon">🍜</div><p>Noodles</p></div>
      <div class="cat-card"><div class="cat-icon">🥗</div><p>Salads</p></div>
      <div class="cat-card"><div class="cat-icon">🌮</div><p>Tacos</p></div>
      <div class="cat-card"><div class="cat-icon">🍦</div><p>Desserts</p></div>
      <div class="cat-card"><div class="cat-icon">☕</div><p>Drinks</p></div>
    </div>
  </section>

  <!-- POPULAR ITEMS -->
  <section class="popular">
    <div class="section-header">
      <h2 class="section-title">Popular Near You</h2>
      <a href="#" class="see-all">See all →</a>
    </div>
    <div class="food-grid">

      <div class="food-card">
        <div class="food-img-wrap">
          <span class="food-badge">🔥 Bestseller</span>
          <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80&auto=format&fit=crop" alt="Classic Burger">
        </div>
        <div class="food-info">
          <div class="food-name">Classic Smash Burger</div>
          <div class="food-meta">
            <span>⭐ 4.9</span>
            <span>🕐 15 min</span>
            <span>🛵 Free delivery</span>
          </div>
          <div class="food-footer">
            <span class="food-price">$12.99</span>
            <button class="add-btn">+</button>
          </div>
        </div>
      </div>

      <div class="food-card">
        <div class="food-img-wrap">
          <span class="food-badge">⚡ 20% OFF</span>
          <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&q=80&auto=format&fit=crop" alt="Pizza">
        </div>
        <div class="food-info">
          <div class="food-name">Margherita Pizza</div>
          <div class="food-meta">
            <span>⭐ 4.8</span>
            <span>🕐 25 min</span>
            <span>🛵 $1.99</span>
          </div>
          <div class="food-footer">
            <span class="food-price">$14.49</span>
            <button class="add-btn">+</button>
          </div>
        </div>
      </div>

      <div class="food-card">
        <div class="food-img-wrap">
          <span class="food-badge">🆕 New</span>
          <img src="https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=500&q=80&auto=format&fit=crop" alt="Sushi">
        </div>
        <div class="food-info">
          <div class="food-name">Dragon Roll Sushi</div>
          <div class="food-meta">
            <span>⭐ 4.7</span>
            <span>🕐 30 min</span>
            <span>🛵 $2.99</span>
          </div>
          <div class="food-footer">
            <span class="food-price">$18.99</span>
            <button class="add-btn">+</button>
          </div>
        </div>
      </div>

    </div>
  </section>

  <footer>
    © 2026 <span>Eatzy</span>. Made with ❤️ for food lovers.
  </footer>

  <script>
      $("#signin").click(function () {
          window.location.href = "/login-page";
      });
      $("#signup").click(function () {
           window.location.href = "/signup-page";
      });

        document.querySelectorAll('.cat-card').forEach(card => {
          card.addEventListener('click', () => {
            document.querySelectorAll('.cat-card').forEach(c => c.classList.remove('active'));
            card.classList.add('active');
          });
        });


        document.querySelectorAll('a[href="#"]').forEach(a => {
          a.addEventListener('click', e => e.preventDefault());
        });
  </script>
</body>
</html>