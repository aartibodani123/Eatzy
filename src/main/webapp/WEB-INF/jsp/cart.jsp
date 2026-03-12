<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Your Cart | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
            background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
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

        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            background: white;
            border-radius: 2.5rem;
            box-shadow: 0 30px 60px -10px rgba(0, 0, 0, 0.15);
        }

        .cart-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0e4d5;
            flex-wrap: wrap;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .cart-header i {
            font-size: 2.5rem;
            color: #f97316;
            background: #fff6ed;
            padding: 1rem;
            border-radius: 50%;
        }

        .cart-header h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }

        .cart-header h2::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
            margin-top: 0.5rem;
        }

        .view-orders-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.8rem 1.5rem;
            background: #f9f9fb;
            border: 1.5px solid #eaeef2;
            border-radius: 40px;
            color: #2e2e2e;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }

        .view-orders-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateY(-2px);
        }

        .view-orders-btn i {
            color: #f97316;
        }

        .table-wrapper {
            overflow-x: auto;
            margin-bottom: 2rem;
            border-radius: 20px;
            border: 2px solid #eaeef2;
            background: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1rem;
        }

        thead tr {
            background: #f9f9fb;
            border-bottom: 2px solid #f97316;
        }

        thead th {
            padding: 1.2rem 1rem;
            text-align: left;
            font-weight: 700;
            color: #1e1e1e;
            font-size: 1rem;
        }

        thead th:first-child {
            padding-left: 2rem;
        }

        thead th:last-child {
            padding-right: 2rem;
        }

        tbody tr {
            border-bottom: 1px solid #f0e4d5;
            transition: background 0.2s;
        }

        tbody tr:hover {
            background: #fff6ed;
        }

        tbody td {
            padding: 1.2rem 1rem;
            color: #2e2e2e;
            vertical-align: middle;
        }

        tbody td:first-child {
            padding-left: 2rem;
        }

        tbody td:last-child {
            padding-right: 2rem;
        }

        .item-name {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .item-name i {
            color: #f97316;
            font-size: 1.2rem;
        }

        .item-details {
            display: flex;
            flex-direction: column;
        }

        .item-name-main {
            font-weight: 600;
        }

        .item-price-per {
            font-size: 0.85rem;
            color: #6b6b6b;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .qty-btn {
            width: 32px;
            height: 32px;
            border: 2px solid #eaeef2;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            color: #f97316;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .qty-btn:hover:not(:disabled) {
            border-color: #f97316;
            background: #fff6ed;
        }

        .qty-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            border-color: #ccc;
        }

        .qty-input {
            width: 50px;
            text-align: center;
            border: 2px solid #eaeef2;
            border-radius: 40px;
            padding: 0.3rem;
            font-weight: 600;
        }

        .qty-input.loading {
            background-color: #f5f5f5;
            opacity: 0.7;
        }

        .price {
            font-weight: 700;
            color: #f97316;
        }

        .subtotal {
            font-weight: 700;
            color: #2e7d32;
            font-size: 1.1rem;
        }

        .remove-item {
            background: none;
            border: none;
            color: #b34033;
            cursor: pointer;
            font-size: 1.1rem;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.2s;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .remove-item:hover:not(:disabled) {
            background: #fff1f0;
            color: #8b2c1f;
        }

        .remove-item:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .cart-summary {
            background: #f9f9fb;
            border-radius: 20px;
            padding: 1.5rem;
            margin: 2rem 0;
            border: 2px solid #eaeef2;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .total-label {
            font-size: 1.2rem;
            font-weight: 600;
            color: #1e1e1e;
        }

        .total-amount {
            font-size: 2.2rem;
            font-weight: 800;
            color: #f97316;
        }

        .total-amount small {
            font-size: 1rem;
            font-weight: 500;
            color: #6b6b6b;
        }

        .cart-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
        }

        .btn-primary {
            background: #f97316;
            color: white;
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .btn-primary:hover:not(:disabled) {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .btn-primary:disabled {
            background: #b7ebc3;
            color: #2e7d32;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-secondary {
            background: #f9f9fb;
            color: #2e2e2e;
            border: 1.5px solid #eaeef2;
        }

        .btn-secondary:hover {
            border-color: #f97316;
            background: #fff6ed;
            transform: translateY(-2px);
        }

        .btn-outline {
            background: transparent;
            color: #f97316;
            border: 2px solid #f97316;
        }

        .btn-outline:hover {
            background: #fff6ed;
            transform: translateY(-2px);
        }

        .message-area {
            margin-top: 2rem;
            padding: 1rem;
            border-radius: 40px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease;
        }

        .message-area.success {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
        }

        .message-area.error {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
        }

        .message-area i {
            font-size: 1.2rem;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .empty-cart {
            text-align: center;
            padding: 4rem;
            background: #f9f9fb;
            border-radius: 30px;
            border: 2px dashed #eaeef2;
        }

        .empty-cart i {
            font-size: 4rem;
            color: #f97316;
            margin-bottom: 1rem;
        }

        .empty-cart h3 {
            font-size: 1.5rem;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
        }

        .empty-cart p {
            color: #6b6b6b;
            margin-bottom: 2rem;
        }

        .loading {
            text-align: center;
            padding: 3rem;
            color: #6b6b6b;
        }

        .loading::after {
            content: '...';
            animation: dots 1.5s steps(4, end) infinite;
        }

        @keyframes dots {
            0%, 20% { content: '.'; }
            40% { content: '..'; }
            60%, 100% { content: '...'; }
        }

        @media (max-width: 768px) {
            .content {
                padding: 1rem 1rem 1rem 4rem;
            }

            .content.shift {
                margin-left: 0;
            }

            .cart-container {
                padding: 1.5rem;
            }

            .cart-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .cart-header h2 {
                font-size: 1.8rem;
            }

            .cart-summary {
                flex-direction: column;
                text-align: center;
            }

            .total-amount {
                font-size: 1.8rem;
            }

            .cart-actions {
                justify-content: center;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

    <div class="content" id="mainContent">
        <div class="cart-container">
            <div class="cart-header">
                <div class="header-left">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Your Cart</h2>
                </div>
                <a href="${pageContext.request.contextPath}/customer/orders" class="view-orders-btn">
                    <i class="fas fa-clipboard-list"></i>
                    View My Orders
                </a>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="cart-body">
                        <tr>
                            <td colspan="5" class="loading">Loading your cart...</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="cart-summary" id="cart-summary" style="display: none;">
                <span class="total-label">Total Amount</span>
                <span class="total-amount" id="total">
                    0.00 <small>₹</small>
                </span>
            </div>

            <div class="cart-actions" id="cart-actions" style="display: none;">
                <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/customer/browse-restaurant'">
                    <i class="fas fa-arrow-left"></i>
                    Continue Shopping
                </button>
                <button class="btn btn-primary" id="place-order">
                    <i class="fas fa-check-circle"></i>
                    Place Order
                </button>
            </div>

            <div id="message" class="message-area" style="display: none;"></div>

            <div id="empty-cart-template" style="display: none;">
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Your cart is empty</h3>
                    <p>Looks like you haven't added any items to your cart yet.</p>
                    <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                        <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/customer/browse-restaurant'">
                            <i class="fas fa-utensils"></i>
                            Browse Restaurants
                        </button>
                        <a href="${pageContext.request.contextPath}/customer/orders" class="btn btn-outline">
                            <i class="fas fa-clipboard-list"></i>
                            View My Orders
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const contextPath = "${pageContext.request.contextPath}";

        $(document).ready(function() {
            loadCart();
            initSidebarToggle();
        });

        function loadCart() {
            showLoading();

            $.ajax({
                url: contextPath + "/customer/cart/view",
                method: "GET",
                success: function(res) {
                    if (res && res.data) {
                        const cartData = res.data;

                        if (!cartData.items || cartData.items.length === 0) {
                            showEmptyCart();
                        } else {
                            renderCartItems(cartData);
                            showCartSummaryAndActions();
                        }
                    } else {
                        showEmptyCart();
                    }
                },
                error: function(xhr) {
                    console.error("Failed to load cart:", xhr);
                    if (xhr.status === 401) {
                        window.location.href = contextPath + "/login";
                    } else {
                        showError("Failed to load cart. Please try again.");
                    }
                }
            });
        }

        function renderCartItems(cartData) {
            const items = cartData.items;
            let html = '';

            items.forEach(function(item, index) {
                const subtotal = item.price * item.quantity;

                html += '<tr data-menu-item-id="' + item.menuItemId + '">' +
                    '<td>' +
                        '<div class="item-name">' +
                            '<i class="fas fa-utensils"></i>' +
                            '<div class="item-details">' +
                                '<span class="item-name-main">' + item.name + '</span>' +
                                '<span class="item-price-per">₹' + item.price + ' each</span>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td>' +
                        '<div class="quantity-controls">' +
                            '<button class="qty-btn minus-qty" data-item-id="' + item.menuItemId + '" ' + (item.quantity <= 1 ? 'disabled' : '') + '>−</button>' +
                            '<input type="number" class="qty-input" id="qty-' + item.menuItemId + '" value="' + item.quantity + '" min="1" max="99" readonly>' +
                            '<button class="qty-btn plus-qty" data-item-id="' + item.menuItemId + '" ' + (item.quantity >= 99 ? 'disabled' : '') + '>+</button>' +
                        '</div>' +
                    '</td>' +
                    '<td><span class="price" id="price-' + item.menuItemId + '">₹' + item.price + '</span></td>' +
                    '<td><span class="subtotal" id="subtotal-' + item.menuItemId + '">₹' + subtotal.toFixed(2) + '</span></td>' +
                    '<td>' +
                        '<button class="remove-item" data-item-id="' + item.menuItemId + '" title="Remove item">' +
                            '<i class="fas fa-trash"></i>' +
                        '</button>' +
                    '</td>' +
                '</tr>';
            });

            $('#cart-body').html(html);
            updateCartTotal(cartData.totalPrice || calculateTotalFromItems(items));
        }

        function calculateTotalFromItems(items) {
            return items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
        }

        function updateCartTotal(total) {
            $('#total').html(total.toFixed(2) + ' <small>₹</small>');
        }

        function showLoading() {
            $('#cart-body').html('<tr><td colspan="5" class="loading">Loading your cart...</td></tr>');
            $('#cart-summary, #cart-actions').hide();
        }

        function showEmptyCart() {
            const emptyTemplate = $('#empty-cart-template').html();
            $('.table-wrapper').html(emptyTemplate);
            $('#cart-summary, #cart-actions').hide();
        }

        function showCartSummaryAndActions() {
            $('#cart-summary, #cart-actions').show();
        }

        function showMessage(type, text) {
            $('#message')
                .removeClass('success error')
                .addClass(type)
                .html('<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + text)
                .show();

            setTimeout(() => {
                $('#message').fadeOut();
            }, 3000);
        }

        function showError(text) {
            showMessage('error', text);
        }

$(document).on('click', '.plus-qty', function(e) {
    e.preventDefault();
    const btn = $(this);
    if (btn.prop('disabled')) return;

    const itemId = btn.data('item-id');
    const row = btn.closest('tr');
    const input = row.find('.qty-input'); // ← find by CLASS inside row, not by ID
    const currentVal = parseInt(input.val());

    console.log('Plus clicked, itemId:', itemId, 'val:', input.val(), 'parsed:', currentVal);

    if (!isNaN(currentVal) && currentVal < 99) {
        updateQuantity(itemId, currentVal + 1, row, 'plus');
    }
});

$(document).on('click', '.minus-qty', function(e) {
    e.preventDefault();
    const btn = $(this);
    if (btn.prop('disabled')) return;

    const itemId = btn.data('item-id');
    const row = btn.closest('tr');
    const input = row.find('.qty-input'); // ← find by CLASS inside row, not by ID
    const currentVal = parseInt(input.val());

    console.log('Minus clicked, itemId:', itemId, 'val:', input.val(), 'parsed:', currentVal);

    if (!isNaN(currentVal) && currentVal > 1) {
        updateQuantity(itemId, currentVal - 1, row, 'minus');
    }
});

        // Remove item handler
        $(document).on('click', '.remove-item', function() {
            const btn = $(this);
            const itemId = btn.data('item-id');

            if (confirm('Are you sure you want to remove this item?')) {
                removeItem(itemId, btn);
            }
        });

        // Place order handler
        $('#place-order').click(function() {
            const btn = $(this);

            btn.prop('disabled', true);
            btn.html('<i class="fas fa-spinner fa-spin"></i> Placing Order...');

            $.ajax({
                url: contextPath + "/customer/orders/place",
                method: "POST",
                success: function(res) {
                    showMessage('success', res.message || 'Order placed successfully!');
                    loadCart(); // Reload cart (should be empty now)

                    btn.prop('disabled', false);
                    btn.html('<i class="fas fa-check-circle"></i> Place Order');
                },
                error: function(xhr) {
                    const msg = xhr.responseJSON?.message || 'Order failed. Please try again.';
                    showMessage('error', msg);

                    btn.prop('disabled', false);
                    btn.html('<i class="fas fa-check-circle"></i> Place Order');
                }
            });
        });


       function updateQuantity(menuItemId, newQuantity, row, action) {
           const plusBtn  = row.find('.plus-qty');
           const minusBtn = row.find('.minus-qty');
           const removeBtn = row.find('.remove-item');
           const qtyInput  = row.find('.qty-input'); // ← class, not ID

           plusBtn.prop('disabled', true);
           minusBtn.prop('disabled', true);
           removeBtn.prop('disabled', true);
           qtyInput.addClass('loading');

           const priceText = row.find('.price').text(); // ← also grab price from row
           const price = parseFloat(priceText.replace('₹', ''));

           $.ajax({
               url: contextPath + "/customer/cart/update-quantity",
               method: "POST",
               contentType: "application/json",
               data: JSON.stringify({ menuItemId: menuItemId, quantity: newQuantity }),
               success: function(res) {
                   qtyInput.val(newQuantity);
                   row.find('.subtotal').text('₹' + (price * newQuantity).toFixed(2));

                   if (res.data && res.data.totalPrice !== undefined) {
                       updateCartTotal(res.data.totalPrice);
                   } else {
                       recalculateCartTotal();
                   }
                   showMessage('success', 'Quantity updated');
               },
               error: function(xhr) {
                   console.error('Update failed:', xhr.responseText);
                   showMessage('error', xhr.responseJSON?.message || 'Failed to update quantity');
                   qtyInput.val(action === 'plus' ? newQuantity - 1 : newQuantity + 1);
               },
               complete: function() {
                   const currentQty = parseInt(qtyInput.val());
                   minusBtn.prop('disabled', currentQty <= 1);
                   plusBtn.prop('disabled', currentQty >= 99);
                   removeBtn.prop('disabled', false);
                   qtyInput.removeClass('loading');
               }
           });
       }

        // Function to remove item
        function removeItem(menuItemId, btn) {
            const row = $(`tr[data-menu-item-id="${menuItemId}"]`);

            // Disable button during removal
            btn.prop('disabled', true);
            btn.html('<i class="fas fa-spinner fa-spin"></i>');

            // Dim the row
            row.css('opacity', '0.5');

            $.ajax({
                url: contextPath + "/customer/cart/remove",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    menuItemId: menuItemId
                }),
                success: function(res) {
                    showMessage('success', 'Item removed from cart');

                    // Remove row with animation
                    row.fadeOut(300, function() {
                        $(this).remove();

                        // Check if cart is empty
                        if ($('#cart-body tr').length === 0) {
                            loadCart(); // Reload to show empty cart message
                        } else {
                            // Recalculate total
                            if (res.data && res.data.totalPrice) {
                                updateCartTotal(res.data.totalPrice);
                            } else {
                                recalculateCartTotal();
                            }
                        }
                    });
                },
                error: function(xhr) {
                    const msg = xhr.responseJSON?.message || 'Failed to remove item';
                    showMessage('error', msg);

                    // Restore row
                    row.css('opacity', '1');
                    btn.prop('disabled', false);
                    btn.html('<i class="fas fa-trash"></i>');
                }
            });
        }

        // Function to recalculate cart total from all subtotals
        function recalculateCartTotal() {
            let total = 0;
            $('[id^="subtotal-"]').each(function() {
                const subtotalText = $(this).text();
                const subtotal = parseFloat(subtotalText.replace('₹', ''));
                if (!isNaN(subtotal)) {
                    total += subtotal;
                }
            });
            updateCartTotal(total);
        }

        // Sidebar toggle function
        function initSidebarToggle() {
            const hamburger = document.getElementById("hamburgerBtn");
            const sidebar = document.getElementById("sidebar");
            const mainContent = document.getElementById("mainContent");

            if (!hamburger || !sidebar || !mainContent) {
                console.error("Sidebar elements not found");
                return;
            }

            hamburger.addEventListener("click", function(e) {
                e.stopPropagation();
                sidebar.classList.toggle("open");
                mainContent.classList.toggle("shift");
            });

            document.addEventListener('click', function(event) {
                if (!sidebar.contains(event.target) &&
                    !hamburger.contains(event.target) &&
                    sidebar.classList.contains('open')) {
                    sidebar.classList.remove('open');
                    mainContent.classList.remove('shift');
                }
            });

            sidebar.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }
    </script>
</body>
</html>