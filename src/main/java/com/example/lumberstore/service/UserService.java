package com.example.lumberstore.service;

import com.example.lumberstore.entity.Role;
import com.example.lumberstore.repository.UserRepository;
import com.example.lumberstore.repository.ProductRepository;
import com.example.lumberstore.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    UserRepository userRepository;
    @Autowired
    ProductRepository productRepository;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByName(username);

        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return user;
    }
    public User findUserById(Integer userId) {
        Optional<User> userFromDb = userRepository.findById(userId);
        return userFromDb.orElse(new User());
    }

    public List<User> allUsers() {
        return (List<User>) userRepository.findAll();
    }


    public boolean deleteUser(Integer userId) {
        if (userRepository.findById(userId).isPresent()) {
            userRepository.deleteById(userId);
            return true;
        }
        return false;
    }
    public boolean deleteUserById(Integer id) {
        userRepository.deleteById(id);
        return true;
    }
    public void editRoleById(Long id) {
        Optional<User> user = Optional.ofNullable(userRepository.findById(id));
        Set<Role> newRole = new HashSet<>();
        newRole.add(new Role(1L, "ROLE_USER"));
        user.get().setRoles(newRole);
        userRepository.save(user.get());
    }


}
