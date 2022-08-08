package com.example.lumberstore.exceptions.notFoundExceptions;

import org.springframework.security.acls.model.NotFoundException;

public class CustomerNotFoundException extends NotFoundException {

    public CustomerNotFoundException(Long id) {

        super("No such customer with id "+id);
    }
}
