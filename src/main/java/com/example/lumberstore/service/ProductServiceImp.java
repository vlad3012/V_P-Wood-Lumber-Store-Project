package com.example.lumberstore.service;

import com.example.lumberstore.repository.ProductRepository;
import com.example.lumberstore.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

public class ProductServiceImp implements ProductService {
    @Autowired
    ProductRepository productRepository;

    @Transactional
    @Override
    public Product getProduct(int id) {
        return productRepository.findById(id).get();
    }

    @Transactional
    @Override
    public void removeProduct(int id) {
        productRepository.deleteById(id);
    }

    @Transactional
    @Override
    public void updateProduct(Product p) {
        productRepository.save(p);
    }

    @Transactional
    @Override
    public void createProduct(Product p) {
        productRepository.save(p);
    }

    @Override
    public Iterable<Product> getAllProducts() {
        return productRepository.findAll();
    }
}
