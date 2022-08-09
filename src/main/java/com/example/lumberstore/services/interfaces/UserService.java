package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.entity.User;

public interface UserService {

    User findUserByEmail(String email);
    void registerNewUser(User user);

}
