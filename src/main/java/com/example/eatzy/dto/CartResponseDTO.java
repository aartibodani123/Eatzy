package com.example.eatzy.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CartResponseDTO {
    private Long id;
    private Long userId;
    private Long restaurantId;
    private double total;
    private List<CartItemResponseDTO> items;
}
