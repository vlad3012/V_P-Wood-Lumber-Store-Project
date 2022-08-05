package com.example.lumberstore.repository;

import com.example.lumberstore.entity.Item;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ItemRepository extends JpaRepository<Item, Long> {
    Item findByItemId(Long itemId);
}
