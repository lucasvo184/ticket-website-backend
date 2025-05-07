package com.example.bookingTicket.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {

    @Bean
    @Order(0)
    public CorsFilter corsFilter() {
        System.out.println("Initializing CorsFilter...");
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        
        // Allow credentials
        config.setAllowCredentials(true);
        
        // Allowed origins - make sure to include the exact frontend URL
        config.addAllowedOrigin("https://ticket-website-frontend.vercel.app");
        config.addAllowedOrigin("http://localhost:3000");
        
        // Allowed headers
        config.addAllowedHeader("*");
        
        // Allowed methods
        config.addAllowedMethod("*");
        
        // Exposed headers
        config.addExposedHeader("*");
        
        // Max age for preflight requests
        config.setMaxAge(3600L);
        
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}