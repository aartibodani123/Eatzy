package com.example.eatzy.service.impl;

import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.Role;
import com.example.eatzy.model.Status;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.nio.file.AccessDeniedException;
@Service
public class RestaurantServiceImpl implements RestaurantService {
    @Autowired
    RestaurantRepository repo;
    public RestaurantDTO  addRestuarantDetails(RestaurantDTO rest, User owner) throws AccessDeniedException {
        Restaurant restaurant=new Restaurant();
        restaurant.setName(rest.getName());
        restaurant.setArea(rest.getArea());
        restaurant.setLocation(rest.getLocation());
        restaurant.setPhone(rest.getPhone());

        if(owner.getRole() != Role.RESTAURANT_OWNER){
            throw new AccessDeniedException("Only restaurant owners can add restaurants");
        }
        restaurant.setStatus(Status.PENDING);
        restaurant.setActive(false);
        restaurant.setRating(0.0);
        restaurant.setOwner(owner);

        Restaurant saved = repo.save(restaurant);
        RestaurantDTO response = new RestaurantDTO();
        response.setName(saved.getName());
        response.setArea(saved.getArea());
        response.setLocation(saved.getLocation());
        response.setPhone(saved.getPhone());
        return response;



    }
}
