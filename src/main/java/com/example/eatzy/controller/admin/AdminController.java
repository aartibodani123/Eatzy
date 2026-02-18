package com.example.eatzy.controller.admin;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.dto.StatusUpdateDTO;
import com.example.eatzy.repository.RestaurantRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import com.example.eatzy.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    AdminService adminService;
    @RequestMapping("/dashboard")
    public String adminDashboard(){
        return "admin-dashboard";
    }

    @GetMapping("/countUsers")
    @ResponseBody
    public Map<String,Long> countTotalCustomer(){
        long count =adminService.countTotalCustomer();
        return Map.of("totalCustomers",count);

    }
    @GetMapping("/countRestaurants")
    @ResponseBody
    public Map<String,Long> countTotalRestaurant(){
        long count=adminService.countTotalRestaurant();
        return Map.of("totalRestaurant",count);
    }
    @PostMapping("/restaurant/status")
    public ResponseEntity<ApiResponse<List<RestaurantDTO>>> updateRestaurantStatus(
            @RequestBody StatusUpdateDTO statusUpdateDTO) {

        Long id = statusUpdateDTO.getId();

        // Update the restaurant
        RestaurantDTO updated = adminService.updateRestaurantStatus(id, statusUpdateDTO);

        // Wrap the single object in a list
        List<RestaurantDTO> resultList = Collections.singletonList(updated);
        System.out.println(resultList+"------------------------------------------");
        return ResponseEntity.ok(new ApiResponse<>(200, "Status updated", resultList));
    }

    @GetMapping("/pending-restaurants")
    @ResponseBody
    public Map<String, Object> getPendingRestaurants() {
        List<RestaurantDTO> pending = adminService.getPendingRestaurants();

        Map<String, Object> res = new HashMap<>();
        res.put("data", pending);
        return res;
    }




}
