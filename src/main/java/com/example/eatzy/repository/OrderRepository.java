package com.example.eatzy.repository;

import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.model.Order;
import com.example.eatzy.model.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order,Long> {

    List<Order> findByRestaurantIdAndStatusIn(Long restaurantId, List<OrderStatus> accepted);

    List<Order> findByRestaurantId(Long restaurantId);

    Optional<Order> findByIdAndUserId(Long orderId, Long userId);

    List<Order> findAllByUserId(Long userId);
}
