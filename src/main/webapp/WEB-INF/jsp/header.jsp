<%@ page contentType="text/html;charset=UTF-8" %>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>


    $.ajaxSetup({
        beforeSend: function (xhr) {
            const token = sessionStorage.getItem("jwt");
            if (token) {
                xhr.setRequestHeader("Authorization", "Bearer " + token);
            }
        }
    });
 function loadPage(url) {
    console.log("loadPage called:", url);
     fetch(url, {
         headers: {
             "Authorization": "Bearer " + sessionStorage.getItem("jwt")
         }
     })
     .then(res => {
         if (!res.ok) {
             window.location.href = "${pageContext.request.contextPath}/login-page";
             return;
         }
         return res.text();
     })
     .then(html => {
         document.getElementById("page-content").innerHTML = html;
         window.history.pushState({}, "", url);
     });
 }

    function logout() {
      sessionStorage.removeItem("jwt");
      window.location.href = "${pageContext.request.contextPath}/login-page";
    }
    function navigateWithJwt(url) {
        const token = localStorage.getItem("jwt"); // or from cookie

        fetch(url, {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token
            }
        })
        .then(response => {
            if(response.ok) {
                // If the endpoint returns HTML, you can navigate
                window.location.href = url;
            } else {
                alert('Unauthorized or error occurred');
            }
        })
        .catch(err => console.error(err));
    }

</script>