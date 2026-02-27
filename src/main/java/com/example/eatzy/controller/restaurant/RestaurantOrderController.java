package com.example.eatzy.controller.restaurant;

import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.dto.OrderResponseDTO;
import com.example.eatzy.model.OrderStatus;
import com.example.eatzy.model.User;
import com.example.eatzy.service.RestaurantGuard;
import com.example.eatzy.service.RestaurantOrderService;
import com.example.eatzy.service.UserGuard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/restaurant")
public class RestaurantOrderController {
    @Autowired
    private RestaurantOrderService orderService;
    @Autowired
    private UserGuard userGuard;
    @Autowired
    private RestaurantGuard restaurantGuard;

    @GetMapping("{restaurantId}/incoming/orders")
    public ResponseEntity<ApiResponse<List<OrderResponseDTO>>> incomingOrders(@PathVariable Long restaurantId){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email=auth.getName();
        User user=userGuard.validateRestaurantOwner(email);
        restaurantGuard.validateOwner(restaurantId,user);

        List<OrderResponseDTO> responseDTO=orderService.getIncomingOrders(restaurantId);
        System.out.println("response size "+responseDTO.size());
        return ResponseEntity.ok(new ApiResponse<>(200,"Incoming orders",orderService.getIncomingOrders(restaurantId)));
    }

    @GetMapping("/{restaurantId}/orders/active")
    public List<OrderResponseDTO> getActiveOrders(@PathVariable Long restaurantId) {

        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userGuard.validateRestaurantOwner(email);

        restaurantGuard.validateOwner(restaurantId, user);

        return orderService.getActiveOrders(restaurantId);
    }

    @PostMapping("/{restaurantId}/orders/{orderId}/accept")
    public OrderResponseDTO acceptOrder(@PathVariable Long restaurantId , @PathVariable Long orderId){
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userGuard.validateRestaurantOwner(email);

        restaurantGuard.validateOwner(restaurantId, user);
        return orderService.acceptOrder(orderId,restaurantId);
    }
    @PostMapping("/{restaurantId}/orders/{orderId}/reject")
    public OrderResponseDTO rejectOrder(@PathVariable Long restaurantId, @PathVariable Long orderId){
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userGuard.validateRestaurantOwner(email);

        restaurantGuard.validateOwner(restaurantId, user);

        return orderService.rejectOrder(orderId, restaurantId);
    }
    @PostMapping("/{restaurantId}/orders/{orderId}/prepare")
    public OrderResponseDTO prepareOrder(@PathVariable Long restaurantId, @PathVariable Long orderId){
        String email=SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userGuard.validateRestaurantOwner(email);
        restaurantGuard.validateOwner(restaurantId, user);
        return orderService.updateStatus(orderId, OrderStatus.PREPARING,restaurantId);

    }
    @PostMapping("/{restaurantId}/orders/{orderId}/ready")
    public OrderResponseDTO markReady(@PathVariable Long restaurantId, @PathVariable Long orderId){
        String email=SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userGuard.validateRestaurantOwner(email);
        restaurantGuard.validateOwner(restaurantId, user);
        return orderService.updateStatus(orderId, OrderStatus.READY,restaurantId);

    }
    @PostMapping("/{restaurantId}/orders/{orderId}/out-for-delivery")
    public OrderResponseDTO outForDelivery(@PathVariable Long restaurantId, @PathVariable Long orderId){
        String email=SecurityContextHolder.getContext().getAuthentication().getName();
        User user=userGuard.validateRestaurantOwner(email);
        restaurantGuard.validateOwner(restaurantId, user);
        return orderService.updateStatus(orderId, OrderStatus.OUT_FOR_DELIVERY,restaurantId);

    }
}
