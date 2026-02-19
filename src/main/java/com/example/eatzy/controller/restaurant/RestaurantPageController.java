package com.example.eatzy.controller.restaurant;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/restaurant")
public class RestaurantPageController {
    @RequestMapping("/dashboard")
    public String restaurantDashboard(){
        return "restaurant-dashboard";
    }

    @RequestMapping("/profile")
    public String restaurantProfile(){
        return "restaurants/restaurant-profile";
    }
    @RequestMapping("/menu")
    public String restaurantMenu(){
        return "restaurants/restaurant-menu";
    }

    @RequestMapping("/gallery")
    public String restaurantGallery(){
        return "restaurants/restaurant-gallery";
    }

    @RequestMapping("hours")
    public String restaurantHours(){
        return "restaurants/restaurant-hours";
    }

}
