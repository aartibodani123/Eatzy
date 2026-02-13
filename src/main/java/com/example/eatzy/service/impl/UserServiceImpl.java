package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.ApiException;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository repo;

    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository repo, PasswordEncoder passwordEncoder) {
        this.repo = repo;
        this.passwordEncoder = passwordEncoder;
    }

//    @Autowired
//    private PasswordEncoder passwordEncoder;

    public String signUpCustomer(User c){
        if (repo.existsByEmail(c.getEmail()))
            return "Un Successfull";

        // encode password here
        c.setPassword(passwordEncoder.encode(c.getPassword()));

        repo.save(c);
        return "signup successfull";
    }
}
