package com.example.eatzy.service;

import com.example.eatzy.dto.CategoryRequest;
import com.example.eatzy.model.Category;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CategoryService {

    List<Category> getCategoriesForRestaurant(String email, Long restaurantId);
    public Category addCategoriesForRestaurant(String email, CategoryRequest category);
}
