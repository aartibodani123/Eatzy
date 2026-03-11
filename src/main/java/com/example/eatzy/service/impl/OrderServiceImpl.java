package com.example.eatzy.service.impl;

import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.model.*;
import com.example.eatzy.repository.*;
import com.example.eatzy.service.OrderService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CustomerOrderRepository customerOrderRepository;

    @Autowired
    private RestaurantOrderRepository restaurantOrderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Transactional
    public CustomerOrder  placeOrder(Long userId){
        Cart cart = cartRepository.findByUserId(userId)
                .orElseThrow(()-> new IllegalStateException("Cart is empty"));
        if(cart.getItems().isEmpty()){
            throw new IllegalStateException("Cart is empty");
        }
        // CUSTOMER ORDER
        CustomerOrder customerOrder = new CustomerOrder();
        customerOrder.setUserId(userId);
        customerOrder.setRestaurantId(cart.getRestaurantId());
        customerOrder.setStatus(OrderStatus.PLACED);
        customerOrder.setTotalAmount(cart.getTotal());

        CustomerOrder savedCustomerOrder = customerOrderRepository.save(customerOrder);


        // RESTAURANT ORDER
        RestaurantOrder restaurantOrder = new RestaurantOrder();
        restaurantOrder.setUserId(savedCustomerOrder.getUserId());
        restaurantOrder.setRestaurantId(savedCustomerOrder.getRestaurantId());
        restaurantOrder.setStatus(savedCustomerOrder.getStatus());
        restaurantOrder.setTotalAmount(savedCustomerOrder.getTotalAmount());
        restaurantOrder.setCustomerOrderId(savedCustomerOrder.getId());

        restaurantOrderRepository.save(restaurantOrder);



        for (CartItem ci : cart.getItems()) {

            OrderItem oi = new OrderItem();

            oi.setMenuItemId(ci.getMenuItemId());
            oi.setName(ci.getName());
            oi.setPrice(ci.getPrice());
            oi.setQuantity(ci.getQuantity());
            oi.setOrder(savedCustomerOrder);

            orderItemRepository.save(oi);
        }

        cartRepository.delete(cart);

        return savedCustomerOrder;

    }

    public CustomerOrder getOrderForUser(Long orderId, Long userId) {

        return customerOrderRepository.findByIdAndUserId(orderId, userId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

    }
    public CustomerOrder confirmDelivery(Long orderId, Long userId) {

        CustomerOrder order = customerOrderRepository.findByIdAndUserId(orderId, userId)
                .orElseThrow(() -> new RuntimeException("Order not found or not yours"));

        if (order.getStatus() != OrderStatus.OUT_FOR_DELIVERY) {
            throw new IllegalStateException("Cannot confirm delivery yet");
        }

        order.setStatus(OrderStatus.DELIVERED);

        return customerOrderRepository.save(order);
    }

    @Override
    public List<TrackOrderResponse> allOrders(Long userId) {

        List<CustomerOrder> orders = customerOrderRepository.findAllByUserId(userId);

        return orders.stream()
                .map(this::toDTO)
                .toList();
    }


    public TrackOrderResponse toDTO(CustomerOrder order) {

        return new TrackOrderResponse(order);

    }
}
