package com.example.eatzy.common.exception;

public class CartRestaurantMismatchException extends RuntimeException {
    public CartRestaurantMismatchException(String message) {
        super(message);
    }
}
