package com.example.eatzy.service;

import com.example.eatzy.dto.CartResponseDTO;
import com.example.eatzy.dto.CartViewResponse;
import com.example.eatzy.model.Cart;
import org.springframework.stereotype.Service;

@Service
public interface CartService {

    CartResponseDTO addToCart(Long userId, Long restaurantId, Long menuItemId,Integer quantity);

    CartViewResponse viewCart(Long userId);


    CartViewResponse updateCartItemQuantity(Long userId, Long menuItemId, Integer quantity);

    CartViewResponse removeCartItem(Long userId, Long menuItemId);
}
