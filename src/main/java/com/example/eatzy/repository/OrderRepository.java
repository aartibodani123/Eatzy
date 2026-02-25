package com.example.eatzy.repository;

import com.example.eatzy.model.Order;
import com.example.eatzy.model.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order,Long> {
    List<Order> findByRestaurantIdAndStatus(Long restaurantId, OrderStatus orderStatus);

    List<Order> findByRestaurantIdAndStatusIn(Long restaurantId, List<OrderStatus> accepted);
}
