package com.example.eatzy.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderItemResponseDTO {
    private Long id;
    private String name;
    private double price;
    private int quantity;
}
