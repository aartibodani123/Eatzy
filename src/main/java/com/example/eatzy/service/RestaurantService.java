package com.example.eatzy.service;

import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;

import java.nio.file.AccessDeniedException;

public interface RestaurantService {
    RestaurantDTO  addRestuarantDetails(RestaurantDTO rest, User owner) throws AccessDeniedException;


}
