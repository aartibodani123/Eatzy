package com.example.eatzy.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddToCartRequest {
    private Long restaurantId;
    private Long menuItemId;
    private Integer quantity;

}
