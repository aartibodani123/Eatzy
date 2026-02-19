package com.example.eatzy.dto;

import lombok.Data;

import java.util.Set;

@Data
public class MenuItemRequest {
    private Long id;
    private String name;

    private double price;

    private boolean available;
   private Set<Long> categoryIds;

    private Long restaurantId;

}
