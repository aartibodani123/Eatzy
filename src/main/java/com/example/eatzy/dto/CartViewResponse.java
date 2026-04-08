package com.example.eatzy.dto;

import com.example.eatzy.model.CartItem;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@Getter
@Setter
public class CartViewResponse {

    private List<CartItem> items;
    private int totalItems;
    private double totalPrice;
}
