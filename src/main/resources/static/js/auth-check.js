
const token = localStorage.getItem("eatzy_token");

if(!token){
    window.location.href = "/login-page";
}