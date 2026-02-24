package com.example.eatzy.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name="orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long userId;
    private Long restaurantId;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    private double totalAmount;

    private LocalDateTime createdAt;
}
