package com.example.lumberstore.exceptions.notFoundExceptions;

import org.springframework.security.acls.model.NotFoundException;

public class CatalogNotFoundException extends NotFoundException {

    public CatalogNotFoundException(Long id) {
        super("No such catalog item with id " + id);
    }
}
