package com.example.eatzy.controller;


import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.model.User;
import com.example.eatzy.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@CrossOrigin("*")
public class UserRestController {
    @Autowired
    private UserServiceImpl service;
    @PostMapping("/register")
    public ResponseEntity<ApiResponse<?>> signUpCustomer(@RequestBody User c) {

        String responseMessage = service.signUpCustomer(c);
        return ResponseEntity.ok(new ApiResponse<>(200,"200 ok",responseMessage));
    }
}
