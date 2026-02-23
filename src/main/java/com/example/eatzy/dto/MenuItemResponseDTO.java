package com.example.eatzy.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuItemResponseDTO {

    private Long id;
    private String name;
    private double price;
    private String description;
    private boolean available;
}
