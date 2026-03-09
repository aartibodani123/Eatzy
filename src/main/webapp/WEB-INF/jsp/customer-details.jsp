<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Customers | Eatzy Admin</title>
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


        .dashboard {
            margin-left: 0;
            padding: 2rem;
            transition: margin-left 0.3s ease;
        }

        .dashboard.shift {
            margin-left: 280px;
        }


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


        .stats-summary {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .stat-badge {
            background: #f9f9fb;
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


        .dataTables_wrapper {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.15);
            border: 2px solid #eaeef2;
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

        .dataTables_filter input {
            min-width: 250px;
        }


        #customersTable {
            border-collapse: separate;
            border-spacing: 0 0.8rem;
            margin-top: 0.5rem;
            width: 100% !important;
        }

        #customersTable thead th {
            background: #f9f9fb;
            color: #1e1e1e;
            font-weight: 700;
            font-size: 0.9rem;
            padding: 1rem;
            border: none;
            border-bottom: 2px solid #f97316;
        }

        #customersTable thead th:first-child {
            border-radius: 40px 0 0 40px;
        }

        #customersTable thead th:last-child {
            border-radius: 0 40px 40px 0;
        }

        #customersTable tbody tr {
            background: white;
            border-radius: 40px;
            transition: all 0.2s;
            box-shadow: 0 5px 15px -8px rgba(0, 0, 0, 0.1);
        }

        #customersTable tbody tr:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -10px rgba(249, 115, 22, 0.3);
        }

        #customersTable tbody td {
            padding: 1.2rem 1rem;
            border: 2px solid transparent;
            border-bottom: 2px solid #eaeef2;
            color: #2e2e2e;
        }

        #customersTable tbody td:first-child {
            border-radius: 40px 0 0 40px;
            border-left: 2px solid transparent;
        }

        #customersTable tbody td:last-child {
            border-radius: 0 40px 40px 0;
            border-right: 2px solid transparent;
        }


        .customer-name {
            font-weight: 600;
            color: #1e1e1e;
        }

        .customer-name i {
            color: #f97316;
            margin-right: 0.5rem;
        }


        .customer-email {
            color: #6b6b6b;
        }

        .customer-email i {
            color: #f97316;
            margin-right: 0.5rem;
        }


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
    <h2>Manage Customers</h2>


    <div class="stats-summary">
        <div class="stat-badge">
            <i class="fas fa-users"></i>
            <span>Total Customers <span class="count" id="totalCustomers">0</span></span>
        </div>
    </div>

    <table id="customersTable" class="display" style="width:100%">
        <thead>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script>
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

    $(document).ready(function(){
        // Fixed syntax error - removed semicolon and corrected URL
        const table = $('#customersTable').DataTable({
            ajax: {
                url: contextPath + '/admin/get/customers',
                dataSrc: "data"
            },
            columns: [
                {
                    data: "firstName",
                    render: function(data) {
                        return data || '-';
                    }
                },
                {
                    data: "lastName",
                    render: function(data) {
                        return data || '-';
                    }
                },
                {
                    data: "email",
                    render: function(data) {
                        return data || '-';
                    }
                }
            ],

            initComplete: function(settings, json) {
                // Update total customers count
                if (json && json.data) {
                    $('#totalCustomers').text(json.data.length);
                }
            }
        });
    });
</script>

</body>
</html>