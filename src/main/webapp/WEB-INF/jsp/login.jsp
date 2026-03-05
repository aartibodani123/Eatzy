<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Login | Eatzy — food delivery</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login-page.css">
   <style>
       .btn-loading {
           opacity: 0.7;
           cursor: not-allowed;
       }
   </style>
</head>
<body class="auth-page">
   <div class="eatzy-login-wrapper">
       <div class="auth-panel">
           <div class="auth-card">
               <h2>Welcome Back 👋</h2>
               <p class="subtitle">Sign in to your Eatzy account</p>


               <c:if test="${not empty message}">
                   <p class="success-msg">${message}</p>
               </c:if>
               <c:if test="${not empty error}">
                   <p class="error-msg">${error}</p>
               </c:if>


               <form id="loginForm">
                   <div class="input-group">
                       <input type="email" id="email" placeholder="Email address" required>
                   </div>
                   <div class="input-group">
                       <input type="password" id="password" placeholder="Password" required>
                   </div>


                   <button type="submit" id="loginBtn" class="primary-btn full-width">
                       Sign In
                   </button>
               </form>


               <p class="signup-text">
                   New user?
                   <a href="${pageContext.request.contextPath}/signup-page">
                       Create an account
                   </a>
               </p>
           </div>
       </div>


       <div class="brand-panel">
           <!-- brand panel content -->
       </div>
   </div>


   <script>
const TokenManager = {
   setToken: function(token) {
       sessionStorage.setItem('eatzy_token', token);
       console.log('Token saved:', token.substring(0, 20) + '...');
   },
   getToken: function() {
       return sessionStorage.getItem('eatzy_token');
   },
   setUserInfo: function(email, role) {
       sessionStorage.setItem('eatzy_email', email);
       sessionStorage.setItem('eatzy_role', role);
       console.log('User info saved:', email, role);
   },
   clearToken: function() {
       sessionStorage.removeItem('eatzy_token');
       sessionStorage.removeItem('eatzy_email');
       sessionStorage.removeItem('eatzy_role');
       console.log('Token cleared');
   }
};


document.getElementById("loginForm").addEventListener("submit", function(e) {
   e.preventDefault();
   e.stopPropagation();


   const email = document.getElementById("email").value;
   const password = document.getElementById("password").value;
   const loginBtn = document.getElementById("loginBtn");
   const originalText = loginBtn.innerText;


   // Create or get debug div
   let debugDiv = document.getElementById('debug-info');
   if (!debugDiv) {
       debugDiv = document.createElement('div');
       debugDiv.id = 'debug-info';
       debugDiv.style.cssText = 'margin-top:20px;padding:15px;background:#f0f0f0;border:2px solid red;border-radius:5px;font-family:monospace;white-space:pre-wrap;max-height:300px;overflow:auto;';
       document.querySelector('.auth-card').appendChild(debugDiv);
   }


   function addDebug(message, isError = false) {
       const line = document.createElement('div');
       line.style.color = isError ? 'red' : 'green';
       line.style.margin = '5px 0';
       line.style.padding = '3px';
       line.style.borderBottom = '1px solid #ccc';
       line.textContent = new Date().toLocaleTimeString() + ': ' + message;
       debugDiv.appendChild(line);
       console.log(message);
   }


   addDebug('1. Login attempt for: ' + email);


   loginBtn.innerText = "Signing in...";
   loginBtn.disabled = true;


   fetch("${pageContext.request.contextPath}/auth/login", {
       method: "POST",
       headers: { "Content-Type": "application/json" },
       body: JSON.stringify({ email, password })
   })
   .then(response => {
       addDebug('2. Response status: ' + response.status);
       addDebug('3. Response type: ' + response.headers.get('content-type'));


       if (!response.ok) {
           return response.text().then(text => {
               addDebug('4. Error response text: ' + text, true);
               throw new Error('HTTP ' + response.status);
           });
       }
       return response.json();
   })
   .then(data => {
       addDebug('5. Response data received');
       addDebug('6. Data keys: ' + Object.keys(data).join(', '));
       addDebug('7. Token present: ' + (data.token ? 'YES' : 'NO'));


       if (data.token) {
           addDebug('8. Token length: ' + data.token.length);


           // Save token and user info
           TokenManager.setToken(data.token);
           TokenManager.setUserInfo(data.email, data.role);


           addDebug('9. Token and user info saved to sessionStorage');


           // Verify token
           const savedToken = TokenManager.getToken();
           addDebug('10. Verified token in storage: ' + (savedToken ? 'YES' : 'NO'));


           addDebug('11. LOGIN SUCCESSFUL! Redirecting to dashboard...');


           // Automatic redirect
           window.location.href = data.redirectUrl || '/customer/dashboard';


       } else {
           addDebug('8. ERROR: No token in response!', true);
           addDebug('9. Full response: ' + JSON.stringify(data), true);
       }
   })
   .catch(error => {
       addDebug('ERROR: ' + error.message, true);
   })
   .finally(() => {
       loginBtn.innerText = originalText;
       loginBtn.disabled = false;
   });
});
   </script>
</body>
</html>

