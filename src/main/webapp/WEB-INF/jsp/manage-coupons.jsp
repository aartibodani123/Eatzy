<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Coupons | Eatzy</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            padding: 2rem;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .page-header i {
            font-size: 2.5rem;
            color: #f97316;
            background: #fff6ed;
            padding: 1rem;
            border-radius: 50%;
        }

        .page-header h2 {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e1e1e;
            letter-spacing: -0.02em;
        }

        .page-header h2::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: #f97316;
            border-radius: 4px;
            margin-top: 0.5rem;
        }

        /* Debug Card */
        .debug-card {
            background: #fff6ed;
            border: 2px solid #f97316;
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .debug-card strong {
            color: #f97316;
        }

        /* Form Card */
        .form-card {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.15);
            border: 2px solid #eaeef2;
        }

        .form-card h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e1e1e;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-card h3 i {
            color: #f97316;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #1e1e1e;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-group label i {
            color: #f97316;
            margin-right: 0.5rem;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem 1.2rem;
            background: #f9f9fb;
            border: 2px solid #eaeef2;
            border-radius: 40px;
            font-size: 1rem;
            outline: none;
            transition: all 0.2s;
            font-family: 'Inter', sans-serif;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #f97316;
            background: white;
            box-shadow: 0 0 0 4px rgba(249, 115, 22, 0.1);
        }

        .form-group textarea {
            border-radius: 20px;
            resize: vertical;
        }

        .form-group small {
            display: block;
            color: #6b6b6b;
            font-size: 0.8rem;
            margin-top: 0.3rem;
        }

        .btn-primary {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.8rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }

        .btn-primary:hover {
            background: #e85d0e;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -8px rgba(249, 115, 22, 0.4);
        }

        .btn-secondary {
            background: #f9f9fb;
            color: #2e2e2e;
            border: 1.5px solid #eaeef2;
            border-radius: 40px;
            padding: 0.8rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-secondary:hover {
            border-color: #f97316;
            background: #fff6ed;
        }

        /* Table Card */
        .table-card {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.15);
            border: 2px solid #eaeef2;
        }

        .table-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .table-header h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e1e1e;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .table-header h3 i {
            color: #f97316;
        }

        .refresh-btn {
            background: #f9f9fb;
            border: 1.5px solid #eaeef2;
            border-radius: 40px;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .refresh-btn:hover {
            border-color: #f97316;
            background: #fff6ed;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead th {
            background: #f9f9fb;
            color: #1e1e1e;
            font-weight: 700;
            font-size: 0.85rem;
            padding: 1rem;
            border-bottom: 2px solid #f97316;
            text-align: left;
        }

        tbody td {
            padding: 1rem;
            border-bottom: 1px solid #f0e4d5;
            color: #2e2e2e;
        }

        tbody tr:hover {
            background: #fff6ed;
        }

        .status-active {
            color: #2e7d32;
            font-weight: 600;
        }

        .status-inactive {
            color: #b34033;
            font-weight: 600;
        }

        .action-btn {
            background: #f97316;
            color: white;
            border: none;
            border-radius: 40px;
            padding: 0.4rem 1rem;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            margin: 0 0.2rem;
        }

        .action-btn:hover {
            background: #e85d0e;
            transform: translateY(-2px);
        }

        .action-btn.secondary {
            background: #6b6b6b;
        }

        .action-btn.secondary:hover {
            background: #5a5a5a;
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 10000;
        }

        .modal-overlay.show {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            max-width: 500px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease;
        }

        @keyframes modalSlideIn {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0e4d5;
        }

        .modal-header i {
            font-size: 1.8rem;
            color: #f97316;
            background: #fff6ed;
            padding: 0.8rem;
            border-radius: 50%;
        }

        .modal-header h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e1e1e;
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .modal-buttons button {
            flex: 1;
        }

        /* Message */
        .message {
            margin-top: 1.5rem;
            padding: 1rem;
            border-radius: 40px;
            display: none;
            align-items: center;
            gap: 0.8rem;
            animation: slideIn 0.3s ease;
        }

        .message.success {
            background: #e6f7e6;
            color: #2e7d32;
            border: 1px solid #b7ebc3;
            display: flex;
        }

        .message.error {
            background: #fff1f0;
            color: #b34033;
            border: 1px solid #ffcdc7;
            display: flex;
        }

        .message i {
            font-size: 1.2rem;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            .form-grid {
                grid-template-columns: 1fr;
            }
            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <i class="fas fa-ticket-alt"></i>
            <h2>Coupon Management</h2>
        </div>

        <input type="hidden" id="restaurantId" value="${restaurantId}">

        <!-- Debug Info -->
        <div class="debug-card">
            <div>
                <i class="fas fa-info-circle"></i>
                <strong>Debug Info:</strong>
                Restaurant ID: <span id="debugRestaurantId">${restaurantId}</span>
            </div>
            <div id="debugStatus"></div>
        </div>

        <!-- Create Coupon Form -->
        <div class="form-card">
            <h3><i class="fas fa-plus-circle"></i> Create New Coupon</h3>
            <form id="createCouponForm">
                <div class="form-grid">
                    <div class="form-group">
                        <label><i class="fas fa-tag"></i> Coupon Code</label>
                        <input type="text" id="code" name="code" placeholder="e.g., SAVE20" required>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-percent"></i> Discount Type</label>
                        <select id="discountType" name="discountType" required>
                            <option value="PERCENTAGE">Percentage (%)</option>
                            <option value="FIXED">Fixed Amount (₹)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-rupee-sign"></i> Discount Value</label>
                        <input type="number" id="discountValue" name="discountValue" step="0.01" placeholder="e.g., 20" required>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-shopping-cart"></i> Minimum Order Amount</label>
                        <input type="number" id="minOrderAmount" name="minOrderAmount" step="0.01" value="0" placeholder="0 = no minimum">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-chart-line"></i> Maximum Discount</label>
                        <input type="number" id="maxDiscount" name="maxDiscount" step="0.01" placeholder="Optional">
                        <small>For percentage discounts only</small>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-infinity"></i> Usage Limit</label>
                        <input type="number" id="usageLimit" name="usageLimit" value="0" placeholder="0 = unlimited">
                        <small>Maximum number of times this coupon can be used</small>
                    </div>
                    <div class="form-group" style="grid-column: span 2;">
                        <label><i class="fas fa-align-left"></i> Description</label>
                        <textarea id="description" name="description" rows="2" placeholder="Brief description of the coupon"></textarea>
                    </div>
                </div>
                <button type="submit" class="btn-primary"><i class="fas fa-save"></i> Create Coupon</button>
            </form>
        </div>

        <!-- List All Coupons -->
        <div class="table-card">
            <div class="table-header">
                <h3><i class="fas fa-list"></i> Existing Coupons</h3>
                <button class="refresh-btn" onclick="loadCoupons()"><i class="fas fa-sync-alt"></i> Refresh</button>
            </div>
            <div id="couponsList"></div>
        </div>

        <!-- Edit Coupon Modal -->
        <div id="editModal" class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="fas fa-edit"></i>
                    <h3>Edit Coupon</h3>
                </div>
                <form id="editCouponForm">
                    <input type="hidden" id="editCouponId">
                    <div class="form-group">
                        <label><i class="fas fa-tag"></i> Code</label>
                        <input type="text" id="editCode" disabled>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-align-left"></i> Description</label>
                        <textarea id="editDescription" rows="2"></textarea>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-percent"></i> Discount Type</label>
                        <select id="editDiscountType">
                            <option value="PERCENTAGE">Percentage (%)</option>
                            <option value="FIXED">Fixed Amount (₹)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-rupee-sign"></i> Discount Value</label>
                        <input type="number" id="editDiscountValue" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-shopping-cart"></i> Minimum Order Amount</label>
                        <input type="number" id="editMinOrderAmount" step="0.01">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-chart-line"></i> Maximum Discount</label>
                        <input type="number" id="editMaxDiscount" step="0.01">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-infinity"></i> Usage Limit</label>
                        <input type="number" id="editUsageLimit">
                    </div>
                    <div class="modal-buttons">
                        <button type="submit" class="btn-primary"><i class="fas fa-save"></i> Update Coupon</button>
                        <button type="button" class="btn-secondary" onclick="closeModal()"><i class="fas fa-times"></i> Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <div id="message" class="message"></div>
    </div>

    <script>
        var restaurantId = $("#restaurantId").val();

        console.log("Restaurant ID from hidden field:", restaurantId);
        $("#debugRestaurantId").text(restaurantId || "NOT FOUND");

        if(!restaurantId || restaurantId === "") {
            $("#debugStatus").html('<span style="color:#b34033"><i class="fas fa-exclamation-circle"></i> ⚠️ Warning: Restaurant ID is missing!</span>');
        }

        $(document).ready(function() {
            if(restaurantId && restaurantId !== "") {
                loadCoupons();
            } else {
                $("#couponsList").html('<p style="color:#b34033; padding: 2rem; text-align: center;"><i class="fas fa-exclamation-circle"></i> Cannot load coupons: Restaurant ID is missing</p>');
            }

            $("#createCouponForm").submit(function(e) {
                e.preventDefault();
                if(restaurantId && restaurantId !== "") {
                    createCoupon();
                } else {
                    showMessage("Error: Restaurant ID is missing", "error");
                }
            });

            $("#editCouponForm").submit(function(e) {
                e.preventDefault();
                updateCoupon();
            });
        });

        function showMessage(msg, type) {
            $("#message").removeClass("success error").addClass(type).html('<i class="fas fa-' + (type === "success" ? "check-circle" : "exclamation-circle") + '"></i> ' + msg).show();
            setTimeout(function() {
                $("#message").fadeOut();
            }, 5000);
        }

        function loadCoupons() {
            var url = '/restaurant/coupons/list/' + restaurantId;
            console.log("Loading coupons from URL:", url);
            $("#debugStatus").html('<span style="color:#f97316"><i class="fas fa-spinner fa-spin"></i> Loading coupons...</span>');

            $.ajax({
                url: url,
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    console.log("Response received:", response);
                    $("#debugStatus").html('<span style="color:#2e7d32"><i class="fas fa-check-circle"></i> ✓ Coupons loaded successfully</span>');
                    if(response.statusCode === 200) {
                        displayCoupons(response.data);
                    } else {
                        showMessage("Failed to load coupons: " + response.message, "error");
                        $("#couponsList").html('<p style="color:#b34033">Error: ' + response.message + '</p>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX Error:", {
                        status: status,
                        error: error,
                        responseText: xhr.responseText,
                        statusCode: xhr.status
                    });

                    $("#debugStatus").html('<span style="color:#b34033"><i class="fas fa-exclamation-circle"></i> ✗ Error loading coupons (Status: ' + xhr.status + ')</span>');

                    var errorMessage = "Failed to load coupons. ";
                    if(xhr.status === 404) {
                        errorMessage += "Endpoint not found.";
                    } else if(xhr.status === 403) {
                        errorMessage += "Access denied. Please check your authentication.";
                    } else if(xhr.status === 500) {
                        errorMessage += "Server error. Check backend logs.";
                    } else {
                        errorMessage += (xhr.responseJSON?.message || error || "Unknown error");
                    }

                    showMessage(errorMessage, "error");
                    $("#couponsList").html('<p style="color:#b34033">Error: ' + errorMessage + '</p>');
                }
            });
        }

        function displayCoupons(coupons) {
            if(!coupons || coupons.length === 0) {
                $("#couponsList").html('<p style="text-align: center; padding: 3rem; color: #6b6b6b;"><i class="fas fa-ticket-alt" style="font-size: 3rem; margin-bottom: 1rem; display: block;"></i>No coupons found. Create your first coupon!</p>');
                return;
            }

            var html = '<div style="overflow-x: auto;">';
            html += '<table>';
            html += '<thead><tr>';
            html += '<th>ID</th><th>Code</th><th>Description</th><th>Type</th><th>Discount</th>';
            html += '<th>Min Order</th><th>Max Discount</th><th>Usage</th>';
            html += '<th>Status</th><th>Actions</th>';
            html += '</tr></thead><tbody>';

            for(var i = 0; i < coupons.length; i++) {
                var coupon = coupons[i];
                var statusClass = coupon.active ? 'status-active' : 'status-inactive';
                var statusText = coupon.active ? 'Active' : 'Inactive';

                coupon.index = i;

                html += '<tr>';
                html += '<td>' + (coupon.id || 'N/A') + '</td>';
                html += '<td><strong>' + escapeHtml(coupon.code) + '</strong></td>';
                html += '<td>' + escapeHtml(coupon.description || '-') + '</td>';
                html += '<td>' + coupon.discountType + '</td>';
                html += '<td>' + coupon.discountValue + (coupon.discountType === 'PERCENTAGE' ? '%' : ' ₹') + '</td>';
                html += '<td>₹' + (coupon.minOrderAmount || '0') + '</td>';
                html += '<td>' + (coupon.maxDiscount || '-') + '</td>';
                html += '<td>' + (coupon.usedCount || 0) + '/' + (coupon.usageLimit || '∞') + '</td>';
                html += '<td><span class="' + statusClass + '"><i class="fas fa-circle" style="font-size: 0.5rem;"></i> ' + statusText + '</span></td>';
                html += '<td>';
                html += '<button class="action-btn" onclick="editCoupon(' + i + ')"><i class="fas fa-edit"></i> Edit</button> ';
                html += '<button class="action-btn secondary" onclick="toggleCouponStatus(' + i + ')"><i class="fas fa-' + (coupon.active ? 'ban' : 'check') + '"></i> ' + (coupon.active ? 'Deactivate' : 'Activate') + '</button>';
                html += '</td>';
                html += '</tr>';
            }

            html += '</tbody></table></div>';
            $("#couponsList").html(html);
            window.couponsData = coupons;
        }

        function escapeHtml(text) {
            if(!text) return '';
            return text
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;");
        }

        function createCoupon() {
            var couponData = {
                code: $("#code").val(),
                description: $("#description").val(),
                discountType: $("#discountType").val(),
                discountValue: parseFloat($("#discountValue").val()),
                minOrderAmount: parseFloat($("#minOrderAmount").val()) || 0,
                maxDiscount: $("#maxDiscount").val() ? parseFloat($("#maxDiscount").val()) : null,
                usageLimit: parseInt($("#usageLimit").val()) || 0
            };

            console.log("Creating coupon with data:", couponData);

            $.ajax({
                url: '/restaurant/coupons/' + restaurantId + '/add',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(couponData),
                success: function(response) {
                    if(response.statusCode === 200) {
                        showMessage(response.message || "Coupon created successfully!", "success");
                        $("#code").val("");
                        $("#description").val("");
                        $("#discountValue").val("");
                        $("#maxDiscount").val("");
                        loadCoupons();
                    } else {
                        showMessage("Error: " + response.message, "error");
                    }
                },
                error: function(xhr) {
                    console.error("Create coupon error:", xhr);
                    showMessage(xhr.responseJSON?.message || "Failed to create coupon", "error");
                }
            });
        }

        function editCoupon(index) {
            var coupon = window.couponsData[index];
            if(!coupon) return;

            $("#editCouponId").val(coupon.id);
            $("#editCode").val(coupon.code);
            $("#editDescription").val(coupon.description || '');
            $("#editDiscountType").val(coupon.discountType);
            $("#editDiscountValue").val(coupon.discountValue);
            $("#editMinOrderAmount").val(coupon.minOrderAmount || 0);
            $("#editMaxDiscount").val(coupon.maxDiscount || '');
            $("#editUsageLimit").val(coupon.usageLimit || 0);

            $("#editModal").addClass("show");
        }

        function updateCoupon() {
            var couponId = $("#editCouponId").val();
            var couponData = {
                code: $("#editCode").val(),
                description: $("#editDescription").val(),
                discountType: $("#editDiscountType").val(),
                discountValue: parseFloat($("#editDiscountValue").val()),
                minOrderAmount: parseFloat($("#editMinOrderAmount").val()) || 0,
                maxDiscount: $("#editMaxDiscount").val() ? parseFloat($("#editMaxDiscount").val()) : null,
                usageLimit: parseInt($("#editUsageLimit").val()) || 0
            };

            $.ajax({
                url: '/restaurant/coupons/update/' + couponId,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(couponData),
                success: function(response) {
                    if(response.statusCode === 200) {
                        showMessage(response.message || "Coupon updated successfully!", "success");
                        closeModal();
                        loadCoupons();
                    } else {
                        showMessage("Error: " + response.message, "error");
                    }
                },
                error: function(xhr) {
                    console.error("Update error:", xhr);
                    showMessage(xhr.responseJSON?.message || "Failed to update coupon", "error");
                }
            });
        }

        function toggleCouponStatus(index) {
            var coupon = window.couponsData[index];
            if(!coupon) return;

            var newStatus = !coupon.active;
            var action = newStatus ? 'activate' : 'deactivate';

            if(confirm('Are you sure you want to ' + action + ' this coupon?')) {
                $.ajax({
                    url: '/restaurant/coupons/status/' + coupon.id,
                    type: 'POST',
                    data: { active: newStatus },
                    success: function(response) {
                        if(response.statusCode === 200) {
                            showMessage("Coupon " + (newStatus ? 'activated' : 'deactivated') + " successfully!", "success");
                            loadCoupons();
                        } else {
                            showMessage("Error: " + response.message, "error");
                        }
                    },
                    error: function(xhr) {
                        console.error("Toggle error:", xhr);
                        showMessage(xhr.responseJSON?.message || "Failed to update status", "error");
                    }
                });
            }
        }

        function closeModal() {
            $("#editModal").removeClass("show");
        }

        $(window).click(function(event) {
            if(event.target.id === "editModal") {
                closeModal();
            }
        });
    </script>
</body>
</html>