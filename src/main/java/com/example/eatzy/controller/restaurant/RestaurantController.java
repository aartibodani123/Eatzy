package com.example.eatzy.controller.restaurant;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.CategoryRequest;
import com.example.eatzy.dto.MenuItemRequest;
import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.model.Category;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.CategoryService;
import com.example.eatzy.service.CustomerUserDetailsService;
import com.example.eatzy.service.MenuService;
import com.example.eatzy.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.nio.file.AccessDeniedException;
import java.util.List;

@RestController
@RequestMapping("/restaurant")
public class RestaurantController {
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MenuService menuService;
    @Autowired
    private CategoryService categoryService;
    @PostMapping("/addRestaurant")
    public ResponseEntity<ApiResponse<RestaurantDTO>> addRestaurantDetails(
            @RequestBody RestaurantDTO rest) throws AccessDeniedException {

        // Get logged-in user from SecurityContext
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || auth.getPrincipal().equals("anonymousUser")) {
            return ResponseEntity.status(401).body(new ApiResponse<>(401, "Access Denied", null));
        }

        String email = auth.getName();  // gets logged-in username (email)

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found")); // cast to your User entity
        RestaurantDTO saved = restaurantService.addRestuarantDetails(rest, user);

        ApiResponse<RestaurantDTO> apiResponse = new ApiResponse<>(200,"Restaurant Added", saved);
        return ResponseEntity.ok(apiResponse);
    }

    @PostMapping("/add/MenuItem")
    public ResponseEntity<?> addMenuItem(
            @RequestBody MenuItemRequest request,
            Authentication authentication
            ){
        String email=authentication.getName();
        Long id= request.getRestaurantId();
        MenuItemRequest item =menuService.addMenuItem(id,request,email);
        return ResponseEntity.ok(new ApiResponse<MenuItemRequest>(200,"Menu item added",item));

    }
    @GetMapping("/{restaurantId}/categories")
    public ResponseEntity<?> getCategories(Authentication authentication,@PathVariable Long restaurantId){
        List<Category> categories=categoryService.getCategoriesForRestaurant(authentication.getName(),restaurantId);
        return ResponseEntity.ok(new ApiResponse<List<Category>>(200,"Categories listed",categories));

    }

    @PostMapping("/add/category")
    public ResponseEntity<?> addCategory(Authentication authentication, @RequestBody CategoryRequest request){
        String email=authentication.getName();
        Category response=categoryService.addCategoriesForRestaurant(email,request);
        return ResponseEntity.ok(new ApiResponse<Category>(200,"Category Added",response));
    }


}
