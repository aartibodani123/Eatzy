package com.example.eatzy.repository;

import com.example.eatzy.model.MenuItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MenuItemRepository extends JpaRepository<MenuItem,Long> {
    List<MenuItem> findByRestaurantIdAndAvailableTrue(Long id);

}
