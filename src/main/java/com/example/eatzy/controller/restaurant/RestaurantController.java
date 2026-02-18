package com.example.eatzy.controller.restaurant;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.CustomerUserDetailsService;
import com.example.eatzy.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.nio.file.AccessDeniedException;

@RestController
@RequestMapping("/restaurant")
public class RestaurantController {
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private UserRepository userRepository;
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
}
