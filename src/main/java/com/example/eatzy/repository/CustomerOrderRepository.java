package com.example.eatzy.repository;

import com.example.eatzy.model.CustomerOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CustomerOrderRepository extends JpaRepository<CustomerOrder,Long> {
    Optional<CustomerOrder> findByIdAndUserId(Long id, Long userId);

    @Query("SELECT co FROM CustomerOrder co WHERE co.userId = :userId ORDER BY co.createdAt DESC")
    List<CustomerOrder> findAllByUserId(@Param("userId") Long userId);

    List<CustomerOrder> findByUserIdOrderByCreatedAtDesc(Long userId);
}
