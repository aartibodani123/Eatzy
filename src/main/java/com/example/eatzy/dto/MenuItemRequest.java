package com.example.eatzy.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Set;

@Data
public class MenuItemRequest {
    private Long id;
    private String name;

    private double price;

    private boolean available;
    private List<Long> categoryIds;

    private Long restaurantId;
    private MultipartFile imageFile;
    private String imageUrl;
    private String imagePublicId;
    private String description;

}
