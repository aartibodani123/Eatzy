<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
    <link rel="icon" href="data:,">

    <!-- DataTables CSS & JS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<div class="dashboard">
    <h2>My Orders</h2>

    <table id="ordersTable" class="display" style="width:100%">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>LastUpdated</th>
            <th>Track</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>

    const contextPath = "${pageContext.request.contextPath}";

    $(document).ready(function () {

        const table = $('#ordersTable').DataTable({
            ajax: {
                url: contextPath + "/customer/orders/get-all-orders",
                dataSrc: "data"
            },
            columns: [
                { data: "orderId" },
                {
                    data: "totalAmount",
                    render: function(data){
                        return "₹ " + data;
                    }
                },
                {
                    data: "status",
                    render: function(status){
                        return renderStatus(status);
                    }
                },
                { data: "lastUpdated" },
              {
                  data: null,
                  orderable: false,
                  searchable: false,
                  render: function(data, type, row) {
                      return `<button class="track-btn" data-order-id="${row.orderId}">Track</button>`;
                  }
              }
            ]
        });
$('#ordersTable tbody').on('click', '.track-btn', function() {
    const orderId = $(this).data('order-id');

    $.ajax({
        url: `${contextPath}/customer/orders/${orderId}/track`,
        type: "GET",
        xhrFields: {
            withCredentials: true // ensures cookies/session are sent
        },
        success: function(res){
            if(res.status === 200){
                // Show tracking info in a modal or alert
                alert("Order Tracking Info:\n" + JSON.stringify(res.data, null, 2));
            } else {
                alert("Unable to fetch order tracking");
            }
        },
        error: function(err){
            console.error(err);
            alert("Unable to fetch order tracking");
        }
    });
});

        function renderStatus(status) {

            if (status === "PLACED") {
                return `<span style="color:orange; font-weight:bold;">Placed</span>`;
            }

            if (status === "ACCEPTED") {
                return `<span style="color:blue;">Accepted</span>`;
            }

            if (status === "PREPARING") {
                return `<span style="color:purple;">Preparing</span>`;
            }

            if (status === "READY") {
                return `<span style="color:teal;">Ready</span>`;
            }

            if (status === "OUT_FOR_DELIVERY") {
                return `<span style="color:green;">Out for Delivery</span>`;
            }

            if (status === "DELIVERED") {
                return `<span style="color:gray;">Delivered</span>`;
            }

            if (status === "REJECTED") {
                return `<span style="color:red;">Rejected</span>`;
            }

            return status;
        }

    });

</script>

</body>
</html>