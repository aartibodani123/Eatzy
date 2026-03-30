package com.example.eatzy.controller.customer;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.dto.*;
import com.example.eatzy.model.Cart;
import com.example.eatzy.model.CustomerOrder;

import com.example.eatzy.model.User;
import com.example.eatzy.service.CartService;
import com.example.eatzy.service.OrderService;
import com.example.eatzy.service.UserGuard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customer")
@CrossOrigin("*")
public class CartController {
    @Autowired
    private CartService cartService;
    @Autowired
    private UserGuard userGuard;
    @Autowired
    private OrderService  orderService;

    @PostMapping("/cart/add")
    public ResponseEntity<ApiResponse<CartResponseDTO>> addToCart(@RequestBody AddToCartRequest request){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        CartResponseDTO response = cartService.addToCart(user.getUserId(),
                request.getRestaurantId(),
                request.getMenuItemId(),
                request.getQuantity()
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
    @PostMapping("/cart/update-quantity")
    public ResponseEntity<ApiResponse<CartViewResponse>> updateCartQuantity(@RequestBody UpdateCartQuantityRequest request){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        CartViewResponse response=cartService.updateCartItemQuantity(user.getUserId(),request.getMenuItemId(),request.getQuantity());
        return ResponseEntity.ok(new ApiResponse<>(200,"Cart quantity update",response));
    }
    @PostMapping("/cart/remove")
    public ResponseEntity<ApiResponse<CartViewResponse>> removeFromCart(@RequestBody RemoveCartItemRequest request){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);

        CartViewResponse response=cartService.removeCartItem(user.getUserId(),request.getMenuItemId());
        return ResponseEntity.ok(new ApiResponse<>(200,"Item removed from cart",response));
    }
    @PostMapping("/orders/place")
    public ResponseEntity<ApiResponse<CustomerOrder>> placeOrder(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        CustomerOrder order=orderService.placeOrder(user.getUserId());
        return ResponseEntity.ok(new ApiResponse<>(200,"Order Placed",order));
    }
    @GetMapping("/orders/get-all-orders")
    public ResponseEntity<ApiResponse<List<TrackOrderResponse>>> allOrders(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user = userGuard.validateCustomer(email);
        List<TrackOrderResponse> response = orderService.allOrders(user.getUserId());

        return ResponseEntity.ok(new ApiResponse<>(200,"All orders",response));

    }
    @GetMapping("/orders/get-all-orders-with-restaurant")
    public ResponseEntity<ApiResponse<List<TrackOrderWithRestaurantResponse>>> allOrdersWithRestaurant() {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userGuard.validateCustomer(email);

        List<TrackOrderWithRestaurantResponse> response =
                orderService.allOrdersWithRestaurant(user.getUserId());

        return ResponseEntity.ok(new ApiResponse<>(200, "All orders with restaurant", response));
    }
    @GetMapping("/orders/{orderId}/track")
    public ResponseEntity<ApiResponse<TrackOrderResponse>> trackOrder(@PathVariable Long orderId){
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userGuard.validateCustomer(email);
        CustomerOrder  order = orderService.getOrderForUser(orderId, user.getUserId());

        return ResponseEntity.ok(new ApiResponse<>(200,"Tracked order",new TrackOrderResponse(order)));

    }
    @PostMapping("/orders/{orderId}/confirm-delivery")
    public ResponseEntity<ApiResponse<?>> confirmDelivery(@PathVariable Long orderId){
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userGuard.validateCustomer(email);
        CustomerOrder  order = orderService.confirmDelivery(orderId,user.getUserId());
        return ResponseEntity.ok(new ApiResponse<>(200,"Confirmed Delivery",new TrackOrderResponse(order)));
    }
    @GetMapping("/orders/{orderId}")
    public OrderResponseDTO getOrderDetails(@PathVariable Long orderId){
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userGuard.validateCustomer(email);
        return orderService.getOrderDetails(orderId,user.getUserId());
    }
}
