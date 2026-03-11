package com.example.eatzy.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.Arrays;

@Entity
@Table(name = "restaurant_orders")
@Getter
@Setter
public class RestaurantOrder extends BaseOrder {
    @Column(name = "preparation_time")
    private Integer preparationTime;

    @Column(name="rejection_reason")
    private String rejectionReason;

    @Column(name="commission_amount")
    private Double commissionAmount;

    @Column(name = "customer_order_id")
    private Long customerOrderId;

}