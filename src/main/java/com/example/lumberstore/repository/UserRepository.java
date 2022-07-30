package com.example.lumberstore.repository;

import com.example.lumberstore.entity.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User,Integer> {
    User findById(Long id);
    User findByName(String name);
    User findByFirstname(String firstName);
    User findByLastname(String lastName);
    User findByEmail(String email);
    void deleteById(int id);
    void deleteByUsername(String userName);
}
