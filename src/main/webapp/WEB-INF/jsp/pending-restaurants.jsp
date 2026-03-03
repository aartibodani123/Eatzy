<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Restaurants | Eatzy Admin</title>
    <link rel="icon" href="data:,">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

    <style>
        /* Eatzy Theme Admin CSS */
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

        /* Dashboard Main Content */
        .dashboard {
            margin-left: 0;
            padding: 2rem 2rem 2rem 5rem;
            transition: margin-left 0.3s ease;
            min-height: 100vh;
        }

        .dashboard.shift {
            margin-left: 280px;
        }

        /* Page Title */
        .page-title {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            margin-bottom: 2rem;
            letter-spacing: -0.02em;
            position: relative;
            display: inline-block;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 80px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
        }

        .page-title i {
            color: #f97316;
            margin-right: 0.8rem;
        }

        /* Stats Summary */
        .stats-summary {
            display: flex;
            gap: 2rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .stat-badge {
            background: white;
            border: 2px solid #eaeef2;
            border-radius: 40px;
            padding: 0.8rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 5px 15px -8px rgba(0, 0, 0, 0.1);
        }

        .stat-badge i {
            color: #f97316;
            font-size: 1.2rem;
        }

        .stat-badge span {
            font-weight: 600;
            color: #1e1e1e;
        }

        .stat-badge .count {
            background: #f97316;
            color: white;
            padding: 0.2rem 0.8rem;
            border-radius: 40px;
            font-size: 0.9rem;
            margin-left: 0.5rem;
        }

        /* DataTable Container */
        .table-container {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.15);
            border: 2px solid #eaeef2;
        }

        /* DataTable Customization */
        .dataTables_wrapper {
            font-family: 'Inter', sans-serif;
        }

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

        /* Table Styling */
        #pendingTable {
            border-collapse: separate;
            border-spacing: 0 0.8rem;
            margin-top: 0.5rem;
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
        }

        #pendingTable tbody td:last-child {
            border-radius: 0 40px 40px 0;
            border-right: 2px solid transparent;
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-badge.pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-badge.approved {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
        }

        .status-badge.rejected {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
        }

        /* Active Badge */
        .active-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .active-badge.yes {
            color: #2e7d32;
        }

        .active-badge.no {
            color: #b34033;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .approve-btn, .reject-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .approve-btn {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
        }

        .approve-btn:hover {
            background: #2e7d32;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px -8px #2e7d32;
        }

        .reject-btn {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
        }

        .reject-btn:hover {
            background: #b34033;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px -8px #b34033;
        }

        /* DataTable Info and Pagination */
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard {
                padding: 1rem 1rem 1rem 4rem;
            }

            .dashboard.shift {
                margin-left: 0;
            }

            .page-title {
                font-size: 1.8rem;
            }

            .action-buttons {
                flex-direction: column;
            }
        }

        /* Loading State */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-overlay.active {
            display: flex;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 3px solid #f0e4d5;
            border-top-color: #f97316;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Empty State */
        .dataTables_empty {
            text-align: center;
            padding: 3rem !important;
            color: #6b6b6b;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/sidebar.jsp" />

<div class="dashboard" id="dashboard">
    <!-- Page Title -->
    <h2 class="page-title">
        <i class="fas fa-clock"></i>
        Pending Restaurant Requests
    </h2>

    <!-- Stats Summary -->
    <div class="stats-summary">
        <div class="stat-badge">
            <i class="fas fa-store"></i>
            <span>Total Pending <span class="count" id="pendingCount">0</span></span>
        </div>
        <div class="stat-badge">
            <i class="fas fa-check-circle"></i>
            <span>Approved Today <span class="count" id="approvedToday">0</span></span>
        </div>
    </div>

    <!-- Table Container -->
    <div class="table-container">
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
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-spinner"></div>
</div>

<script>
$(document).ready(function () {
    const loadingOverlay = $('#loadingOverlay');

    // Initialize DataTable with Eatzy theme
    const table = $('#pendingTable').DataTable({
        ajax: {
            url: "${pageContext.request.contextPath}/admin/pending-restaurants",
            dataSrc: function(json) {
                // Update pending count
                $('#pendingCount').text(json.data ? json.data.length : 0);
                return json.data;
            }
        },
        columns: [
            {
                data: "name",
                render: function(data) {
                    return '<span style="font-weight: 600; color: #1e1e1e;">' + data + '</span>';
                }
            },
            { data: "area" },
            { data: "location" },
            {
                data: "phone",
                render: function(data) {
                    return '<i class="fas fa-phone-alt" style="color: #f97316; margin-right: 0.3rem;"></i>' + data;
                }
            },
            {
                data: "status",
                render: function(data) {
                    let badgeClass = 'pending';
                    if (data === 'APPROVED') badgeClass = 'approved';
                    if (data === 'REJECTED') badgeClass = 'rejected';
                    return `<span class="status-badge ${badgeClass}"><i class="fas fa-circle" style="font-size: 0.5rem;"></i> ${data}</span>`;
                }
            },
            {
                data: "active",
                render: function(d) {
                    return d ?
                        '<span class="active-badge yes"><i class="fas fa-check-circle"></i> Yes</span>' :
                        '<span class="active-badge no"><i class="fas fa-times-circle"></i> No</span>';
                }
            },
            {
                data: "rejectionReason",
                render: function(d) {
                    return d ?
                        '<span style="color: #b34033;"><i class="fas fa-exclamation-triangle"></i> ' + d + '</span>' :
                        '<span style="color: #6b6b6b;">—</span>';
                }
            },
            {
                data: null,
                orderable: false,
                searchable: false,
                render: function (data, type, row) {
                    return `
                        <div class="action-buttons">
                            <button class="approve-btn"><i class="fas fa-check"></i> Approve</button>
                            <button class="reject-btn"><i class="fas fa-times"></i> Reject</button>
                        </div>
                    `;
                }
            }
        ],
        language: {
            search: "<i class='fas fa-search' style='color: #f97316; margin-right: 0.3rem;'></i> Search:",
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ restaurants",
            infoEmpty: "Showing 0 to 0 of 0 restaurants",
            infoFiltered: "(filtered from _MAX_ total entries)",
            loadingRecords: '<div style="text-align: center; padding: 2rem;">Loading...</div>',
            zeroRecords: '<div style="text-align: center; padding: 2rem;"><i class="fas fa-store" style="font-size: 3rem; color: #f97316; margin-bottom: 1rem;"></i><br>No pending restaurants found</div>',
            paginate: {
                first: '<i class="fas fa-angle-double-left"></i>',
                previous: '<i class="fas fa-angle-left"></i>',
                next: '<i class="fas fa-angle-right"></i>',
                last: '<i class="fas fa-angle-double-right"></i>'
            }
        },
        pageLength: 10,
        order: [[0, 'asc']],
        initComplete: function() {
            // Add custom styling to DataTable elements
            $('.dataTables_filter input').attr('placeholder', 'Search restaurants...');
        }
    });

    // Approve button click
    $('#pendingTable').on('click', '.approve-btn', function() {
        const tr = $(this).closest('tr');
        const rowData = table.row(tr).data();

        if (!rowData || !rowData.id) {
            console.error("No ID found for approval!", rowData);
            return;
        }

        // Show loading
        loadingOverlay.addClass('active');

        $.ajax({
            url: "${pageContext.request.contextPath}/admin/restaurant/status",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                id: rowData.id,
                status: "APPROVED",
                rejectionReason: ""
            }),
            success: function() {
                table.ajax.reload(null, false);
                loadingOverlay.removeClass('active');

                // Show success toast
                showToast('Restaurant approved successfully', 'success');
            },
            error: function(err) {
                console.error("Approve failed", err);
                loadingOverlay.removeClass('active');
                showToast('Failed to approve restaurant', 'error');
            }
        });
    });

    // Reject button click
    $('#pendingTable').on('click', '.reject-btn', function() {
        const tr = $(this).closest('tr');
        const rowData = table.row(tr).data();

        if (!rowData || !rowData.id) {
            console.error("No ID found for rejection!", rowData);
            return;
        }

        // Use custom modal instead of prompt for better UX
        showRejectModal(rowData.id, table, loadingOverlay);
    });

    // Toast notification function
    function showToast(message, type) {
        const toast = $('<div class="toast-message"></div>')
            .text(message)
            .css({
                position: 'fixed',
                bottom: '20px',
                right: '20px',
                background: type === 'success' ? '#2e7d32' : '#b34033',
                color: 'white',
                padding: '1rem 2rem',
                borderRadius: '40px',
                boxShadow: '0 10px 25px -8px rgba(0,0,0,0.3)',
                zIndex: 9999,
                animation: 'slideIn 0.3s ease'
            });

        $('body').append(toast);
        setTimeout(() => toast.fadeOut(() => toast.remove()), 3000);
    }

    // Custom reject modal
    function showRejectModal(restaurantId, table, loadingOverlay) {
        const modal = $(`
            <div class="modal-overlay">
                <div class="modal-content">
                    <h3><i class="fas fa-exclamation-triangle"></i> Reject Restaurant</h3>
                    <p>Please provide a reason for rejection:</p>
                    <textarea id="rejectReason" rows="3" placeholder="Enter rejection reason..."></textarea>
                    <div class="modal-actions">
                        <button class="cancel-btn">Cancel</button>
                        <button class="confirm-reject-btn">Reject</button>
                    </div>
                </div>
            </div>
        `).css({
            position: 'fixed',
            top: 0,
            left: 0,
            width: '100%',
            height: '100%',
            background: 'rgba(0,0,0,0.5)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 10000
        });

        modal.find('.modal-content').css({
            background: 'white',
            borderRadius: '24px',
            padding: '2rem',
            maxWidth: '500px',
            width: '90%',
            boxShadow: '0 30px 60px -15px rgba(0,0,0,0.3)'
        });

        modal.find('h3').css({
            color: '#b34033',
            marginBottom: '1rem'
        });

        modal.find('textarea').css({
            width: '100%',
            padding: '1rem',
            border: '2px solid #eaeef2',
            borderRadius: '20px',
            margin: '1rem 0',
            fontFamily: 'Inter',
            outline: 'none'
        });

        modal.find('.modal-actions').css({
            display: 'flex',
            gap: '1rem',
            justifyContent: 'flex-end'
        });

        modal.find('.cancel-btn').css({
            padding: '0.8rem 1.5rem',
            background: '#f9f9fb',
            border: '1px solid #eaeef2',
            borderRadius: '40px',
            cursor: 'pointer',
            fontWeight: '600'
        });

        modal.find('.confirm-reject-btn').css({
            padding: '0.8rem 1.5rem',
            background: '#b34033',
            color: 'white',
            border: 'none',
            borderRadius: '40px',
            cursor: 'pointer',
            fontWeight: '600'
        });

        $('body').append(modal);

        modal.find('.cancel-btn').click(() => modal.remove());
        modal.find('.confirm-reject-btn').click(() => {
            const reason = $('#rejectReason').val();
            if (!reason) {
                alert('Please enter a rejection reason');
                return;
            }

            modal.remove();
            loadingOverlay.addClass('active');

            $.ajax({
                url: "${pageContext.request.contextPath}/admin/restaurant/status",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    id: restaurantId,
                    status: "REJECTED",
                    rejectionReason: reason
                }),
                success: function() {
                    table.ajax.reload(null, false);
                    loadingOverlay.removeClass('active');
                    showToast('Restaurant rejected', 'success');
                },
                error: function(err) {
                    console.error("Reject failed", err);
                    loadingOverlay.removeClass('active');
                    showToast('Failed to reject restaurant', 'error');
                }
            });
        });
    }

    // Sidebar toggle
    document.getElementById("hamburgerBtn").addEventListener("click", function () {
        document.getElementById("sidebar").classList.toggle("open");
        document.querySelector(".dashboard").classList.toggle("shift");
    });

    // Close sidebar when clicking outside
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const hamburger = document.getElementById('hamburgerBtn');

        if (!sidebar.contains(event.target) && !hamburger.contains(event.target) && sidebar.classList.contains('open')) {
            sidebar.classList.remove('open');
            document.querySelector(".dashboard").classList.remove("shift");
        }
    });
});
</script>

</body>
</html>