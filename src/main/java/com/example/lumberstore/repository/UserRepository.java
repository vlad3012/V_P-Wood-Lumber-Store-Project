package com.example.lumberstore.repository;

import com.example.lumberstore.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {
    User findByLogin(String login);
    List<User> findByUserName(String userName);
    Optional<User> findById(Long id);
//    void deleteByLogin(String login);
    void deleteById(Integer id);
//    void deleteByUsername(String userName);
}
