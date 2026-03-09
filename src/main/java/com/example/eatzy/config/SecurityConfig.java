package com.example.eatzy.config;

import com.example.eatzy.filter.JwtAuthFilter;
import com.example.eatzy.util.RoleDashboard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

@Configuration
public class SecurityConfig {
    @Autowired
    private JwtAuthFilter jwtAuthFilter;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth ->auth
                        .requestMatchers(
                                "/",
                                "/auth/**",
                                "/signup-page",
                                "/login-page",
                                "/login",
                                "/js/**",
                                "/css/**",
                                "/images/**",
                                "/jsp/**",
                                "/WEB-INF/**").permitAll()

                        .requestMatchers("/customer/**")
                        .hasRole("CUSTOMER")

                        .requestMatchers("/restaurant/**")  // Changed from /restaurant/**
                        .hasRole("RESTAURANT_OWNER")

                        .requestMatchers("/admin/**")
                        .hasRole("ADMIN")

                        .anyRequest().authenticated()
                )
//                .formLogin(form -> form
//                        .loginPage("/login-page")
//                        .loginProcessingUrl("/auth/login")
//                        .usernameParameter("email")
//                        .passwordParameter("password")
//                        .successHandler(authenticationSuccessHandler())
//                        .failureUrl("/login-page?error=true")
//                        .permitAll()
//                )

                .sessionManagement(session ->
                        session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                )
                .exceptionHandling(ex -> ex
                        .authenticationEntryPoint(new JwtAuthEntryPoint())   // 401
                        .accessDeniedHandler(new JwtAccessDeniedHandler())  // 403
                );

        http.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            String redirectUrl = determineRedirectUrl(authentication);
            response.sendRedirect(redirectUrl);
        };
    }

    private String determineRedirectUrl(org.springframework.security.core.Authentication authentication) {
        return authentication.getAuthorities().stream()
                .map(a -> RoleDashboard.getUrlByRole(a.getAuthority()))
                .filter(url -> url != null)
                .findFirst()
                .orElse("/");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}