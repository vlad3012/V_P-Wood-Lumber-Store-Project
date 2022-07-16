package com.example.lumberstore.service;

import com.example.lumberstore.entity.Product;

public interface ProductService {
    Product getProduct(int id);

    void removeProduct(int id);

    void updateProduct(Product p);

    void createProduct( Product p);

    Iterable< Product> getAllProducts();
}
