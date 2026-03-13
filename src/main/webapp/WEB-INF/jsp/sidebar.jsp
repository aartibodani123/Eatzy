<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>


<html>
<head>

       <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slidebar.css">
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
       <style>


               .sidebar a {
                    display: flex;
                    align-items: center;
                    padding: 14px 20px;
                    margin: 4px 12px;
                    text-decoration: none;
                    color: #2e2e2e;
                    font-weight: 500;
                    border-radius: 40px;
                    transition: all 0.3s;
                    background: #f9f9fb;
                    border: 1.5px solid transparent;
               }


               .sidebar a i {
                   margin-right: 12px;
                   width: 20px;
                   text-align: center;
                   color: #f97316;
                   font-size: 1.2rem;
               }


               .sidebar a:hover {
                   background-color: #fff6ed;
                   color: #f97316;
               }


               .sidebar a:hover i {
                   transform: scale(1.1);
               }


               .sidebar .title {
                   display: flex;
                   align-items: center;
                   justify-content: center;
                    padding: 30px 20px 0 20px;
                   font-size: 1.5rem;
                   font-weight: bold;
                   border-bottom: 2px solid #f0e4d5;
               }
               .sidebar .title img {
                   width: 200px;
                   height: auto;
                   object-fit: contain;
               }
               .sidebar .title i {
                   font-size: 1.8rem;
                   color: #f97316;
               }


               .logoutBtn {
                   margin-top: 20px;
                   border-top: 1px solid #f0e4d5;
                   padding-top: 15px;
               }


               .logoutBtn i {
                   color: #f97316 !important;
               }


               .hamburger {
                   position: fixed;
                   top: 20px;
                   left: 20px;
                   font-size: 24px;
                   cursor: pointer;
                   z-index: 1000;
                   background: #f97316;
                   color: white;
                   width: 45px;
                   height: 45px;
                   border-radius: 50%;
                   display: flex;
                   align-items: center;
                   justify-content: center;
                   box-shadow: 0 2px 10px rgba(249,115,22,0.3);
               }


               .sidebar {
                   position: fixed;
                   left: -280px;
                   top: 0;
                   width: 280px;
                   height: 100vh;
                   background: white;
                   box-shadow: 2px 0 10px rgba(0,0,0,0.1);
                   transition: left 0.3s ease;
                   z-index: 999;
                   overflow-y: auto;
                   padding: 0;
               }


               .sidebar.open {
                   left: 0;
               }


               /* Fixed Toast Notification Styles */
               #toast-container {
                   position: fixed;
                   top: 20px;
                   right: 20px;
                   z-index: 99999;
               }


               .toast-message {
                   display: flex;
                   align-items: center;
                   gap: 12px;
                   min-width: 300px;
                   padding: 16px 20px;
                   border-radius: 12px;
                   font-size: 14px;
                   font-weight: 500;
                   color: white;
                   box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                   opacity: 1;
                   background: #2e7d32;
               }


               .toast-message.error {
                   background: #b34033;
               }


               .toast-message i {
                   font-size: 20px;
               }


               .toast-close {
                   cursor: pointer;
                   opacity: 0.8;
                   font-size: 18px;
                   background: none;
                   border: none;
                   color: white;
                   margin-left: auto;
               }


               /* Custom Confirmation Modal */
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
                   z-index: 100000;
               }


               .modal-overlay.show {
                   display: flex;
               }


               .modal-content {
                   background: white;
                   border-radius: 24px;
                   padding: 24px;
                   max-width: 400px;
                   width: 90%;
                   box-shadow: 0 20px 40px rgba(0,0,0,0.2);
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


               .modal-icon {
                   width: 60px;
                   height: 60px;
                   background: #fff6ed;
                   border-radius: 50%;
                   display: flex;
                   align-items: center;
                   justify-content: center;
                   margin: 0 auto 16px;
               }


               .modal-icon i {
                   font-size: 30px;
                   color: #f97316;
               }


               .modal-content h3 {
                   font-size: 1.5rem;
                   color: #1e1e1e;
                   margin-bottom: 8px;
                   text-align: center;
               }


               .modal-content p {
                   color: #6b6b6b;
                   margin-bottom: 24px;
                   text-align: center;
               }


               .modal-actions {
                   display: flex;
                   gap: 12px;
                   justify-content: center;
               }


               .modal-btn {
                   padding: 12px 24px;
                   border: none;
                   border-radius: 40px;
                   font-size: 1rem;
                   font-weight: 600;
                   cursor: pointer;
                   transition: all 0.2s;
                   flex: 1;
               }


               .modal-btn.cancel {
                   background: #f9f9fb;
                   color: #2e2e2e;
                   border: 1.5px solid #eaeef2;
               }


               .modal-btn.cancel:hover {
                   background: #fff6ed;
                   border-color: #f97316;
               }


               .modal-btn.confirm {
                   background: #b34033;
                   color: white;
               }


               .modal-btn.confirm:hover {
                   background: #8c2f24;
                   transform: translateY(-2px);
               }


           </style>
</head>
<body>
<div class="hamburger" id="hamburgerBtn">☰</div>


<div class="sidebar" id="sidebar">
   <div class="title">
       <img src="${pageContext.request.contextPath}/images/logo.png" alt="Eatzy Logo">
   </div>


   <!-- Admin Menu -->
   <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
       <a href="/admin/pending-restaurants-page" id="pendingRequestsLink">
           <i class="fas fa-clock"></i> Pending Requests
       </a>
       <a href="/admin/customer-details">
           <i class="fas fa-users"></i> All Customers
       </a>
   </c:if>


   <!-- Owner Menu -->
   <c:if test="${pageContext.request.isUserInRole('RESTAURANT_OWNER')}">
       <a href="/restaurant/menuManagement" class="nav-link">
           <i class="fas fa-book-open"></i> Menu Management
       </a>
       <a href="/restaurant/add/details" class="nav-link">
           <i class="fas fa-plus-circle"></i> Add Details
       </a>
       <a href="/restaurant/get/all/restaurants" class="nav-link">
           <i class="fas fa-clipboard-list"></i> Manage Orders
       </a>
   </c:if>


   <!-- Customer Menu -->
   <c:if test="${pageContext.request.isUserInRole('CUSTOMER')}">
       <a href="/customer/browse-restaurant" id="/browserestaurant">
           <i class="fas fa-search"></i> Browse Restaurant
       </a>
       <a href="/customer/cart-page">
           <i class="fas fa-shopping-cart"></i> My Cart
       </a>
       <a href="/customer/orders">
           <i class="fas fa-truck"></i> Orders
       </a>
   </c:if>


   <!-- Logout (common for all) -->
   <a href="javascript:void(0)" class="logoutBtn">
       <i class="fas fa-sign-out-alt"></i> Logout
   </a>
</div>


<!-- Custom Confirmation Modal -->
<div class="modal-overlay" id="logoutModal">
   <div class="modal-content">
       <div class="modal-icon">
           <i class="fas fa-sign-out-alt"></i>
       </div>
       <h3>Confirm Logout</h3>
       <p>Are you sure you want to logout?</p>
       <div class="modal-actions">
           <button class="modal-btn cancel" id="cancelLogout">Cancel</button>
           <button class="modal-btn confirm" id="confirmLogout">Logout</button>
       </div>
   </div>
</div>


<!-- Toast Container -->
<div id="toast-container"></div>




<script>

       function showToast(msg, type) {
           $('#toast-container').empty();
           const toast = $('<div class="toast-message ' + type + '">' +
               '<i class="fas ' + (type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle') + '"></i>' +
               '<span>' + msg + '</span>' +
               '<button class="toast-close"><i class="fas fa-times"></i></button>' +
           '</div>');




           $('#toast-container').append(toast);




           setTimeout(() => {
               toast.remove();
           }, 2000);


           // Close button
           toast.find('.toast-close').click(function() {
               toast.remove();
           });
       }


       // Show custom confirmation modal
       $(".logoutBtn").click(function () {
           $('#logoutModal').addClass('show');
       });


       // Cancel logout
       $('#cancelLogout').click(function() {
           $('#logoutModal').removeClass('show');
       });


       // Confirm logout
       $('#confirmLogout').click(function() {
           $('#logoutModal').removeClass('show');


           $.ajax({
              url: "/auth/logout",
              type: "POST",
              success: function (response) {
                 showToast("Logged out successfully!", "success");
                 setTimeout(() => {
                     window.location.href = "/login-page";
                 }, 1500);
              },
              error: function (xhr) {
                   let msg = "Error while logging out.";
                   if (xhr.responseJSON && xhr.responseJSON.message) {
                        msg = xhr.responseJSON.message;
                   }
                   showToast(msg, "error");
              }
           });
       });


       // Close modal when clicking outside
       $('#logoutModal').click(function(e) {
           if ($(e.target).hasClass('modal-overlay')) {
               $('#logoutModal').removeClass('show');
           }
       });
</script>


</body>
</html>

