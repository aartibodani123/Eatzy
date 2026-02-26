package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.OrderItemResponseDTO;
import com.example.eatzy.dto.OrderResponseDTO;
import com.example.eatzy.model.Order;
import com.example.eatzy.model.OrderStatus;
import com.example.eatzy.repository.OrderRepository;
import com.example.eatzy.service.RestaurantOrderService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class RestaurantOrderServiceImpl implements RestaurantOrderService {
    @Autowired
    private OrderRepository orderRepository;

    public List<OrderResponseDTO> getIncomingOrders(Long restaurantId) {

        List<Order> orders= orderRepository.findByRestaurantId(restaurantId);
        return orders.stream()
                .map(this::toDto)
                .toList();

    }


    public List<OrderResponseDTO> getActiveOrders(Long restaurantId) {
        List<Order> orders= orderRepository.findByRestaurantIdAndStatusIn(
                restaurantId,
                List.of(OrderStatus.ACCEPTED,OrderStatus.PREPARING,OrderStatus.READY)
        );
        return orders.stream()
                .map(this::toDto)
                .toList();
    }

    public OrderResponseDTO acceptOrder(Long orderId, Long restaurantId) {
        return updateStatus(orderId,OrderStatus.ACCEPTED,restaurantId);
    }


    public OrderResponseDTO rejectOrder(Long orderId, Long restaurantId) {
        return updateStatus(orderId,OrderStatus.CANCELLED,restaurantId);
    }


    public OrderResponseDTO updateStatus(Long orderId, OrderStatus newStatus, Long restaurantId) {
        Order order=orderRepository.findById(orderId)
                .orElseThrow(()-> new ResourceNotFoundException("Order not found"));
        if(!order.getRestaurantId().equals(restaurantId)){
            throw  new ResourceAccessDeniedException("Not your order");
        }
        if(!isValidTransition(order.getStatus(),newStatus)){
            throw new RuntimeException("Invalid status transition");
        }
        order.setStatus(newStatus);
        orderRepository.save(order);
        return toDto(order);
    }


    public boolean isValidTransition(OrderStatus current, OrderStatus next) {
        switch (current) {
            case PLACED:
                return next == OrderStatus.ACCEPTED || next == OrderStatus.CANCELLED;

            case ACCEPTED:
                return next == OrderStatus.PREPARING;

            case PREPARING:
                return next == OrderStatus.READY;

            case READY:
                return next == OrderStatus.OUT_FOR_DELIVERY;
            case OUT_FOR_DELIVERY:
                return next== OrderStatus.DELIVERED;

            default:
                return false;
        }
    }


    public OrderResponseDTO toDto(Order order) {
        OrderResponseDTO dto = new OrderResponseDTO();
        dto.setId(order.getId());
        dto.setStatus(order.getStatus());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setUserId(order.getUserId());
        dto.setCreatedAt(order.getCreatedAt());

        List<OrderItemResponseDTO> items = order.getItems().stream().map(item -> {
            OrderItemResponseDTO i = new OrderItemResponseDTO();
            i.setId(item.getId());
            i.setName(item.getName());
            i.setPrice(item.getPrice());
            i.setQuantity(item.getQuantity());
            return i;
        }).toList();

        dto.setItems(items);
        return dto;
    }
}
