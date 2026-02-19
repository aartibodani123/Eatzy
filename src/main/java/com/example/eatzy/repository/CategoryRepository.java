package com.example.eatzy.repository;

import com.example.eatzy.model.Category;
import com.example.eatzy.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category,Long> {
    List<Category> findByRestaurant(Restaurant restaurant);

    Long countByRestaurantId(Long id);
}
