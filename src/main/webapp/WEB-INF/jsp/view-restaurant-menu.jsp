<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String restaurantId = String.valueOf(request.getParameter("restaurantId"));
    String restaurantName = request.getParameter("restaurantName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Menu | Eatzy</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        body {
            background: #fdf6ef;
            min-height: 100vh;
        }

        .content {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .content.shift {
            margin-left: 280px;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 1.5rem 2rem 2rem;
            background: white;
            border-radius: 1.5rem;
            box-shadow: 0 8px 40px rgba(0,0,0,0.08);
        }

        /* ── TOP HEADER ── */
        .menu-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.55rem 1.1rem;
            background: #fff;
            border: 1.5px solid #e5e5e5;
            border-radius: 40px;
            color: #2e2e2e;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.88rem;
            transition: all 0.2s;
        }

        .back-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateX(-3px);
        }

        .back-btn i { color: #888; font-size: 0.8rem; }

        .header-content h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1a1a1a;
            letter-spacing: -0.02em;
        }

        .header-meta {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-top: 0.2rem;
            font-size: 0.82rem;
            color: #777;
        }

        .restaurant-badge {
            background: #fff6ed;
            color: #f97316;
            padding: 0.18rem 0.7rem;
            border-radius: 40px;
            font-size: 0.78rem;
            font-weight: 600;
            border: 1px solid #f97316;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .restaurant-badge i { font-size: 0.72rem; }

        .time-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            color: #888;
            font-size: 0.82rem;
        }

        .time-badge i { color: #f97316; font-size: 0.78rem; }

        /* ── CART BUTTON ── */
        .cart-icon {
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.7rem 1.4rem;
            background: #f97316;
            color: white;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
            transition: all 0.2s;
        }

        .cart-icon:hover {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px -6px rgba(249, 115, 22, 0.45);
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #22c55e;
            color: white;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.72rem;
            font-weight: 700;
            border: 2px solid white;
        }

        /* ── CATEGORY TABS ── */
        .category-tabs {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
            padding-bottom: 0;
        }

        .tab-btn {
            padding: 0.45rem 1.2rem;
            border-radius: 40px;
            border: 1.5px solid #e5e5e5;
            background: white;
            color: #555;
            font-size: 0.88rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .tab-btn:hover {
            border-color: #f97316;
            color: #f97316;
        }

        .tab-btn.active {
            background: #f97316;
            border-color: #f97316;
            color: white;
        }

        /* ── MESSAGE ── */
        #message {
            padding: 0.75rem 1.2rem;
            border-radius: 8px;
            margin: 0.8rem 0;
            font-weight: 500;
            font-size: 0.88rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            animation: slideIn 0.3s ease;
        }

        #message.success {
            background: #e8f5e8;
            color: #2e7d32;
            border: 1px solid #a5d6a7;
        }

        #message.error {
            background: #ffebee;
            color: #c62828;
            border: 1px solid #ef9a9a;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ── MENU GRID ── */
        .menu-grid { display: block; }

        .category-section { margin-bottom: 2.5rem; }

        /* Category title row */
        .category-title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .category-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #1a1a1a;
        }

        .view-all-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            font-size: 0.82rem;
            font-weight: 600;
            color: #888;
            cursor: pointer;
            border: none;
            background: none;
            transition: color 0.2s;
        }

        .view-all-btn:hover { color: #f97316; }
        .view-all-btn i { font-size: 0.75rem; }

        /* ── CARD GRID (Main Course style) ── */
        .items-card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1rem;
        }

        .card-item {
            border: 1px solid #f0f0f0;
            border-radius: 14px;
            overflow: hidden;
            background: white;
            transition: box-shadow 0.2s, transform 0.2s;
        }

        .card-item:hover {
            box-shadow: 0 8px 24px rgba(0,0,0,0.09);
            transform: translateY(-2px);
        }

        .card-item-img {
            width: 100%;
            height: 140px;
            object-fit: cover;
        }

        .card-item-body {
            padding: 0.75rem 0.85rem 0.9rem;
        }

        .card-item-name {
            font-size: 0.92rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 0.15rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .card-item-price-row {
            display: flex;
            align-items: baseline;
            gap: 0.3rem;
            margin-bottom: 0.75rem;
        }

        .card-item-price {
            font-size: 0.9rem;
            font-weight: 700;
            color: #f97316;
        }

        .card-item-per {
            font-size: 0.75rem;
            color: #aaa;
            font-weight: 400;
        }

        .card-item-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.5rem;
        }

        /* ── HORIZONTAL LIST (Snacks / Drinks style) ── */
        .items-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 0.75rem;
        }

        .list-item {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            padding: 0.75rem 0.85rem;
            border: 1px solid #f0f0f0;
            border-radius: 14px;
            background: white;
            transition: box-shadow 0.2s;
        }

        .list-item:hover {
            box-shadow: 0 4px 14px rgba(0,0,0,0.07);
        }

        .list-item-img {
            width: 70px;
            height: 60px;
            object-fit: cover;
            border-radius: 10px;
            flex-shrink: 0;
        }

        .list-item-info { flex: 1; min-width: 0; }

        .list-item-name {
            font-size: 0.92rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 0.1rem;
        }

        .list-item-price-row {
            display: flex;
            align-items: baseline;
            gap: 0.3rem;
        }

        .list-item-price {
            font-size: 0.88rem;
            font-weight: 700;
            color: #f97316;
        }

        .list-item-per {
            font-size: 0.74rem;
            color: #aaa;
        }

        /* ── QUANTITY SELECTOR ── */
        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 0;
            border: 1.5px solid #e5e5e5;
            border-radius: 8px;
            overflow: hidden;
        }

        .qty-btn {
            width: 28px;
            height: 28px;
            border: none;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background 0.15s;
            color: #555;
            font-weight: 700;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .qty-btn:hover { background: #ffe5d0; color: #f97316; }

        .qty-input {
            width: 32px;
            text-align: center;
            border: none;
            background: white;
            font-weight: 600;
            font-size: 0.85rem;
            color: #333;
            padding: 0;
        }

        .qty-input:focus { outline: none; }

        /* ── ADD BUTTON ── */
        .add-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.45rem 1.1rem;
            background: #f97316;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .add-btn:hover:not(:disabled) {
            background: #e85d0e;
            box-shadow: 0 4px 12px rgba(249,115,22,0.35);
        }

        .add-btn:disabled {
            background: #4caf50;
            cursor: not-allowed;
        }

        .add-btn i { font-size: 0.75rem; }

        /* ── LOADING / EMPTY ── */
        .loading, .empty-menu {
            text-align: center;
            padding: 3rem;
            color: #888;
            font-size: 0.95rem;
        }

        .loading i, .empty-menu i {
            display: block;
            font-size: 2rem;
            color: #f97316;
            margin-bottom: 0.8rem;
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 768px) {
            .content { padding: 1rem 1rem 1rem 4rem; }
            .content.shift { margin-left: 0; }
            .items-card-grid { grid-template-columns: repeat(2, 1fr); }
            .items-list { grid-template-columns: 1fr; }
        }

        @media (max-width: 480px) {
            .container { padding: 1rem; }
            .items-card-grid { grid-template-columns: 1fr 1fr; }
            .card-item-img { height: 110px; }
        }

        /* Pattern overlay */
        .content::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(rgba(249, 115, 22, 0.02) 1px, transparent 1px);
            background-size: 30px 30px;
            pointer-events: none;
            z-index: -1;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <div class="content" id="mainContent">
        <div class="container">

            <!-- ── HEADER ── -->
            <div class="menu-header">
                <div class="header-left">
                    <a href="javascript:history.back()" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                    <div class="header-content">
                        <h2><%= restaurantName != null ? restaurantName : "Restaurant Menu" %></h2>
                        <div class="header-meta">
                            <span class="restaurant-badge"><i class="fas fa-store"></i> ID: <%= restaurantId %></span>
                            <span class="time-badge"><i class="fas fa-clock"></i> 30-40 min</span>
                        </div>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/customer/cart-page" class="cart-icon">
                    <i class="fas fa-shopping-cart"></i> Cart
                    <span class="cart-count" id="cartCount">0</span>
                </a>
            </div>

            <!-- ── CATEGORY TABS ── -->
            <div class="category-tabs" id="categoryTabs">
                <!-- filled dynamically -->
            </div>

            <div id="message" style="display: none;"></div>

            <!-- ── MENU GRID ── -->
            <div id="menuGrid" class="menu-grid">
                <div class="loading"><i class="fas fa-spinner fa-pulse"></i>Loading delicious menu...</div>
            </div>
        </div>
    </div>

    <script>
      $(document).ready(function () {
          const restaurantId = "<%= restaurantId %>";
          const contextPath   = "${pageContext.request.contextPath}";

          loadCartCount();

          function loadCartCount() {
              $.ajax({
                  url: contextPath + "/customer/cart/view",
                  method: "GET",
                  success: function(res) {
                      if (res && res.data && res.data.items) {
                          const total = res.data.items.reduce((s, i) => s + i.quantity, 0);
                          $('#cartCount').text(total);
                      }
                  },
                  error: function(xhr) {
                      if (xhr.status === 401) window.location.href = contextPath + "/login";
                  }
              });
          }

          /* Category image map - fallback images */
          function getCategoryImage(name) {
              const map = {
                  'Snacks':      'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=400&h=300&fit=crop&auto=format',
                  'Vegetarian':  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop&auto=format',
                  'Beverages':   'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400&h=300&fit=crop&auto=format',
                  'Drinks':      'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400&h=300&fit=crop&auto=format',
                  'Starters':    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400&h=300&fit=crop&auto=format',
                  'Main Course': 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&h=300&fit=crop&auto=format',
                  'Desserts':    'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=400&h=300&fit=crop&auto=format',
                  'Combos':      'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=400&h=300&fit=crop&auto=format',
                  'Rice & Bowls':'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&h=300&fit=crop&auto=format'
              };
              return map[name] || 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=300&fit=crop&auto=format';
          }

          /* Function to get item image URL - prioritizes item's imageUrl, falls back to category image */
          function getItemImage(item, categoryName) {
              if (item.imageUrl && item.imageUrl !== null && item.imageUrl !== "") {
                  return item.imageUrl;
              }
              return getCategoryImage(categoryName);
          }

          /* ── Build quantity selector HTML ── */
          function qtySelector(itemId) {
              return '<div class="quantity-selector">' +
                         '<button class="qty-btn minus-btn" data-item-id="' + itemId + '">−</button>' +
                         '<input type="number" class="qty-input" id="qty-' + itemId + '" value="1" min="1" max="99" readonly>' +
                         '<button class="qty-btn plus-btn"  data-item-id="' + itemId + '">+</button>' +
                     '</div>';
          }

          /* ── Build ADD button HTML ── */
          function addBtn(restaurantId, itemId) {
              return '<button class="add-btn add-to-cart" ' +
                         'data-restaurant-id="' + restaurantId + '" ' +
                         'data-menu-item-id="' + itemId + '">' +
                         '<i class="fas fa-shopping-cart"></i> ADD' +
                     '</button>';
          }

          /* ── AJAX: load menu ── */
          $.ajax({
              url: contextPath + "/customer/restaurants/" + restaurantId + "/menu",
              method: "GET",
              success: function(response) {

                  if (!response || !response.data || response.data.length === 0) {
                      $("#menuGrid").html('<div class="empty-menu"><i class="fas fa-utensils"></i>No menu items available</div>');
                      return;
                  }

                  const categories = response.data;
                  let tabsHtml = '';
                  let menuHtml = '';

                  categories.sort((a, b) => a.categoryName.localeCompare(b.categoryName));

                  $.each(categories, function(idx, cat) {

                      const availableItems = cat.items.filter(item => item.available === true);

                      if (availableItems.length === 0) return;

                      tabsHtml += '<button class="tab-btn' + (idx === 0 ? ' active' : '') + '" ' +
                                      'data-target="cat-' + cat.categoryId + '">' +
                                      cat.categoryName +
                                  '</button>';

                      /* Section open */
                      menuHtml += '<div class="category-section" id="cat-' + cat.categoryId + '">';
                      menuHtml += '<div class="category-title-row">' +
                                      '<span class="category-title">' + cat.categoryName + '</span>' +
                                      '<button class="view-all-btn">View All <i class="fas fa-chevron-right"></i></button>' +
                                  '</div>';

                      menuHtml += '<div class="items-card-grid">';
                      $.each(availableItems, function(_, item) {
                          // Get the appropriate image URL (item's own image or fallback to category image)
                          const itemImageUrl = getItemImage(item, cat.categoryName);

                          menuHtml +=
                              '<div class="card-item" data-item-id="' + item.id + '">' +
                                  '<img src="' + itemImageUrl + '" alt="' + item.name + '" class="card-item-img" onerror="this.src=\'' + getCategoryImage(cat.categoryName) + '\'">' +
                                  '<div class="card-item-body">' +
                                      '<div class="card-item-name">' + escapeHtml(item.name) + '</div>' +
                                      '<div class="card-item-price-row">' +
                                          '<span class="card-item-price">₹ ' + item.price.toFixed(0) + '</span>' +
                                          '<span class="card-item-per">per item</span>' +
                                      '</div>' +
                                      (item.description ?
                                          '<div class="card-item-desc" style="font-size:0.75rem;color:#888;margin-bottom:0.5rem;">' +
                                              escapeHtml(item.description.substring(0, 30)) + (item.description.length > 30 ? '...' : '') +
                                          '</div>' :
                                          '') +
                                      '<div class="card-item-footer">' +
                                          qtySelector(item.id) +
                                          addBtn(restaurantId, item.id) +
                                      '</div>' +
                                  '</div>' +
                              '</div>';
                      });
                      menuHtml += '</div>'; /* /items-card-grid */

                      menuHtml += '</div>'; /* /category-section */
                  });

                  if (tabsHtml === '') {
                      $("#menuGrid").html('<div class="empty-menu"><i class="fas fa-utensils"></i>No menu items available</div>');
                      return;
                  }

                  $('#categoryTabs').html(tabsHtml);
                  $('#menuGrid').html(menuHtml);

                  const restaurantName = "<%= restaurantName != null ? restaurantName : "" %>";
                  if (restaurantName) {
                      $('h2').text(restaurantName);
                  }

                  $('.restaurant-badge').html('<i class="fas fa-store"></i> ID: ' + restaurantId);
              },
              error: function(xhr) {
                  let msg = "Failed to load menu.";
                  if (xhr.status === 401) {
                      msg = "Session expired. Redirecting…";
                      setTimeout(() => { window.location.href = contextPath + "/login"; }, 2000);
                  } else if (xhr.status === 404) {
                      msg = "Restaurant not found.";
                  } else if (xhr.status === 500) {
                      msg = "Server error. Please try again later.";
                  }
                  $("#menuGrid").html('<div class="empty-menu"><i class="fas fa-exclamation-circle"></i>' + msg + '</div>');
              }
          });

          // Helper function to escape HTML to prevent XSS
          function escapeHtml(str) {
              if (!str) return '';
              return str.replace(/[&<>]/g, function(m) {
                  if (m === '&') return '&amp;';
                  if (m === '<') return '&lt;';
                  if (m === '>') return '&gt;';
                  return m;
              });
          }

          /* ── Tab click: scroll to section ── */
          $(document).on('click', '.tab-btn', function() {
              $('.tab-btn').removeClass('active');
              $(this).addClass('active');
              const target = '#' + $(this).data('target');
              $('html, body').animate({ scrollTop: $(target).offset().top - 20 }, 300);
          });

          /* ── Quantity buttons ── */
          $(document).on('click', '.plus-btn', function() {
              const id = $(this).data('item-id');
              const inp = $('#qty-' + id);
              const v = parseInt(inp.val()) || 1;
              if (v < 99) inp.val(v + 1);
          });

          $(document).on('click', '.minus-btn', function() {
              const id = $(this).data('item-id');
              const inp = $('#qty-' + id);
              const v = parseInt(inp.val()) || 1;
              if (v > 1) inp.val(v - 1);
          });

          /* ── Add to cart ── */
          $(document).on("click", ".add-to-cart", function () {
              const btn        = $(this);
              const menuItem   = btn.closest('.card-item, .list-item');
              const itemId     = menuItem.data('item-id');
              const menuItemId = btn.data("menu-item-id");
              const restId     = btn.data("restaurant-id");
              const qtyEl      = $('#qty-' + itemId);
              const quantity   = qtyEl.length ? (parseInt(qtyEl.val()) || 1) : 1;

              btn.prop("disabled", true).html('<i class="fas fa-spinner fa-spin"></i> Adding…');

              $.ajax({
                  url: contextPath + "/customer/cart/add",
                  method: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({ restaurantId: restId, menuItemId: menuItemId, quantity: quantity }),
                  success: function() {
                      const name = menuItem.find('.card-item-name, .list-item-name').text();
                      $("#message")
                          .removeClass('error').addClass('success')
                          .html('<i class="fas fa-check-circle"></i> ' + quantity + ' × ' + name + ' added!')
                          .css("display", "flex");

                      btn.html('<i class="fas fa-check"></i> ADDED');
                      loadCartCount();

                      setTimeout(() => {
                          btn.prop("disabled", false).html('<i class="fas fa-shopping-cart"></i> ADD');
                      }, 2000);

                      setTimeout(() => { $("#message").fadeOut(); }, 3000);
                  },
                  error: function(xhr) {
                      const msg = xhr.responseJSON?.message || "Failed to add to cart";
                      $("#message")
                          .removeClass('success').addClass('error')
                          .html('<i class="fas fa-exclamation-circle"></i> ' + msg)
                          .css("display", "flex");
                      btn.prop("disabled", false).html('<i class="fas fa-shopping-cart"></i> ADD');
                      setTimeout(() => { $("#message").fadeOut(); }, 3000);
                  }
              });
          });

          /* ── Sidebar toggle ── */
          function initSidebarToggle() {
              const hamburger   = document.getElementById("hamburgerBtn");
              const sidebar     = document.getElementById("sidebar");
              const mainContent = document.getElementById("mainContent");
              if (!hamburger || !sidebar || !mainContent) return;

              hamburger.addEventListener("click", function(e) {
                  e.stopPropagation();
                  sidebar.classList.toggle("open");
                  mainContent.classList.toggle("shift");
              });

              document.addEventListener('click', function(event) {
                  if (!sidebar.contains(event.target) && !hamburger.contains(event.target) && sidebar.classList.contains('open')) {
                      sidebar.classList.remove('open');
                      mainContent.classList.remove('shift');
                  }
              });

              sidebar.addEventListener('click', e => e.stopPropagation());
          }

          setTimeout(initSidebarToggle, 100);
      });
    </script>
</body>
</html>