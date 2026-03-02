<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Track Order</title>
    <link rel="icon" href="data:,">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Optional: Add your CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<div class="dashboard">
    <h2>Track Order</h2>

    <div id="orderDetails" style="margin-top:20px;">
        <p>Loading order details...</p>
    </div>
</div>

<script>

    const orderId = "${orderId}";
    const contextPath = "${pageContext.request.contextPath}";

    $(document).ready(function () {
        loadOrder();


        setInterval(loadOrder, 10000);
    });

    function loadOrder() {
        if (!orderId) {
            $("#orderDetails").html("<p style='color:red;'>Invalid Order ID</p>");
            return;
        }

        $.ajax({
            url: `${contextPath}/customer/orders/${orderId}/track`,
            type: "GET",
            success: function(res) {
                const order = res.data;

                if (!order) {
                    $("#orderDetails").html("<p style='color:red;'>Order not found</p>");
                    return;
                }

                const html = `
                    <p><strong>Order ID:</strong> ${order.orderId}</p>
                    <p><strong>Total Amount:</strong> ₹ ${order.totalAmount}</p>
                    <p><strong>Status:</strong> ${renderStatus(order.status)}</p>
                    <p><strong>Created At:</strong> ${order.createdAt}</p>
                    <p><strong>Last Updated:</strong> ${order.lastUpdated}</p>
                    <p><strong>Items:</strong></p>
                    <ul>
                        ${order.items.map(item => `<li>${item.name} x ${item.quantity} - ₹${item.price}</li>`).join('')}
                    </ul>
                `;

                $("#orderDetails").html(html);
            },
            error: function(err) {
                console.error("Failed to load order:", err);
                $("#orderDetails").html("<p style='color:red;'>Failed to load order details.</p>");
            }
        });
    }

    function renderStatus(status) {
        switch(status) {
            case "PLACED": return `<span style="color:orange;font-weight:bold;">Placed</span>`;
            case "ACCEPTED": return `<span style="color:blue;">Accepted</span>`;
            case "PREPARING": return `<span style="color:purple;">Preparing</span>`;
            case "READY": return `<span style="color:teal;">Ready</span>`;
            case "OUT_FOR_DELIVERY": return `<span style="color:green;">Out for Delivery</span>`;
            case "DELIVERED": return `<span style="color:gray;">Delivered</span>`;
            case "REJECTED": return `<span style="color:red;">Rejected</span>`;
            default: return status;
        }
    }
</script>

</body>
</html>