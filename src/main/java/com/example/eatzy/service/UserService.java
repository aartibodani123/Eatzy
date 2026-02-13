package com.example.eatzy.service;

import com.example.eatzy.model.User;
import org.springframework.stereotype.Service;

@Service
public interface UserService {
    String signUpCustomer(User c);
}
