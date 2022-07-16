package com.example.lumberstore.repository;

import com.example.lumberstore.entity.User;
import org.springframework.data.repository.CrudRepository;

public interface PersonRepository extends CrudRepository<User,Integer> {
    User findById(int id);
    User findByName(String name);
    User findByFirstname(String firstName);
    User findByLastname(String lastName);
    User findByEmail(String email);
}
