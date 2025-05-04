package com.example.bookingTicket.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.bookingTicket.models.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);

}
