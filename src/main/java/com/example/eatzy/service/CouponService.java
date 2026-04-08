package com.example.eatzy.service;

import com.example.eatzy.dto.CouponRequest;
import com.example.eatzy.model.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CouponService {
    CouponRequest createCoupon(Long restaurantId , CouponRequest dto, User user);

    CouponRequest updateCoupon(Long id, CouponRequest dto,User user);

    CouponRequest toggleCoupon(Long id, boolean active,User user);
    List<CouponRequest> getCouponsByRestaurant(Long restaurantId, User user);
}
