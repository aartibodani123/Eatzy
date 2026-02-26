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

        const table = $('#pendingTable').DataTable({
            ajax: {
                url: `${pageContext.request.contextPath}/restaurant/${restaurantId}/incoming/orders`,
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
                    render: function (data, type, row) {
                        return `
                            <button class="approve-btn">Accept</button>
                            <button class="reject-btn">Reject</button>
                        `;
                    }
                }
            ]
        });

        // Accept
        $('#pendingTable').on('click', '.approve-btn', function() {
            const tr = $(this).closest('tr');
            const rowData = table.row(tr).data();

            if (!rowData || !rowData.id) {
                return console.error("No order ID found!", rowData);
            }
            console.log("order Id" , rowData.id);
            console.log("restaurnt id",restaurantId);
            accept(rowData.id);
        });

        // Reject
        $('#pendingTable').on('click', '.reject-btn', function() {
            const tr = $(this).closest('tr');
            const rowData = table.row(tr).data();

            if (!rowData || !rowData.id) {
                return console.error("No order ID found!", rowData);
            }

            reject(rowData.id);
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

    });
</script>

</body>
</html>