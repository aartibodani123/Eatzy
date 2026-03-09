
$.ajaxSetup({
    beforeSend: function(xhr) {
        const token = localStorage.getItem('eatzy_token');
        if (token) {
            xhr.setRequestHeader('Authorization', 'Bearer ' + token);
            console.log('AJAX: Added Authorization header');
        }
    },
    error: function(xhr, status, error) {
        if (xhr.status === 401) {
            console.log('401 Unauthorized - clearing token');
            localStorage.removeItem('eatzy_token');
            localStorage.removeItem('eatzy_email');
            localStorage.removeItem('eatzy_role');
            window.location.href = '/login-page';
        } else if (xhr.status === 403) {
            console.log('403 Forbidden');
            alert('You do not have permission to perform this action');
        }
    }
});