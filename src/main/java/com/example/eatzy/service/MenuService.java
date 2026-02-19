package com.example.eatzy.service;

import com.example.eatzy.dto.MenuItemRequest;
import org.springframework.stereotype.Service;

@Service
public interface MenuService {
    MenuItemRequest addMenuItem(Long id, MenuItemRequest request, String email);
}
