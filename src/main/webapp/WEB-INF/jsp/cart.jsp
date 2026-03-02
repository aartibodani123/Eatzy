<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<html>
<head>
    <title>Your Cart</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>Your Cart</h2>

<table border="1">
    <thead>
    <tr>
        <th>Name</th>
        <th>Qty</th>
        <th>Price</th>
    </tr>
    </thead>
    <tbody id="cart-body"></tbody>
</table>

<h3>Total: ₹<span id="total">0</span></h3>

<button id="place-order">Place Order ✅</button>

<div id="message"></div>

<script>
    function loadCart() {
        $.get("/customer/cart/view", function (res) {
            const cart = res.data;
            console.log(res);
            $("#cart-body").empty();
            console.log(cart.items[0]);
            cart.items.forEach(function(item) {
                var row = "<tr>" +
                          "<td>" + item.name + "</td>" +
                          "<td>" + item.quantity + "</td>" +
                          "<td>" + item.price + "</td>" +
                          "</tr>";

                $("#cart-body").append(row);
            });

            $("#total").text(cart.totalPrice);
        });
    }

    $("#place-order").click(function () {
        $.post("/customer/orders/place")
            .done(function (res) {
                $("#message").text(res.message).css("color", "green");
                loadCart();
            })
            .fail(function (xhr) {
                const msg = xhr.responseJSON?.message || "Order failed";
                $("#message").text(msg).css("color", "red");
            });
    });

    loadCart();
</script>

</body>
</html>