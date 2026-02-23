package com.example.eatzy.service.impl;

import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    RestaurantRepository restaurantRepository;
    public List<String> getAreas() {
        List<String> areas = restaurantRepository.findDistinctAreas();
        return areas == null ? List.of() : areas;
    }
}
