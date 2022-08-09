package com.example.lumberstore.services;

import com.example.lumberstore.entity.User;
import com.example.lumberstore.exceptions.UserAlreadyExistsException;
import com.example.lumberstore.repository.UserDaoImp;
import com.example.lumberstore.services.interfaces.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class UserServiceImp implements UserService {

    private final UserDaoImp userDao;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImp(UserDaoImp userDao, PasswordEncoder passwordEncoder) {
        this.userDao = userDao;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User findUserByEmail(String email) {

        return userDao.findUserByEmail(email)
                .orElseThrow(UserAlreadyExistsException::new);
    }

    @Override
    public void registerNewUser(User user) {

        if(userDao.findUserByEmail(user.getEmail()).isPresent()){
            throw new UserAlreadyExistsException();
        } else{
            user.getCustomer().setEmail(user.getEmail());
            user.setRole(userDao.getUserRole());
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            userDao.saveUser(user);
        }
    }
}
