package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.entity.Customer;
import org.springframework.security.core.Authentication;

public interface CustomerService {

    void update(Customer customer, Authentication authentication);
    Customer getById(Long id);
}
