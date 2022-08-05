package com.example.lumberstore.repository;

import com.example.lumberstore.entity.Group;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GroupRepository extends JpaRepository<Group, Integer> {
    Optional<Group> findById(Integer id);
    Optional<Group> findGroupByName(String name);
    @Override
    void deleteById(Integer id);
}
