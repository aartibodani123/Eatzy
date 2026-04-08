package com.example.eatzy.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "coupons")
@Getter
@Setter
public class Coupon {
    @Id@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;

    private String description;

    @Column(name="discount_value")
    private Double discountValue;

    @Column(name="discount_type")
    @Enumerated(EnumType.STRING)
    private DiscountType discountType;

    @Column(name="min_order_amount")
    private Double minOrderAmount;

    @Column(name="max_discount")
    private Double maxDiscount;

    @Column(name="is_active")
    private boolean active;

    private Integer usageLimit;

    private Integer usedCount;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "restaurant_id")
    private Restaurant restaurant;

}
