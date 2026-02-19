package com.example.eatzy.common.exception;

public class ResourceAccessDeniedException extends RuntimeException{
    private String message;
    public ResourceAccessDeniedException(){

    }
    public ResourceAccessDeniedException(String message){
        super(message);
        this.message=message;

    }
}
