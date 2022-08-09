package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.additional.enums.OrderStatus;
import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.entity.Order;

import java.util.List;
import java.util.Map;

public interface OrderService {

    List<Order> getOrdersByStatus(OrderStatus status);
    List<Order> getOrdersByCustomer(Customer customer);
    List<Order> getOrders(String filter);
    List<Order> getExpiredOrders();
    void addOrder(Order order);
    Order createOrder(Catalog catalog);
    void updateOrder(Order order);
    void updateOrderCustomer(Long id,Customer customer);
    void updateOrderStatus(Long id, OrderStatus status);
    void deleteOrder(Long id);
    Order getOrderById(Long id);
    Map<String, Long> getOrderStatusCount();
    Long getExpiredOrderCount();

    void prepareForView(Order order, ProductType productType);

}
