package com.example.eatzy.dto;

import com.example.eatzy.model.CustomerOrder;
import com.example.eatzy.model.Restaurant;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TrackOrderWithRestaurantResponse extends TrackOrderResponse {

    private Long restaurantId;
    private String restaurantName;

    public TrackOrderWithRestaurantResponse(CustomerOrder order, Restaurant restaurant) {
        super(order);
        this.restaurantId = restaurant.getId();
        this.restaurantName = restaurant.getName();
    }
}
