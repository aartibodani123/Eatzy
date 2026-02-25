package com.example.eatzy.dto;

import com.example.eatzy.model.OrderStatus;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class OrderResponseDTO {
    private Long id;
    private OrderStatus status;
    private double totalAmount;
    private LocalDateTime createdAt;
    private List<OrderItemResponseDTO> items;
}
