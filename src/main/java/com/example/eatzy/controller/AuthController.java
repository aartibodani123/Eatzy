package com.example.eatzy.controller;

import com.example.eatzy.dto.AuthRequest;
import com.example.eatzy.util.JwtUtil;
import jakarta.servlet.http.Cookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody AuthRequest request,jakarta.servlet.http.HttpServletResponse response) {
        try {
            Authentication authentication =
                    authenticationManager.authenticate(
                            new UsernamePasswordAuthenticationToken(
                                    request.getEmail(),
                                    request.getPassword()
                            )
                    );
            UserDetails user = (UserDetails) authentication.getPrincipal();
            String role = user.getAuthorities().iterator().next().getAuthority();
            String token = jwtUtil.generateToken(user.getUsername(), role);
            Cookie cookie = new Cookie("jwt", token);
            cookie.setHttpOnly(true);
            cookie.setSecure(false);
            cookie.setPath("/");
            cookie.setMaxAge(2 * 60 * 60); // 2 hours
            response.addCookie(cookie);
            String redirectUrl;
            switch (role){
                case "ROLE_ADMIN":
                    redirectUrl="/admin/dashboard";
                    break;
                case "ROLE_RESTAURANT_OWNER"  :
                    redirectUrl="/restaurant_owner";
                    break;
                default:
                    redirectUrl="/customer/dashboard";
            }

            return ResponseEntity.ok(Map.of(
                    "role", role,
                    "redirectUrl",redirectUrl
            ));

        }catch (BadCredentialsException e) {
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .body("Invalid email or password");
        }
    }
}
