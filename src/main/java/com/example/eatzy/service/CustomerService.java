package com.example.eatzy.service;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CustomerService {
    List<String> getAreas();
}
