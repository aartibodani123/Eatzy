package com.example.eatzy.service;


import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.model.Role;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserGuard {
    @Autowired
    UserRepository userRepository;
    public User validateCustomer(String email) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (!Role.CUSTOMER.equals(user.getRole())) {
            throw new ResourceAccessDeniedException("Only customers can place orders");
        }



        return user;
    }
}
