<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Restaurants</title>
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
    <h2>Pending Restaurant Requests</h2>

    <table id="pendingTable" class="display" style="width:100%">
        <thead>
        <tr>
            <th>Name</th>
            <th>Area</th>
            <th>Location</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Active</th>
            <th>Rejection Reason</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
$(document).ready(function () {

    // Initialize DataTable
    const table = $('#pendingTable').DataTable({
        ajax: {
            url: "${pageContext.request.contextPath}/admin/pending-restaurants",
            dataSrc: "data"
        },
        columns: [
            { data: "name" },
            { data: "area" },
            { data: "location" },
            { data: "phone" },
            { data: "status" },
            { data: "active", render: d => d ? "Yes" : "No" },
            { data: "rejectionReason", render: d => d || "-" },
            {
                data: null,
                orderable: false,
                searchable: false,
                render: function (data, type, row) {
                    // Buttons without data-id, we will use DataTables row().data()
                    return `
                        <button class="approve-btn">Approve</button>
                        <button class="reject-btn">Reject</button>
                    `;
                }
            }
        ]
    });

    // Approve button click
    $('#pendingTable').on('click', '.approve-btn', function() {
        const tr = $(this).closest('tr');
        const rowData = table.row(tr).data(); // get the full row data from DataTable

        if (!rowData || !rowData.id) {
            return console.error("No ID found for approval!", rowData);
        }

        console.log("Approve ID:", rowData.id);
        approve(rowData.id);
    });

    // Reject button click
    $('#pendingTable').on('click', '.reject-btn', function() {
        const tr = $(this).closest('tr');
        const rowData = table.row(tr).data(); // get the full row data from DataTable

        if (!rowData || !rowData.id) {
            return console.error("No ID found for rejection!", rowData);
        }

        console.log("Reject ID:", rowData.id);
        reject(rowData.id);
    });

    // Approve function
    function approve(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/restaurant/status",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
                status: "APPROVED",
                rejectionReason: ""
            }),
            success: function() {
                table.ajax.reload(null, false); // reload table without resetting pagination
                alert("Restaurant approved ✅");
            },
            error: function(err) {
                console.error("Approve failed", err);
                alert("Approve failed");
            }
        });
    }

    // Reject function
    function reject(id) {
        const reason = prompt("Enter rejection reason:");
        if (!reason) return;

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/restaurant/status",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                id: id,
                status: "REJECTED",
                rejectionReason: reason
            }),
            success: function() {
                table.ajax.reload(null, false);
                alert("Restaurant rejected ❌");
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
