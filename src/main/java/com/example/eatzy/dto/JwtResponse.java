package com.example.eatzy.dto;

import lombok.*;

@Getter
@Setter

public class JwtResponse {
    private String token;
    private String type;
    private String email;
    private String role;
    private String redirectUrl;
    private Long expiresIn;
    private Boolean success;
    private String message;

    public JwtResponse(String token, String type, String email, String role,
                       String redirectUrl, Long expiresIn) {
        this.token = token;
        this.type = type;
        this.email = email;
        this.role = role;
        this.redirectUrl = redirectUrl;
        this.expiresIn = expiresIn;
        this.success = true;
        this.message = "Login successful";
    }
    public JwtResponse(String message, Boolean success) {
        this.message = message;
        this.success = success;
    }
}
