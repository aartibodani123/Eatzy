package com.example.eatzy.controller.customer;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.dto.AddToCartRequest;
import com.example.eatzy.dto.CartResponseDTO;
import com.example.eatzy.dto.CartViewResponse;
import com.example.eatzy.model.Cart;
import com.example.eatzy.model.Order;
import com.example.eatzy.model.User;
import com.example.eatzy.service.CartService;
import com.example.eatzy.service.OrderService;
import com.example.eatzy.service.UserGuard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/customer")
public class CartController {
    @Autowired
    private CartService cartService;
    @Autowired
    private UserGuard userGuard;
    @Autowired
    private OrderService orderService;

    @PostMapping("/cart/add")
    public ResponseEntity<ApiResponse<CartResponseDTO>> addToCart(@RequestBody AddToCartRequest request){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        CartResponseDTO response = cartService.addToCart(user.getUserId(),
                request.getRestaurantId(),
                request.getMenuItemId()
        );
        return ResponseEntity.ok(new ApiResponse<>(200,"Item added to cart",response));
    }
    @GetMapping("/cart/view")
    public ResponseEntity<ApiResponse<CartViewResponse>> viewCart(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        CartViewResponse response = cartService.viewCart(user.getUserId());
        return ResponseEntity.ok(new ApiResponse<>(200,"Cart fetched",response));
    }
    @PostMapping("/orders/place")
    public ResponseEntity<ApiResponse<Order>> placeOrder(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        Order order=orderService.placeOrder(user.getUserId());
        return ResponseEntity.ok(new ApiResponse<>(200,"Order Placed",order));
    }
}
