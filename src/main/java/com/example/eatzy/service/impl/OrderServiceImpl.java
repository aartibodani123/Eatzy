package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.OrderItemResponseDTO;
import com.example.eatzy.dto.OrderResponseDTO;
import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.dto.TrackOrderWithRestaurantResponse;
import com.example.eatzy.model.*;
import com.example.eatzy.repository.*;
import com.example.eatzy.service.OrderService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CustomerOrderRepository customerOrderRepository;

    @Autowired
    private RestaurantOrderRepository restaurantOrderRepository;

    @Autowired
    private BaseOrderRepository baseOrderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Transactional
    public CustomerOrder  placeOrder(Long userId){
        Cart cart = cartRepository.findByUserId(userId)
                .orElseThrow(()-> new IllegalStateException("Cart is empty"));
        if(cart.getItems().isEmpty()){
            throw new IllegalStateException("Cart is empty");
        }
        // CUSTOMER ORDER
        CustomerOrder customerOrder = new CustomerOrder();
        customerOrder.setUserId(userId);
        customerOrder.setRestaurantId(cart.getRestaurantId());
        customerOrder.setStatus(OrderStatus.PLACED);
        customerOrder.setTotalAmount(cart.getTotal());

        CustomerOrder savedCustomerOrder = customerOrderRepository.save(customerOrder);


        // RESTAURANT ORDER
        RestaurantOrder restaurantOrder = new RestaurantOrder();
        restaurantOrder.setUserId(savedCustomerOrder.getUserId());
        restaurantOrder.setRestaurantId(savedCustomerOrder.getRestaurantId());
        restaurantOrder.setStatus(savedCustomerOrder.getStatus());
        restaurantOrder.setTotalAmount(savedCustomerOrder.getTotalAmount());
        restaurantOrder.setCustomerOrder(savedCustomerOrder);
        restaurantOrderRepository.save(restaurantOrder);



        for (CartItem ci : cart.getItems()) {

            OrderItem oi = new OrderItem();

            oi.setMenuItemId(ci.getMenuItemId());
            oi.setName(ci.getName());
            oi.setPrice(ci.getPrice());
            oi.setQuantity(ci.getQuantity());
            oi.setOrder(savedCustomerOrder);

            orderItemRepository.save(oi);
        }

        cartRepository.delete(cart);

        return savedCustomerOrder;

    }

    public CustomerOrder getOrderForUser(Long orderId, Long userId) {

        return customerOrderRepository.findByIdAndUserId(orderId, userId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

    }
    public CustomerOrder confirmDelivery(Long orderId, Long userId) {

        CustomerOrder order = customerOrderRepository.findByIdAndUserId(orderId, userId)
                .orElseThrow(() -> new RuntimeException("Order not found or not yours"));

        if (order.getStatus() != OrderStatus.OUT_FOR_DELIVERY) {
            throw new IllegalStateException("Cannot confirm delivery yet");
        }

        order.setStatus(OrderStatus.DELIVERED);

        CustomerOrder saved = customerOrderRepository.save(order);

        // sync restaurant order
        RestaurantOrder ro = restaurantOrderRepository.findByCustomerOrderId(orderId)
                .orElseThrow(() -> new RuntimeException("Restaurant order not found"));

        ro.setStatus(OrderStatus.DELIVERED);
        restaurantOrderRepository.save(ro);

        return saved;
    }

    @Override
    public List<TrackOrderResponse> allOrders(Long userId) {

        List<CustomerOrder> orders = customerOrderRepository.findAllByUserId(userId);

        return orders.stream()
                .map(this::toDTO)
                .toList();
    }
    @Override
    public List<TrackOrderWithRestaurantResponse> allOrdersWithRestaurant(Long userId) {

        List<CustomerOrder> orders = customerOrderRepository.findAllByUserId(userId);


        Set<Long> restaurantIds = orders.stream()
                .map(CustomerOrder::getRestaurantId)
                .collect(Collectors.toSet());


        Map<Long, Restaurant> restaurantMap = restaurantRepository.findAllById(restaurantIds)
                .stream()
                .collect(Collectors.toMap(Restaurant::getId, r -> r));

        return orders.stream().map(order -> {

            Restaurant restaurant = restaurantMap.get(order.getRestaurantId());

            if (restaurant == null) {
                throw new ResourceNotFoundException("Restaurant not found for order " + order.getId());
            }

            return new TrackOrderWithRestaurantResponse(order, restaurant);

        }).toList();
    }
    @Override
    public OrderResponseDTO getOrderDetails(Long orderId, Long userId) {
        BaseOrder order=baseOrderRepository.findById(orderId)
                .orElseThrow(()->new ResourceNotFoundException("order not found"));
        if(!order.getUserId().equals(userId)){
            throw new ResourceAccessDeniedException("Not your Order");
        }
        OrderResponseDTO response=new OrderResponseDTO();
        response.setId(order.getId());
        response.setStatus(order.getStatus());
        response.setTotalAmount(order.getTotalAmount());
        response.setCreatedAt(order.getCreatedAt());
        response.setUserId(order.getUserId());

        List<OrderItemResponseDTO> items = order.getItems()
                .stream()
                .map(this::mapItem)
                .toList();

        response.setItems(items);

        return response;

    }
    private OrderItemResponseDTO mapItem(OrderItem item) {

        OrderItemResponseDTO dto = new OrderItemResponseDTO();

        dto.setId(item.getMenuItemId());
        dto.setName(item.getName());
        dto.setPrice(item.getPrice());
        dto.setQuantity(item.getQuantity());

        return dto;
    }


    public TrackOrderResponse toDTO(CustomerOrder order) {

        return new TrackOrderResponse(order);

    }
}
