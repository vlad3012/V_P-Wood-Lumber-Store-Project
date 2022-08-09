package com.example.lumberstore.repository.interfaces;

import  com.example.lumberstore.entity.Customer;

import java.util.Optional;

public interface CustomerDao {

    void saveOrUpdate(Customer customer);
    Optional<Customer> getById(Long id);
}
