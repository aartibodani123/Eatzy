package com.example.eatzy.service;

import com.example.eatzy.dto.OrderResponseDTO;

import com.example.eatzy.model.OrderStatus;

import java.util.List;

public interface RestaurantOrderService {
    List<OrderResponseDTO> getIncomingOrders(Long restaurantId);

    List<OrderResponseDTO> getActiveOrders(Long restaurantId);

    OrderResponseDTO acceptOrder(Long orderId, Long restaurantId);

    OrderResponseDTO rejectOrder(Long orderId, Long restaurantId);

    OrderResponseDTO updateStatus(Long orderId, OrderStatus newStatus, Long restaurantId);

    boolean isValidTransition(OrderStatus current, OrderStatus next);


}
