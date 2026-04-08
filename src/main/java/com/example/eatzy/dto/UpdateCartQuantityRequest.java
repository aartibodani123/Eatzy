package com.example.eatzy.dto;

import lombok.Data;

@Data
public class UpdateCartQuantityRequest {
    private Long menuItemId;
    private Integer quantity;
}
