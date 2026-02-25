package com.example.eatzy.service;

import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RestaurantGuard {
    @Autowired
    private RestaurantRepository restaurantRepository;

    public Restaurant validateOwner(Long restaurantId, User user) {
        Restaurant restaurant = restaurantRepository.findById(restaurantId)
                .orElseThrow(() -> new ResourceNotFoundException("Restaurant not found"));

        if (!restaurant.getOwner().getUserId().equals(user.getUserId())) {
            throw new ResourceAccessDeniedException("You do not own this restaurant");
        }

        return restaurant;
    }
}
