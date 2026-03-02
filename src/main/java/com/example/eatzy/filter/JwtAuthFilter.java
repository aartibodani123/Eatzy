package com.example.eatzy.filter;

import com.example.eatzy.service.CustomerUserDetailsService;
import com.example.eatzy.util.JwtUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

@Component
public class JwtAuthFilter extends OncePerRequestFilter {
    @Autowired
    private JwtTokenUtil jwtTokenUtil;  // Your JWT utility to validate and extract the token

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String token = request.getHeader("Authorization");
        if (token != null && token.startsWith("Bearer ")) {
            token = token.substring(7);  // Remove the "Bearer " prefix
            try {
                if (jwtTokenUtil.isTokenValid(token)) {  // Check if the token is valid
                    String username = jwtTokenUtil.getUsernameFromToken(token);
                    List<GrantedAuthority> authorities = jwtTokenUtil.getAuthoritiesFromToken(token);  // Get roles from token
                    UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(username, null, authorities);
                    SecurityContextHolder.getContext().setAuthentication(authentication);  // Set the authentication context
                }
            } catch (Exception e) {
                logger.error("JWT authentication error", e);
            }
        }
        filterChain.doFilter(request, response);  // Proceed with the filter chain
    }
}
//public class JwtAuthFilter extends OncePerRequestFilter {
//
//    @Autowired
//    private JwtUtil jwtUtil;
//
//    @Autowired
//    private CustomerUserDetailsService userDetailsService;
//
//    @Override
//    protected void doFilterInternal(
//            HttpServletRequest request,
//            HttpServletResponse response,
//            FilterChain filterChain
//    ) throws ServletException, IOException {
//
//        String authHeader = request.getHeader("Authorization");
//        String token = null;
//        String email = null;
//
//        // ✅ Read JWT from Authorization: Bearer <token>
//        if (authHeader != null && authHeader.startsWith("Bearer ")) {
//            token = authHeader.substring(7);
//        }
//
//        if (token != null) {
//            email = jwtUtil.extractEmail(token);
//        }
//
//        if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
//
//            UserDetails     userDetails = userDetailsService.loadUserByUsername(email);
//
//            if (jwtUtil.validateToken(token)) {
//                UsernamePasswordAuthenticationToken auth =
//                        new UsernamePasswordAuthenticationToken(
//                                userDetails,
//                                null,
//                                userDetails.getAuthorities()
//                        );
//
//                auth.setDetails(
//                        new WebAuthenticationDetailsSource().buildDetails(request)
//                );
//
//                SecurityContextHolder.getContext().setAuthentication(auth);
//
//                System.out.println("Username from token: " + email);
//                System.out.println("Authorities: " + userDetails.getAuthorities());
//            }
//        }
//
//        filterChain.doFilter(request, response);
//    }
//}