package com.example.eatzy.controller.customer;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/customer")
public class CustomerPageController {
    @RequestMapping("/dashboard")
    public String customerDashboard(){
        return "customer-dashboard";
    }

    @RequestMapping("/browse-restaurant")
    public String browseRestaurant(){
        return "browse-restaurant";
    }
    @GetMapping("/area-restaurants")
    public String areaRestaurantsPage(@RequestParam String area, Model model) {
        model.addAttribute("area", area);
        return "area-restaurants";
    }
    @GetMapping("/view-restaurant-menu")
    public String viewRestaurantMenuPage(@RequestParam Long restaurantId, Model model) {
        model.addAttribute("restaurantId", restaurantId);
        return "view-restaurant-menu";
    }

}
