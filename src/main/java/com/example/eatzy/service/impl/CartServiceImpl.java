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

import java.util.ArrayList;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private MenuItemRepository menuItemRepository;

    @Transactional
    public CartResponseDTO addToCart(Long userId, Long restaurantId, Long menuItemId,Integer quantity) {
        if (quantity == null || quantity < 1) {
            quantity = 1;
        }
        Cart cart = cartRepository.findByUserId(userId)
                .orElseGet(() -> {
                    Cart newCart = new Cart();
                    newCart.setUserId(userId);
                    newCart.setItems(new ArrayList<>());
                    return cartRepository.save(newCart);
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

            int newQuantity = existing.get().getQuantity() + quantity;
            existing.get().setQuantity(newQuantity);
        } else {
            CartItem item = new CartItem();
            item.setMenuItemId(menuItem.getId());
            item.setName(menuItem.getName());
            item.setPrice(menuItem.getPrice());
            item.setQuantity(quantity);
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

    @Override
    public CartViewResponse updateCartItemQuantity(Long userId, Long menuItemId, Integer quantity) {
        if (quantity == null || quantity < 1) {
            throw new InvalidOperationException("Quantity must be at least 1");
        }
        Cart cart =cartRepository.findByUserId(userId)
                .orElseThrow(()->new ResourceNotFoundException("cart not found for user"));
        CartItem cartItem = cart.getItems().stream()
                .filter(item -> item.getMenuItemId().equals(menuItemId))
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Item not found in cart"));
        cartItem.setQuantity(quantity);


        recalculateCartTotal(cart);


        Cart savedCart = cartRepository.save(cart);


        int totalItems = savedCart.getItems()
                .stream()
                .mapToInt(CartItem::getQuantity)
                .sum();

        double totalPrice = savedCart.getItems()
                .stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();


        return new CartViewResponse(savedCart.getItems(), totalItems, totalPrice);
    }

    @Override
    public CartViewResponse removeCartItem(Long userId, Long menuItemId) {
        Cart cart=cartRepository.findByUserId(userId)
                .orElseThrow(()->new ResourceNotFoundException("cart not found for user"));
        boolean removed =cart.getItems().removeIf(item->item.getMenuItemId().equals(menuItemId));
        if(!removed){
            throw new ResourceNotFoundException("Item not found in cart");
        }

        if(cart.getItems().isEmpty()){
            cart.setRestaurantId(null);
        }
        recalculateCartTotal(cart);
        Cart savedCart=cartRepository.save(cart);
        int totalItems = savedCart.getItems()
                .stream()
                .mapToInt(CartItem::getQuantity)
                .sum();

        double totalPrice = savedCart.getItems()
                .stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();


        return new CartViewResponse(savedCart.getItems(), totalItems, totalPrice);
    }

    private void recalculateCartTotal(Cart cart) {
        double total = cart.getItems().stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
        cart.setTotal(total);
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
