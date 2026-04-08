<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Order Details</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        .order-box {
            border: 1px solid #ddd;
            padding: 20px;
            width: 600px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background: #f5f5f5;
        }

        .toast-message {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #b34033;
            color: white;
            padding: 1rem 2rem;
            border-radius: 40px;
            box-shadow: 0 10px 25px -8px rgba(0,0,0,0.3);
            z-index: 10001;
            animation: slideIn 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }

        .toast-message.success {
            background: #2e7d32;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>

<body>

<h2>Order Details</h2>

<div class="order-box">

    <p><b>Order ID:</b> <span id="orderId"></span></p>
    <p><b>Status:</b> <span id="status"></span></p>
    <p><b>Total Amount:</b> ₹<span id="amount"></span></p>
    <p><b>Created At:</b> <span id="createdAt"></span></p>

    <h3>Items</h3>

    <table>
        <thead>
        <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
        </tr>
        </thead>

        <tbody id="itemsTable">
        </tbody>
    </table>

</div>

<script>
function showToast(message, type) {
    const toast = $('<div class="toast-message ' + (type === 'success' ? 'success' : '') + '"></div>')
        .html('<i class="fas ' + (type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle') + '"></i> ' + message)
        .css({
            position: 'fixed',
            top: '20px',
            right: '20px',
            background: type === 'success' ? '#2e7d32' : '#b34033',
            color: 'white',
            padding: '1rem 2rem',
            borderRadius: '40px',
            boxShadow: '0 10px 25px -8px rgba(0,0,0,0.3)',
            zIndex: 10001,
            animation: 'slideIn 0.3s ease',
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem',
            fontWeight: '500'
        });

    $('body').append(toast);

    setTimeout(() => {
        toast.fadeOut(300, function() {
            $(this).remove();
        });
    }, 3000);
}

$(document).ready(function() {

   var orderId = Number("${orderId}");

    console.log("Extracted Order ID:", orderId);

    if (!orderId) {
        showToast("Order ID missing", "error");
        return;
    }

    const contextPath = "${pageContext.request.contextPath}";

    $.ajax({
        url: contextPath + "/customer/orders/" + orderId,
        type: "GET",
        success: function(order) {

            console.log("Full Order Response:", order);

            // Basic details
            $("#orderId").text(order.id);
            $("#status").text(order.status);
            $("#amount").text(order.totalAmount);
            $("#createdAt").text(order.createdAt);

            // Items rendering
           let html = "";

           if(order.items && order.items.length > 0){

               order.items.forEach(function(item){

                   html += '<tr>' +
                               '<td>' + item.name + '</td>' +
                               '<td>₹' + item.price + '</td>' +
                               '<td>' + item.quantity + '</td>' +
                           '</tr>';

               });

           }else{

               html = '<tr>' +
                           '<td colspan="3">No items found</td>' +
                      '</tr>';

           }

           $("#itemsTable").html(html);

        },

        error: function(xhr) {
            console.error(xhr.responseText);
            showToast("Failed to fetch order details", "error");
        }
    });

});
</script>

</body>
</html>