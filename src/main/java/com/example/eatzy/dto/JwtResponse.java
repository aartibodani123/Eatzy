package com.example.eatzy.dto;

import lombok.*;

@Getter
@Setter

public class JwtResponse {
    private String token;

    private String role;
    private String username;
    private Long expiresIn;


    public JwtResponse(String token, String email, String role, Long expiresIn) {
        this.token = token;
        this.username=email;
        this.role = role;
        this.expiresIn = expiresIn;


    }


}