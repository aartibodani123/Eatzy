package com.example.eatzy.controller;

import com.example.eatzy.dto.AuthRequest;
import com.example.eatzy.dto.JwtResponse;
import com.example.eatzy.util.JwtUtil;
import com.example.eatzy.util.RoleDashboard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
@CrossOrigin("*")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AuthRequest request) {
        try {
            System.out.println("Login attempt for email: " + request.getEmail());

            // Authenticate user
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            request.getEmail(),
                            request.getPassword()
                    )
            );


            UserDetails user = (UserDetails) authentication.getPrincipal();


            String role = user.getAuthorities().iterator().next().getAuthority();
            String cleanRole = role.replace("ROLE_", "");


            String token = jwtUtil.generateToken(user.getUsername(), role);

            System.out.println("Login successful for: " + request.getEmail());
            System.out.println("Role: " + role);
            System.out.println("Token generated, expires in: " + jwtUtil.getExpirationTime() + " ms");


            String redirectUrl = RoleDashboard.getUrlByRole(role);


            return ResponseEntity.ok(new JwtResponse(
                    token,
                    user.getUsername(),
                    cleanRole,
                    jwtUtil.getExpirationTime()
            ));

        } catch (BadCredentialsException e) {
            System.out.println("Login failed - invalid credentials for: " + request.getEmail());
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of(
                            "error", "Invalid email or password",
                            "success", false
                    ));
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of(
                            "error", "Login failed: " + e.getMessage(),
                            "success", false
                    ));
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(@RequestHeader(value = "Authorization", required = false) String authHeader) {

        System.out.println("User logged out");
        return ResponseEntity.ok(Map.of(
                "message", "Logged out successfully",
                "success", true
        ));
    }

    @GetMapping("/check")
    public ResponseEntity<?> checkAuth(@RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.substring(7);
            if (jwtUtil.validateToken(token)) {
                String email = jwtUtil.extractEmail(token);
                String role = jwtUtil.extractRole(token);
                String cleanRole = role.replace("ROLE_", "");

                String redirectUrl;
                switch (role) {
                    case "ROLE_ADMIN":
                        redirectUrl = "/admin/dashboard";
                        break;
                    case "ROLE_RESTAURANT_OWNER":
                        redirectUrl = "/restaurant/dashboard";
                        break;
                    default:
                        redirectUrl = "/customer/dashboard";
                }

                return ResponseEntity.ok(Map.of(
                        "authenticated", true,
                        "email", email,
                        "role", cleanRole,
                        "redirectUrl", redirectUrl,
                        "expiresIn", jwtUtil.getRemainingValidity(token)
                ));
            } else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Map.of(
                                "authenticated", false,
                                "error", "Invalid or expired token"
                        ));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of(
                            "authenticated", false,
                            "error", "Invalid token"
                    ));
        }
    }
}