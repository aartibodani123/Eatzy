package com.example.eatzy.filter;

import com.example.eatzy.service.CustomerUserDetailsService;
import com.example.eatzy.util.JwtUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
@Component
public class JwtAuthFilter extends OncePerRequestFilter {
    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private CustomerUserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {


        String token = null;
        String email = null;
        System.out.println("Cookies received:");
        // 🔥 Extract JWT from cookie
        if (request.getCookies() != null) {
            System.out.println("Token from cookie: " + token);

            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("jwt")) {
                    token = cookie.getValue();
                }
            }

        }

        if (token != null) {
            email = jwtUtil.extractEmail(token);
        }
        if(email != null &&
                SecurityContextHolder.getContext().getAuthentication() == null){
            UserDetails userDetails =
                    userDetailsService.loadUserByUsername(email);
            if(jwtUtil.validateToken(token)){

                UsernamePasswordAuthenticationToken auth =
                        new UsernamePasswordAuthenticationToken(
                                userDetails,
                                null,
                                userDetails.getAuthorities()
                        );
                auth.setDetails(
                        new WebAuthenticationDetailsSource()
                                .buildDetails(request)
                );

                SecurityContextHolder.getContext()
                        .setAuthentication(auth);

                System.out.println("Username from token: " + email);
                System.out.println("Authorities: " + userDetails.getAuthorities());
            }
        }


        filterChain.doFilter(request,response);
    }
}
