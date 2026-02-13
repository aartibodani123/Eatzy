package com.example.eatzy.repository;

import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RestaurantRepository extends JpaRepository<Restaurant ,Long> {
    List<Restaurant> findByOwner(User owner);

}
