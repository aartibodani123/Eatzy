package com.example.eatzy.service;

import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.model.Order;

import java.util.List;

public interface OrderService {
    Order placeOrder(Long userId);
    Order getOrderForUser(Long orderId,Long userId);
    Order confirmDelivery(Long orderId, Long userId);

    List<TrackOrderResponse> allOrders(Long userId);
}
