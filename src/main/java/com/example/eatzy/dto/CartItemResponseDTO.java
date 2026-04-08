package com.example.eatzy.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartItemResponseDTO {
    private Long menuItemId;
    private String name;
    private double price;
    private int quantity;
}
