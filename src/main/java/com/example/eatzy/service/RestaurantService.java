package com.example.eatzy.service;

import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.dto.RestaurantResponseDTO;

import com.example.eatzy.model.User;
import java.util.List;

import java.nio.file.AccessDeniedException;

public interface RestaurantService {
    RestaurantDTO  addRestuarantDetails(RestaurantDTO rest, User owner) throws AccessDeniedException;


    List<RestaurantResponseDTO> findRestaurantsByArea(String area);
}
