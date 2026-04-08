package com.example.eatzy.controller.restaurant;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.MenuItemRequest;
import com.example.eatzy.service.CloudinaryService;
import com.example.eatzy.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/restaurant/image")
public class RestaurantImageController {

    @Autowired
    private CloudinaryService cloudinaryService;

    @Autowired
    private MenuService menuService;


    @PostMapping("/addMenuItem")
    public ResponseEntity<?> addMenuItemWithImage(
            @ModelAttribute MenuItemRequest request,
            Authentication authentication
    ) throws Exception {

        String email = authentication.getName();

        var result = cloudinaryService.uploadImage(
                request.getImageFile(),
                "eatzy/dishes"
        );

        request.setImageUrl(result.get("url"));
        request.setImagePublicId(result.get("publicId"));

        MenuItemRequest item = menuService.addMenuItemWithImage(
                request.getRestaurantId(),
                request,
                email
        );

        return ResponseEntity.ok(
                new ApiResponse<>(200, "Menu item added with image", item)
        );
    }
}
