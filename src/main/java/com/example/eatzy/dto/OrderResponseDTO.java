package com.example.eatzy.dto;

import com.example.eatzy.model.OrderStatus;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.config.annotation.web.oauth2.login.UserInfoEndpointDsl;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class OrderResponseDTO {
    private Long id;
    private OrderStatus status;
    private double totalAmount;
    private LocalDateTime createdAt;
    private Long userId;
    private List<OrderItemResponseDTO> items;
}
