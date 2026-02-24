package com.example.eatzy.service.impl;

import com.example.eatzy.model.*;
import com.example.eatzy.repository.CartRepository;
import com.example.eatzy.repository.OrderItemRepository;
import com.example.eatzy.repository.OrderRepository;
import com.example.eatzy.service.OrderService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Transactional
    public Order placeOrder(Long userId){
        Cart cart = cartRepository.findByUserId(userId)
                .orElseThrow(()-> new IllegalStateException("Cart is empty"));
        if(cart.getItems().isEmpty()){
            throw new IllegalStateException("Cart is empty");
        }
        Order order =new Order();
        order.setUserId(userId);
        order.setRestaurantId(cart.getRestaurantId());
        order.setStatus(OrderStatus.PLACED);
        order.setTotalAmount(cart.getTotal());
        order.setCreatedAt(LocalDateTime.now());
        Order savedOrder = orderRepository.save(order);

        for (CartItem ci : cart.getItems()) {
            OrderItem oi = new OrderItem();
            oi.setMenuItemId(ci.getMenuItemId());
            oi.setName(ci.getName());
            oi.setPrice(ci.getPrice());
            oi.setQuantity(ci.getQuantity());
            oi.setOrder(savedOrder);
            orderItemRepository.save(oi);
        }


        cartRepository.delete(cart);
        return savedOrder;

    }
}
