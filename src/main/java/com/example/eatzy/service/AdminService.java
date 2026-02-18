package com.example.eatzy.service;

import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.dto.StatusUpdateDTO;

import java.util.List;

public interface AdminService {
    Long countTotalCustomer();

    RestaurantDTO updateRestaurantStatus(Long id, StatusUpdateDTO statusUpdateDTO);

    Long countTotalRestaurant();

    List<RestaurantDTO> getPendingRestaurants();
}
