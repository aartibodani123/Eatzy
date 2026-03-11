package com.example.eatzy.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "order_items")
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long menuItemId;

    private String name;

    private double price;
    private int quantity;

    @ManyToOne
    @JoinColumn(name="order_id")
    private BaseOrder order;
}
