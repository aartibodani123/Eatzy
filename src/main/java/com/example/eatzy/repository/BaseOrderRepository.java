package com.example.eatzy.repository;

import com.example.eatzy.model.BaseOrder;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BaseOrderRepository extends JpaRepository<BaseOrder,Long> {
}
