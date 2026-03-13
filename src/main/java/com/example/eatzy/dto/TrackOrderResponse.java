package com.example.eatzy.dto;

import com.example.eatzy.model.CustomerOrder;

import com.example.eatzy.model.OrderStatus;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class TrackOrderResponse {
    private Long orderId;
    private OrderStatus status;
    private LocalDateTime lastUpdated;
    private double totalAmount;
    private LocalDateTime createdAt;

    public TrackOrderResponse(CustomerOrder order) {
        this.orderId = order.getId();
        this.status = order.getStatus();
        this.lastUpdated = order.getLastUpdated();
        this.totalAmount = order.getTotalAmount();
        this.createdAt=order.getCreatedAt();
    }


}
