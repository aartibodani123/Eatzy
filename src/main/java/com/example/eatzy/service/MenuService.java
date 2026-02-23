package com.example.eatzy.service;

import com.example.eatzy.dto.MenuItemRequest;
import com.example.eatzy.dto.MenuItemResponseDTO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface MenuService {
    MenuItemRequest addMenuItem(Long id, MenuItemRequest request, String email);

    List<MenuItemResponseDTO> getMenuByRestaurant(Long id);
}
