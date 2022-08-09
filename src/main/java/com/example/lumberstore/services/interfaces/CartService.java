package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.entity.Order;

import java.util.List;

public interface CartService {

    List<Order> getOrders(Customer customer);
    Order getOrderById(Long id);
    void addOrder(Order order, Customer customer);
    void deleteOrder(Long id);
    void submitCartOrder(Order order, boolean pay);
}
