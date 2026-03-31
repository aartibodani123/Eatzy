package com.example.eatzy.dto;

import lombok.Data;

import java.util.List;

@Data
public class CategoryMenuResponseDTO {
    private Long categoryId;
    private String categoryName;
    private List<MenuItemResponseDTO> items;
    private String imageUrl;
}
