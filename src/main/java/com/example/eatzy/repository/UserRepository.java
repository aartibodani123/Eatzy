package com.example.eatzy.repository;

import com.example.eatzy.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByEmail(String email);

    Optional<User> findByEmail(String email);


    @Query(nativeQuery = true,value="select count(*) from users where role='CUSTOMER'")
    Long countCustomers();
}
