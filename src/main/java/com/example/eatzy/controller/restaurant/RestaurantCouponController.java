package com.example.eatzy.controller.restaurant;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.CouponRequest;
import com.example.eatzy.model.User;
import com.example.eatzy.service.CouponService;
import com.example.eatzy.service.UserGuard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/restaurant/coupons")
public class RestaurantCouponController {

    @Autowired
    private CouponService couponService;
    @Autowired
    private UserGuard userGuard;

    @PostMapping("/{restaurantId}/add")
    public ResponseEntity<ApiResponse<?>> createCoupon(@PathVariable Long restaurantId ,@RequestBody CouponRequest dto){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateRestaurantOwner(email);
        CouponRequest response = couponService.createCoupon(restaurantId,dto,user);
        return ResponseEntity.ok(new ApiResponse<>(200,"Coupon Created successfully",response));
    }
    @PostMapping("/update/{id}")
    public ResponseEntity<ApiResponse<?>> updateCoupon(@PathVariable Long id,@RequestBody CouponRequest dto){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateRestaurantOwner(email);
        CouponRequest response = couponService.updateCoupon(id,dto,user);
        return ResponseEntity.ok(new ApiResponse<>(200,"Coupon updated",response));
    }

    @PostMapping("/status/{id}")
    public ResponseEntity<ApiResponse<?>> toggleCoupon(@PathVariable Long id,@RequestParam boolean active){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateRestaurantOwner(email);
        CouponRequest response=couponService.toggleCoupon(id, active,user);
        return ResponseEntity.ok(new ApiResponse<>(200,"Coupon updated",response));
    }
    @GetMapping("/list/{restaurantId}")
    public ResponseEntity<ApiResponse<?>> getCouponsByRestaurant(@PathVariable Long restaurantId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        User user = userGuard.validateRestaurantOwner(email);

        List<CouponRequest> coupons = couponService.getCouponsByRestaurant(restaurantId, user);
        return ResponseEntity.ok(new ApiResponse<>(200, "Coupons fetched successfully", coupons));
    }
}
