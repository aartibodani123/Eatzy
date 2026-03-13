package com.example.eatzy.repository;

import com.example.eatzy.model.OrderStatus;
import com.example.eatzy.model.RestaurantOrder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RestaurantOrderRepository extends JpaRepository<RestaurantOrder,Long> {
    List<RestaurantOrder> findByRestaurantId(Long restaurantId);

    List<RestaurantOrder> findByRestaurantIdAndStatusIn(Long restaurantId, List<OrderStatus> status);

    Optional<RestaurantOrder> findByCustomerOrderId(Long orderId);
}
