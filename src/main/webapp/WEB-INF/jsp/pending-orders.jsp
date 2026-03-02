<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Orders</title>
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
    <h2>Incoming Orders</h2>

    <table id="pendingTable" class="display" style="width:100%">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>User ID</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
    // restaurantId is passed from  controller:
    // model.addAttribute("restaurantId", restaurantId);
    const restaurantId = ${restaurantId};

    const contextPath = "${pageContext.request.contextPath}";


    $(document).ready(function () {
        console.log("Restaurnt id ", restaurantId);
        const table = $('#pendingTable').DataTable({
            ajax: {
                url: contextPath + '/restaurant/' + restaurantId + '/incoming/orders',
                dataSrc: "data"
            },
            columns: [
                { data: "id" },
                { data: "userId" },
                { data: "totalAmount" },
                { data: "status" },
                { data: "createdAt" },
                {
                    data: null,
                    orderable: false,
                    searchable: false,
                    render: function (order) {
                         return renderButtons(order);
                    }
                }
            ]
        });
        function renderButtons(order) {

          if (order.status === "PLACED") {
            return `
              <button class="accept-btn" data-id="${order.id}">Accept</button>
              <button class="reject-btn" data-id="${order.id}">Reject</button>
            `;
          }

          if (order.status === "ACCEPTED") {
            return `<button class="prepare-btn" data-id="${order.id}">Start Preparing</button>`;
          }

          if (order.status === "PREPARING") {
            return `<button class="ready-btn" data-id="${order.id}">Mark Ready</button>`;
          }

          if (order.status === "READY") {
            return `<button class="out-btn" data-id="${order.id}">Out for Delivery</button>`;
          }

          if (order.status === "OUT_FOR_DELIVERY") {
            return `<span style="color:green; font-weight:bold;">Out for delivery</span>`;
          }
          if (order.status === "DELIVERED") {
            return `<span style="color:gray;">Completed</span>`;
          }

          if (order.status === "REJECTED") {
            return `<span style="color:red;">Rejected</span>`;
          }

          return "-";
        }
        $('#pendingTable').on('click', '.accept-btn', function () {
              const tr = $(this).closest('tr');
              const rowData = table.row(tr).data();

              if (!rowData || !rowData.id) {
                  return console.error("No order ID found!", rowData);
              }
              console.log("order Id" , rowData.id);
              console.log("restaurnt id",restaurantId);
              accept(rowData.id);
        });

        $('#pendingTable').on('click', '.reject-btn', function () {
               const tr = $(this).closest('tr');
               const rowData = table.row(tr).data();

               if (!rowData || !rowData.id) {
                    return console.error("No order ID found!", rowData);
               }

               reject(rowData.id);
        });

        $('#pendingTable').on('click', '.prepare-btn', function () {
                const tr = $(this).closest('tr');
                const rowData = table.row(tr).data();

                if (!rowData?.id) {
                    console.error("No order ID found!", rowData);
                    return;
                }

                console.log("Start preparing order:", rowData.id);
                startPreparing(rowData.id);
        });

        $('#pendingTable').on('click', '.ready-btn', function () {
                const tr = $(this).closest('tr');
                const rowData = table.row(tr).data();

                if (!rowData?.id) {
                    console.error("No order ID found!", rowData);
                    return;
                }

                console.log("Mark ready order:", rowData.id);
                markReady(rowData.id);
        });
        $('#pendingTable').on('click', '.out-btn', function () {
            const tr = $(this).closest('tr');
            const rowData = table.row(tr).data();

            if (!rowData?.id) {
                console.error("No order ID found!", rowData);
                return;
            }

            markOutForDelivery(rowData.id);
        });
        function accept(orderId) {
            console.log("restaurnt id",restaurantId);
            console.log("order id",orderId);
            $.ajax({
                url: contextPath + '/restaurant/' + restaurantId + '/orders/' + orderId + '/accept',
                type: "POST",
                success: function() {
                    table.ajax.reload(null, false);
                    alert("Order accepted ");
                },
                error: function(err) {
                     console.error("Accept failed", err);
                     alert("Accept failed");
                }
            });
        }
        function reject(orderId) {
            $.ajax({
                url: contextPath + '/restaurant/' + restaurantId + '/orders/' + orderId + '/reject',
                type: "POST",
                contentType: "application/json",
                success: function() {
                     table.ajax.reload(null, false);
                     alert("Order rejected ");
                },
                error: function(err) {
                     console.error("Reject failed", err);
                     alert("Reject failed");
                }
            });
        }
        function startPreparing(orderId) {
            $.ajax({
                url: contextPath+ '/restaurant/' + restaurantId + '/orders/' + orderId + '/prepare',
                type: "POST",
                contentType: "application/json",
                success: function(){
                    table.ajax.reload(null,false);
                },
                error: function(){
                    alert("Couldnt start preparing");
                }
            });
        }
        function markReady(orderId) {
            $.ajax({
                url: contextPath+ '/restaurant/' + restaurantId + '/orders/' + orderId + '/ready',
                type: "POST",
                contentType: "application/json",
                success: function(){
                    table.ajax.reload(null,false);
                },
                error: function(){
                    alert("Order not ready yet");
                }
            });
        }
        function markOutForDelivery(orderId) {
            $.ajax({
                url: contextPath + '/restaurant/' + restaurantId + '/orders/' + orderId + '/out-for-delivery',
                type: "POST",
                contentType: "application/json",
                success: function () {
                    table.ajax.reload(null, false);
                    alert("Order is now out for delivery ");
                },
                error: function () {
                    alert("Failed to mark order as out for delivery");
                }
            });
        }




    });
</script>

</body>
</html>