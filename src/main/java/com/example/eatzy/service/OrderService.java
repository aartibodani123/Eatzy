package com.example.eatzy.service;

import com.example.eatzy.model.Order;

public interface OrderService {
    Order placeOrder(Long userId);
}
