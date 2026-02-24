package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.CartRestaurantMismatchException;
import com.example.eatzy.dto.CartItemResponseDTO;
import com.example.eatzy.dto.CartResponseDTO;
import com.example.eatzy.model.Cart;
import com.example.eatzy.model.CartItem;
import com.example.eatzy.repository.CartRepository;
import com.example.eatzy.service.CartService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Transactional
    public CartResponseDTO addToCart(Long userId,Long restaurantId , Long menuItemId,String name,double price){
        Cart cart=cartRepository.findByUserId(userId)
                .orElseGet(()-> {
                    Cart c=new Cart();
                    c.setUserId(userId);
                    return c;
                });
        if(cart.getRestaurantId() != null && !cart.getRestaurantId().equals(restaurantId)){
            throw new CartRestaurantMismatchException("Cart already has items from another restaurant");
        }
        cart.setRestaurantId(restaurantId);
        Optional<CartItem> existing = cart.getItems().stream()
                .filter(i -> i.getMenuItemId().equals(menuItemId))
                .findFirst();
        if (existing.isPresent()) {
            existing.get().setQuantity(existing.get().getQuantity()+1);
        }else{
            CartItem item =new CartItem();
            item.setMenuItemId(menuItemId);
            item.setName(name);
            item.setPrice(price);
            item.setQuantity(1);
            item.setCart(cart);
            cart.getItems().add(item);
        }
        double total=cart.getItems().stream()
                .mapToDouble(i -> i.getPrice() * i.getQuantity())
                .sum();
        cart.setTotal(total);
        cartRepository.save(cart);
        return toDto(cart);

    }
    public static CartResponseDTO toDto(Cart cart) {
        CartResponseDTO dto = new CartResponseDTO();
        dto.setId(cart.getId());
        dto.setUserId(cart.getUserId());
        dto.setRestaurantId(cart.getRestaurantId());
        dto.setTotal(cart.getTotal());

        dto.setItems(
                cart.getItems().stream().map(item -> {
                    CartItemResponseDTO i = new CartItemResponseDTO();
                    i.setMenuItemId(item.getMenuItemId());
                    i.setName(item.getName());
                    i.setPrice(item.getPrice());
                    i.setQuantity(item.getQuantity());
                    return i;
                }).collect(Collectors.toList())
        );

        return dto;
    }
}
