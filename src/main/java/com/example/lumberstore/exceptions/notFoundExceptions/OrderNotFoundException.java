package com.example.lumberstore.exceptions.notFoundExceptions;

public class OrderNotFoundException extends NotFoundException {

    public OrderNotFoundException(Long id) {
        super("No such order with id "+id);
    }
}
