package com.example.eatzy.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller

public class PageController {

    @GetMapping("/login-page")
    public String showLoginPage() {
        return "login";
    }
    @GetMapping("/dashboard")
    public String dashboardPage() {
        return "customer-dashboard"; // /WEB-INF/jsp/dashboard.jsp
    }
    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/signup-page")
    public String showSignupPage(){
        return "sign-up";
    }
}
