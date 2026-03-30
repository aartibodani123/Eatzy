package com.example.eatzy.controller.customer;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.CategoryMenuResponseDTO;
import com.example.eatzy.dto.MenuItemResponseDTO;
import com.example.eatzy.dto.RestaurantResponseDTO;
import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.model.User;
import com.example.eatzy.service.CustomerService;
import com.example.eatzy.service.MenuService;
import com.example.eatzy.service.RestaurantService;
import com.example.eatzy.service.UserGuard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customer")
@CrossOrigin("*")
public class CustomerController {

    @Autowired
    CustomerService customerService;
    @Autowired
    RestaurantService restaurantService;
    @Autowired
    MenuService menuService;
    @Autowired
    private UserGuard userGuard;
    @GetMapping("/getAreas")
    public ResponseEntity<ApiResponse<List<String>>> getAreas(){
        List<String> responce =  customerService.getAreas();
        return ResponseEntity.ok(new ApiResponse<>(200,"List of areas",responce));
    }

    @GetMapping("/restaurants")
    public ResponseEntity<ApiResponse<List<RestaurantResponseDTO>>> getRestaurantsByArea(@RequestParam String area){
        List<RestaurantResponseDTO> response = restaurantService.findRestaurantsByArea(area);
        return ResponseEntity.ok(new ApiResponse<>(200,"Restaurants in " + area,response));
    }

    @GetMapping("/restaurants/{id}/menu")
    public ResponseEntity<ApiResponse<List<CategoryMenuResponseDTO>>> getMenuByRestaurant(@PathVariable Long id){
        List<CategoryMenuResponseDTO> response = menuService.getMenuByRestaurant(id);
        return ResponseEntity.ok(new ApiResponse<>(200,"Menu fetched",response));
    }



}
