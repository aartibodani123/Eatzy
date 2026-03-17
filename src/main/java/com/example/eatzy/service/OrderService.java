package com.example.eatzy.service;

import com.example.eatzy.dto.OrderResponseDTO;
import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.dto.TrackOrderWithRestaurantResponse;
import com.example.eatzy.model.CustomerOrder;


import java.util.List;

public interface OrderService {
    CustomerOrder placeOrder(Long userId);
    CustomerOrder getOrderForUser(Long orderId,Long userId);
    CustomerOrder confirmDelivery(Long orderId, Long userId);

    List<TrackOrderResponse> allOrders(Long userId);

    OrderResponseDTO getOrderDetails(Long orderId, Long userId);
    List<TrackOrderWithRestaurantResponse> allOrdersWithRestaurant(Long userId);
}
