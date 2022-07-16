package com.example.lumberstore.repository;

import com.example.lumberstore.entity.Product;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProductRepository extends CrudRepository<Product,Integer> {
    List<Product> findAllById(int id);
    List<Product> findByName(String name,double price );


}
