package com.example.eatzy.model;

import jakarta.persistence.*;
import jdk.jfr.EventType;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Inheritance(strategy = InheritanceType.JOINED)
@Getter
@Setter
@Entity
@Table(name = "base_orders")
public abstract class BaseOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long userId;
    private Long restaurantId;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    private double totalAmount;

    private LocalDateTime createdAt;
    private LocalDateTime lastUpdated;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderItem> items = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.lastUpdated = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.lastUpdated = LocalDateTime.now();
    }


}