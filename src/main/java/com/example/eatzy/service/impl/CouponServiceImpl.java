package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.CouponRequest;
import com.example.eatzy.model.Coupon;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.CouponRepository;
import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.service.CouponService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service

public class CouponServiceImpl implements CouponService {
    @Autowired
    private RestaurantRepository restaurantRepository;
    @Autowired
    private CouponRepository couponRepository;
    @Transactional
    public CouponRequest createCoupon(Long restaurantId , CouponRequest dto, User user) {

        Restaurant restaurant=restaurantRepository.findById(restaurantId)
                .orElseThrow(()->new ResourceNotFoundException("Restaurant not found"));

        System.out.println(restaurant.getName());
        System.out.println(restaurant.getOwner().getUserId());



        if(!Objects.equals(user.getUserId(), restaurant.getOwner().getUserId())) {
            throw new ResourceAccessDeniedException("Not Your Restaurant");
        }

        if(couponRepository.existsByCodeAndRestaurant(dto.getCode(), restaurant)) {
            throw new IllegalArgumentException("Coupon already exists");
        }

        if(dto.getDiscountValue() <= 0) {
            throw new IllegalArgumentException("Discount must be positive");
        }

        if(dto.getUsageLimit() < 0) {
            throw new IllegalArgumentException("Invalid usage limit");
        }

        Coupon coupon = getCoupon(dto, restaurant);

        couponRepository.save(coupon);
        return mapToResponse(coupon);
    }

    private static Coupon getCoupon(CouponRequest dto, Restaurant restaurant) {
        Coupon coupon = new Coupon();
        coupon.setCode(dto.getCode());
        coupon.setDescription(dto.getDescription());
        coupon.setDiscountValue(dto.getDiscountValue());
        coupon.setDiscountType(dto.getDiscountType());
        coupon.setMinOrderAmount(dto.getMinOrderAmount());
        coupon.setMaxDiscount(dto.getMaxDiscount());
        coupon.setUsageLimit(dto.getUsageLimit());
        coupon.setUsedCount(0);
        coupon.setActive(true);
        coupon.setRestaurant(restaurant);
        return coupon;
    }

    @Transactional
    public CouponRequest updateCoupon(Long id, CouponRequest dto,User user) {
        Coupon coupon = couponRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Coupon not found"));

        if(!coupon.getRestaurant().getOwner().getUserId().equals(user.getUserId())) {
            throw new ResourceAccessDeniedException("Not your coupon");
        }

        coupon.setDescription(dto.getDescription());
        coupon.setDiscountValue(dto.getDiscountValue());
        coupon.setDiscountType(dto.getDiscountType());
        coupon.setMinOrderAmount(dto.getMinOrderAmount());
        coupon.setMaxDiscount(dto.getMaxDiscount());
        coupon.setUsageLimit(dto.getUsageLimit());

        couponRepository.save(coupon);

        return mapToResponse(coupon);
    }

    @Override
    public CouponRequest toggleCoupon(Long id, boolean active,User user) {
        Coupon coupon = couponRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Coupon not found"));

        if(!coupon.getRestaurant().getOwner().getUserId().equals(user.getUserId())) {
            throw new ResourceAccessDeniedException("Not your coupon");
        }
        coupon.setActive(active);
        couponRepository.save(coupon);
        return mapToResponse(coupon);

    }

    @Override
    public List<CouponRequest> getCouponsByRestaurant(Long restaurantId, User user) {
        Restaurant restaurant = restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> new ResourceNotFoundException("Restaurant not found"));

        if(!restaurant.getOwner().getUserId().equals(user.getUserId())) {
            throw new ResourceAccessDeniedException("Not your restaurant");
        }

        List<Coupon> coupons = couponRepository.findByRestaurant(restaurant);
        return coupons.stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    private CouponRequest mapToResponse(Coupon coupon) {
        CouponRequest dto = new CouponRequest();
        dto.setId(coupon.getId());
        dto.setCode(coupon.getCode());
        dto.setDescription(coupon.getDescription());
        dto.setDiscountValue(coupon.getDiscountValue());
        dto.setDiscountType(coupon.getDiscountType());
        dto.setMinOrderAmount(coupon.getMinOrderAmount());
        dto.setMaxDiscount(coupon.getMaxDiscount());
        dto.setUsageLimit(coupon.getUsageLimit());
        dto.setActive(coupon.isActive());
        return dto;
    }
}
