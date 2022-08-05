package com.example.lumberstore.repository;

import com.example.lumberstore.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product,Integer> {
    void deleteById(Long id);

    Optional<Product> findById(Long id);
    // CrudRepository
//    List<Product> findAllById(int id);
//    List<Product> findByName(String name,double price );


}
