package com.example.eatzy.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "customer_orders")
@Getter
@Setter
public class CustomerOrder extends BaseOrder {

    @Column(name = "delivery_address")
    private String deliveryAddress;

    @Column(name = "cancel_reason")
    private String cancelReason;

    private Integer rating;
    private String review;
}
