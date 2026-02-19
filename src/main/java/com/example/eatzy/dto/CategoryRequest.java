package com.example.eatzy.dto;

import com.example.eatzy.model.Restaurant;
import lombok.Data;

@Data
public class CategoryRequest {
    private String name;
    private Long restaurantId;
    private String description;

}
