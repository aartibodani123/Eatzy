<%-- /WEB-INF/jsp/common-includes.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Global AJAX Setup with Token -->
<script src="${pageContext.request.contextPath}/js/ajax-setup.js"></script>

<!-- Token Manager Utility -->
<script>
    // Token management utility (consistent with your login page)
    const TokenManager = {
        // Store token and user data
        setAuthData: function(data) {
            if (data.token) {
                localStorage.setItem('eatzy_token', data.token);
                localStorage.setItem('eatzy_email', data.email || '');
                localStorage.setItem('eatzy_role', data.role || '');
                console.log('Auth data stored');
                return true;
            }
            return false;
        },

        // Get token
        getToken: function() {
            return localStorage.getItem('eatzy_token');
        },

        // Get user email
        getEmail: function() {
            return localStorage.getItem('eatzy_email');
        },

        // Get user role
        getRole: function() {
            return localStorage.getItem('eatzy_role');
        },

        // Check if authenticated
        isAuthenticated: function() {
            return !!this.getToken();
        },

        // Clear all auth data
        logout: function() {
            localStorage.removeItem('eatzy_token');
            localStorage.removeItem('eatzy_email');
            localStorage.removeItem('eatzy_role');
            window.location.href = '${pageContext.request.contextPath}/login-page';
        },

        // Get auth header object
        getAuthHeader: function() {
            const token = this.getToken();
            return token ? { 'Authorization': 'Bearer ' + token } : {};
        }
    };

    // FIXED: Page load authentication check - ONLY for protected pages
    (function checkAuth() {
        // List of pages that DON'T require authentication (public pages)
        const publicPages = [
            '/login-page',
            '/signup-page',
            '/',
            '/auth/login',
            '/auth/'
        ];

        // Get current path
        const currentPath = window.location.pathname;

        // Check if current page is public
        const isPublicPage = publicPages.some(page =>
            currentPath.includes(page) || currentPath.endsWith(page)
        );

        // Also check for static resources (CSS, JS, images)
        const isStaticResource = currentPath.includes('/css/') ||
                                 currentPath.includes('/js/') ||
                                 currentPath.includes('/images/') ||
                                 currentPath.includes('/WEB-INF/');

        // ONLY redirect if:
        // 1. Not a public page
        // 2. Not a static resource
        // 3. User is not authenticated
        if (!isPublicPage && !isStaticResource && !TokenManager.isAuthenticated()) {
            console.log('Not authenticated and trying to access protected page:', currentPath);
            console.log('Redirecting to login');
            window.location.href = '${pageContext.request.contextPath}/login-page';
        } else {
            console.log('Access allowed to:', currentPath);
        }
    })();
</script>