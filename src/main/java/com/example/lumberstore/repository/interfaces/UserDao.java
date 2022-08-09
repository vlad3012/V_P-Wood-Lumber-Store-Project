package com.example.lumberstore.repository.interfaces;

import com.example.lumberstore.entity.Role;
import com.example.lumberstore.entity.User;

import java.util.Optional;

public interface UserDao {

    User findUserByUsername(String username);
    Optional<User> findUserByEmail(String email);
    void saveUser(User user);
    Role getUserRole();

}
