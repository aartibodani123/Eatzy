package com.example.eatzy.service;

import com.example.eatzy.dto.CartResponseDTO;
import com.example.eatzy.model.Cart;
import org.springframework.stereotype.Service;

@Service
public interface CartService {

    CartResponseDTO addToCart(Long userId, Long restaurantId, Long menuItemId, String name, double price);
}
