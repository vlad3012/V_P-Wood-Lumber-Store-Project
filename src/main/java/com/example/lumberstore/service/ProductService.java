package com.example.lumberstore.service;

import com.example.lumberstore.entity.Group;
import com.example.lumberstore.entity.Item;
import com.example.lumberstore.repository.GroupRepository;
import com.example.lumberstore.repository.ProductRepository;
import com.example.lumberstore.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService  {
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private GroupRepository groupRepository;
    @Autowired
    private ItemService itemService;
    public boolean addProduct(Product product) {
        Optional<Group> group = groupRepository.findById(product.getGroups().getId());
        Item item = new Item();
        item.setGroup(group.get());
        itemService.save(item);
        product.setItems(item);
        product.setGroups(group.get());
        productRepository.save(product);
        item.setProduct(product);
        itemService.save(item);
        return true;
    }
    public void delete(Long id){
        productRepository.deleteById(id);
    }
    public Optional<Product> findProductById(Integer id) {
        return productRepository.findById(id);
    }
    public List<Product> getAllProduct(){
        return productRepository.findAll();
    }
    public void updateProduct(Product product){
productRepository.save(product);
    }
}
