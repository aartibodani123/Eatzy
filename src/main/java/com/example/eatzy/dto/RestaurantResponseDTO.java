package com.example.eatzy.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestaurantResponseDTO {
    private Long id;
    private String name;
    private String area;
    private String location;
    private String imageUrl;
}
