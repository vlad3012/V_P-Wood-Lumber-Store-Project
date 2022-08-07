package com.example.lumberstore.service;

import com.example.lumberstore.entity.Item;
import com.example.lumberstore.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ItemService {
    @Autowired
    private ItemRepository itemRepository;

    public List<Item> allItem() {
        return itemRepository.findAll();
    }

    public Item loadItemById(Long id) {
        Item item = itemRepository.findByItemId(id);
        return item;
    }

    public boolean save(Item item) {
        itemRepository.save(item);
        return true;
    }
    public boolean deleteItemById(Long id){
        itemRepository.deleteById(id);
        return true;
    }
}
