package com.example.eatzy.dto;

import lombok.Data;
import java.util.List;

@Data
public class RestaurantMenuResponseDTO {
    private Long restaurantId;
    private String restaurantName;
    private List<CategoryMenuResponseDTO> categories;
}