package com.example.bookingTicket.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Ticket Booking API is running!";
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }
} 