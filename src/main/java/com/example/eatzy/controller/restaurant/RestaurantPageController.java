package com.example.eatzy.controller.restaurant;

import com.example.eatzy.dto.RestaurantResponseDTO;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.UserGuard;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import com.example.eatzy.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/restaurant")

public class RestaurantPageController {
    @Autowired
    RestaurantService restaurantService;

    @Autowired
    private UserGuard userGuard;
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

    @RequestMapping("/hours")
    public String restaurantHours(){
        return "restaurants/restaurant-hours";
    }

    @GetMapping("/menuManagement")
    public String menuManagement(){
        return "restaurants/add-menuCategory";
    }

    @GetMapping("/get/all/restaurants")
    public String selectRestaurant( Model model){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateRestaurantOwner(email);
        List<RestaurantResponseDTO> restaurants=restaurantService.getRestaurantsByOwner(user.getUserId());
        model.addAttribute("restaurants",restaurants);
        System.out.println("Restaurants found: " + restaurants.size());
        return "select-restaurant";
    }
    @GetMapping("/{restaurantId}/dashboard")
    public String openDashboard(@PathVariable Long restaurantId, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateRestaurantOwner(email);
        restaurantService.getOwnedRestaurant(restaurantId, user.getUserId());

        model.addAttribute("restaurantId", restaurantId);

        return "pending-orders";
    }

}
