package com.example.eatzy.repository;

import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.Status;
import com.example.eatzy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RestaurantRepository extends JpaRepository<Restaurant ,Long> {
    List<Restaurant> findByOwner(User owner);
    @Query(nativeQuery = true,value="select count(*) from restaurants where status='APPROVED'")
    Long countRestaurants();

    List<Restaurant> findByStatus(Status status);
}
