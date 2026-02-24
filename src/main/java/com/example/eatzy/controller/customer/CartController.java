package com.example.eatzy.controller.customer;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.AddToCartRequest;
import com.example.eatzy.dto.CartResponseDTO;
import com.example.eatzy.model.Cart;
import com.example.eatzy.model.Order;
import com.example.eatzy.service.CartService;
import com.example.eatzy.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/customer")
public class CartController {
    @Autowired
    private CartService cartService;

    @Autowired
    private OrderService orderService;

    @PostMapping("/cart/add")
    public ResponseEntity<ApiResponse<CartResponseDTO>> addToCart(@RequestBody AddToCartRequest request){
        CartResponseDTO Response = cartService.addToCart(request.getUserId(),
                request.getRestaurantId(),
                request.getMenuItemId(),
                request.getName(),
                request.getPrice()
        );
        return ResponseEntity.ok(new ApiResponse<>(200,"Item added to cart",Response));

    }
    @PostMapping("/orders/place")
    public ResponseEntity<ApiResponse<Order>> placeOrder(@RequestParam Long userId){
        Order order=orderService.placeOrder(userId);
        return ResponseEntity.ok(new ApiResponse<>(200,"Order Placed",order));
    }
}
