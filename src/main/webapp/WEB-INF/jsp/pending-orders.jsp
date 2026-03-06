<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Orders</title>
    <link rel="icon" href="data:,">


    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Inter', sans-serif;
}

body {
    background: linear-gradient(145deg, #fefaf5 0%, #fff6ed 100%);
    min-height: 100vh;
    padding-left: 50px;
}

/* Dashboard Layout */
.dashboard {
    margin-left: 0;
    padding: 2rem;
    transition: margin-left 0.3s ease;
}

.dashboard.shift {
    margin-left: 280px;
}

/* Page Title */
.dashboard h2 {
    font-size: 2.2rem;
    font-weight: 700;
    color: #1e1e1e;
    margin-bottom: 2rem;
    position: relative;
    display: inline-block;
}

.dashboard h2::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 0;
    width: 80px;
    height: 4px;
    background: #f97316;
    border-radius: 4px;
}

/* Table Container */
.dataTables_wrapper {
    background: white;
    border-radius: 24px;
    padding: 1.5rem;
    box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.15);
    border: 2px solid #eaeef2;
}

/* DataTable Customization */
.dataTables_wrapper .dataTables_length,
.dataTables_wrapper .dataTables_filter {
    margin-bottom: 1.5rem;
}

.dataTables_wrapper .dataTables_length label,
.dataTables_wrapper .dataTables_filter label {
    color: #1e1e1e;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.dataTables_wrapper .dataTables_length select,
.dataTables_wrapper .dataTables_filter input {
    border: 2px solid #eaeef2;
    border-radius: 40px;
    padding: 0.5rem 1rem;
    font-family: 'Inter', sans-serif;
    outline: none;
    transition: all 0.2s;
}

.dataTables_wrapper .dataTables_length select:focus,
.dataTables_wrapper .dataTables_filter input:focus {
    border-color: #f97316;
    box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
}

.dataTables_filter input {
    min-width: 250px;
}

/* Table Styling */
#pendingTable {
    border-collapse: separate;
    border-spacing: 0 0.8rem;
    margin-top: 0.5rem;
    width: 100% !important;
}

#pendingTable thead th {
    background: #f9f9fb;
    color: #1e1e1e;
    font-weight: 700;
    font-size: 0.9rem;
    padding: 1rem;
    border: none;
    border-bottom: 2px solid #f97316;
}

#pendingTable thead th:first-child {
    border-radius: 40px 0 0 40px;
}

#pendingTable thead th:last-child {
    border-radius: 0 40px 40px 0;
}

#pendingTable tbody tr {
    background: white;
    border-radius: 40px;
    transition: all 0.2s;
    box-shadow: 0 5px 15px -8px rgba(0, 0, 0, 0.1);
}

#pendingTable tbody tr:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px -10px rgba(249, 115, 22, 0.3);
}

#pendingTable tbody td {
    padding: 1.2rem 1rem;
    border: 2px solid transparent;
    border-bottom: 2px solid #eaeef2;
    color: #2e2e2e;
}

#pendingTable tbody td:first-child {
    border-radius: 40px 0 0 40px;
    border-left: 2px solid transparent;
    font-weight: 700;
    color: #f97316;
}

#pendingTable tbody td:last-child {
    border-radius: 0 40px 40px 0;
    border-right: 2px solid transparent;
}

/* Amount styling */
#pendingTable tbody td:nth-child(3) {
    font-weight: 700;
    color: #f97316;
}

/* Status Badges */
#pendingTable tbody td:nth-child(4) span {
    display: inline-block;
    padding: 0.3rem 1rem;
    border-radius: 40px;
    font-size: 0.85rem;
    font-weight: 600;
}

/* Action Buttons */
.accept-btn, .reject-btn, .prepare-btn, .ready-btn, .out-btn {
    border: none;
    border-radius: 40px;
    padding: 0.5rem 1rem;
    font-size: 0.85rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    margin: 0 0.2rem;
    display: inline-flex;
    align-items: center;
    gap: 0.3rem;
}

.accept-btn {
    background: #2e7d32;
    color: white;
}

.accept-btn:hover {
    background: #1e5f22;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px -8px #2e7d32;
}

.reject-btn {
    background: #b34033;
    color: white;
}

.reject-btn:hover {
    background: #8c2f24;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px -8px #b34033;
}

.prepare-btn {
    background: #f97316;
    color: white;
}

.prepare-btn:hover {
    background: #e85d0e;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px -8px #f97316;
}

.ready-btn {
    background: #2e7d32;
    color: white;
}

.ready-btn:hover {
    background: #1e5f22;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px -8px #2e7d32;
}

.out-btn {
    background: #f97316;
    color: white;
}

.out-btn:hover {
    background: #e85d0e;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px -8px #f97316;
}

/* DataTable Pagination */
.dataTables_info {
    color: #6b6b6b;
    font-size: 0.9rem;
    padding-top: 1rem;
}

.dataTables_paginate {
    padding-top: 1rem;
}

.dataTables_paginate .paginate_button {
    border-radius: 40px !important;
    margin: 0 0.2rem;
    border: 1px solid #eaeef2 !important;
    background: white !important;
    color: #2e2e2e !important;
}

.dataTables_paginate .paginate_button.current {
    background: #f97316 !important;
    border-color: #f97316 !important;
    color: white !important;
}

.dataTables_paginate .paginate_button:hover {
    background: #fff6ed !important;
    border-color: #f97316 !important;
}

/* Hamburger button styling */
.hamburger {
    position: fixed;
    top: 20px;
    left: 20px;
    font-size: 24px;
    cursor: pointer;
    z-index: 1100;
    background: #f97316;
    color: white;
    width: 52px;
    height: 52px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 8px 20px -6px rgba(249, 115, 22, 0.5);
    border: 2px solid white;
    transition: all 0.2s;
}

.hamburger:hover {
    background: #e85d0e;
    transform: scale(1.05);
}

/* Responsive Design */
@media (max-width: 768px) {
    body {
        padding-left: 0;
    }

    .dashboard {
        padding: 1rem;
    }

    .dashboard.shift {
        margin-left: 0;
    }

    .dataTables_filter input {
        min-width: 150px;
    }

    .dashboard h2 {
        font-size: 1.8rem;
    }

    .hamburger {
        width: 44px;
        height: 44px;
        font-size: 20px;
    }
}
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />



<div class="dashboard" id="mainContent">
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
    // restaurantId is passed from controller:
    // model.addAttribute("restaurantId", restaurantId);
    const restaurantId = ${restaurantId};
    const contextPath = "${pageContext.request.contextPath}";

    // Sidebar toggle functionality
    document.addEventListener("DOMContentLoaded", function() {
        const hamburger = document.getElementById("hamburgerBtn");
        const sidebar = document.getElementById("sidebar");
        const mainContent = document.getElementById("mainContent");

        if (hamburger && sidebar && mainContent) {
            hamburger.addEventListener("click", function (e) {
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
        }
    });

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