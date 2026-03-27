package com.example.eatzy.dto;

import com.example.eatzy.model.DiscountType;
import lombok.Data;

@Data
public class CouponRequest {
    private Long id;
    private String code;
    private String description;
    private Double discountValue;
    private DiscountType discountType;

    private Double minOrderAmount;

    private Double maxDiscount;

    private Integer usageLimit;
    private boolean active;

    private Long restaurantId;

}
