package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.InvalidOperationException;
import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.CategoryRequest;
import com.example.eatzy.model.Category;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.CategoryRepository;
import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    UserRepository userRepository;
    @Autowired
    RestaurantRepository restaurantRepository;
    @Autowired
    CategoryRepository categoryRepository;
    public List<Category> getCategoriesForRestaurant(String email, Long restaurantId) {
        User owner=userRepository.findByEmail(email)
                .orElseThrow(()->new ResourceAccessDeniedException("Access Denied"));
        Restaurant restaurant=restaurantRepository.findByIdAndOwner(restaurantId,owner)
                .orElseThrow(()->new InvalidOperationException("Invalid Restaurant"));
        return categoryRepository.findByRestaurant(restaurant);
    }


    public Category addCategoriesForRestaurant(String email, CategoryRequest request) {
        User owner=userRepository.findByEmail(email)
                .orElseThrow(()->new RuntimeException("Owner not found"));
        Restaurant restaurant=restaurantRepository.findByIdAndOwner(request.getRestaurantId(),owner)
                .orElseThrow(()->new RuntimeException("Restaurant not found"));
        Category category=new Category();
        category.setName(request.getName());
        category.setDescription(request.getDescription());
        category.setRestaurant(restaurant);
        return categoryRepository.save(category);
    }
}
