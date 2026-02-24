package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.CartRestaurantMismatchException;
import com.example.eatzy.common.exception.InvalidOperationException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.CartItemResponseDTO;
import com.example.eatzy.dto.CartResponseDTO;
import com.example.eatzy.dto.CartViewResponse;
import com.example.eatzy.model.Cart;
import com.example.eatzy.model.CartItem;
import com.example.eatzy.model.MenuItem;
import com.example.eatzy.repository.CartRepository;
import com.example.eatzy.repository.MenuItemRepository;
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

    @Autowired
    private MenuItemRepository menuItemRepository;

    @Transactional
    public CartResponseDTO addToCart(Long userId, Long restaurantId, Long menuItemId) {

        Cart cart = cartRepository.findByUserId(userId)
                .orElseGet(() -> {
                    Cart c = new Cart();
                    c.setUserId(userId);
                    return c;
                });

        if (cart.getRestaurantId() != null && !cart.getRestaurantId().equals(restaurantId)) {
            throw new CartRestaurantMismatchException("Cart already has items from another restaurant");
        }

        MenuItem menuItem = menuItemRepository.findById(menuItemId)
                .orElseThrow(() -> new ResourceNotFoundException("Menu item not found"));

        if (!menuItem.getRestaurant().getId().equals(restaurantId)) {
            throw new InvalidOperationException("Item does not belong to this restaurant");
        }

        cart.setRestaurantId(restaurantId);

        Optional<CartItem> existing = cart.getItems().stream()
                .filter(i -> i.getMenuItemId().equals(menuItemId))
                .findFirst();

        if (existing.isPresent()) {
            existing.get().setQuantity(existing.get().getQuantity() + 1);
        } else {
            CartItem item = new CartItem();
            item.setMenuItemId(menuItem.getId());
            item.setName(menuItem.getName());
            item.setPrice(menuItem.getPrice());
            item.setQuantity(1);
            item.setCart(cart);
            cart.getItems().add(item);
        }

        double total = cart.getItems().stream()
                .mapToDouble(i -> i.getPrice() * i.getQuantity())
                .sum();

        cart.setTotal(total);

        Cart saved = cartRepository.save(cart);
        return toDto(saved);
    }

    @Override
    public CartViewResponse viewCart(Long userId) {
        Cart cart=cartRepository.findByUserId(userId)
                .orElse(new Cart());
        int totalItems=cart.getItems()
                .stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
        double totalPrice=cart.getItems()
                .stream()
                .mapToDouble(item ->item.getPrice() * item.getQuantity())
                .sum();
        return new CartViewResponse(cart.getItems(),totalItems,totalPrice);

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
