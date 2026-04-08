package com.example.eatzy.repository;

import com.example.eatzy.model.Coupon;
import com.example.eatzy.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CouponRepository extends JpaRepository<Coupon,Long> {
    boolean existsByCodeAndRestaurant(String code, Restaurant restaurant);

    List<Coupon> findByRestaurant(Restaurant restaurant);
}
