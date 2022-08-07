package com.example.lumberstore.service;

import com.example.lumberstore.entity.Role;
import com.example.lumberstore.repository.UserRepository;
import com.example.lumberstore.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        User user = userRepository.findByLogin(login);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public User loadUserByLogin(String login) {
        return userRepository.findByLogin(login);
    }

    public List<User> findByUserName(String name) {
        return userRepository.findByUserName(name);
    }

    public Optional<User> loadUserById(Long id) {
        return userRepository.findById(id);
    }

    public boolean saveUser(User user) {
        User userFromDB = userRepository.findByLogin(user.getEmail());
        if (userFromDB != null) {
            return false;
        }
        user.setRole((new Role(1L,"Users")));
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return true;
    }

    public void save(User user) {
        userRepository.save(user);

    }

    public List<User> allUsers() {
        return (List<User>) userRepository.findAll();
    }

    public void deleteUserById(int id) {
        userRepository.deleteById(id);
    }
}
