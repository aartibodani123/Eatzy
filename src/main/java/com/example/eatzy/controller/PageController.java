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
    @GetMapping("/")
    public String home() {
        return "home-page";
    }

    @GetMapping("/signup-page")
    public String showSignupPage(){
        return "sign-up";
    }

    @GetMapping("/restaurant/add-restaurant")
    public String addRestaurantPage(){
        return "addRestaurant";
    }

    @GetMapping("/admin/pending-restaurants-page")
    public String pendingRestaurantsPage() {
        return "pending-restaurants"; // pending-restaurants.jsp
    }
}
