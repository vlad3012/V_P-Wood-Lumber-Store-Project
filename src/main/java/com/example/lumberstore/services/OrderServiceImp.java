package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.OrderStatus;
import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.entity.Order;
import com.example.lumberstore.entity.OrderItem;
import com.example.lumberstore.entity.components.Wood;
import com.example.lumberstore.exceptions.notFoundExceptions.OrderAccessDeniedException;
import com.example.lumberstore.exceptions.notFoundExceptions.OrderNotFoundException;
import com.example.lumberstore.repository.interfaces.OrderDao;
import com.example.lumberstore.services.interfaces.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class OrderServiceImp implements OrderService {

    private final OrderDao orderDao;
    private final LocalDateTimeHandler dateTimeHandler;

    @Autowired
    public OrderServiceImp(OrderDao orderDao, LocalDateTimeHandler dateTimeHandler) {

        this.orderDao = orderDao;
        this.dateTimeHandler = dateTimeHandler;
    }

    @Override
    @Transactional
    public List<Order> getOrdersByStatus(OrderStatus status) {

        return orderDao.getOrdersByStatus(status);
    }

    @Override
    @Transactional
    public List<Order> getOrdersByCustomer(Customer customer) {

        return orderDao.getOrdersByCustomer(customer);
    }

    @Override
    @Transactional
    public List<Order> getOrders(String filter) {

        switch (filter) {
            case "active":
                return getOrdersByStatus(OrderStatus.ACTIVE);
            case "paid":
                return getOrdersByStatus(OrderStatus.PAID);
            case "expired":
                return getExpiredOrders();
            case "closed":
                return getOrdersByStatus(OrderStatus.CLOSED);
            default:
                return orderDao.getOrders();
        }

    }

    @Override
    public List<Order> getExpiredOrders() {

        return orderDao.getExpiredOrders();
    }

    @Override
    @Transactional
    public void addOrder(Order order) {

        LocalDateTime creationDate = LocalDateTime.now();
        LocalDateTime deadLine = dateTimeHandler.addWorkDays(creationDate, 7);

        order.setCreationDate(creationDate);
        order.setDeadline(deadLine);
        order.setStatus(OrderStatus.ACTIVE);

        orderDao.saveOrUpdateOrder(order);
    }

    @Override
    @Transactional
    public void updateOrder(Order order) {

        Order orderToUpdate = getOrderById(order.getId());
        orderToUpdate.setProductType(order.getProductType());
        orderToUpdate.setCost(order.getCost());
        orderToUpdate.setWoodList(order.getWoodList());
        orderToUpdate.setAccessories(order.getAccessories());


        orderDao.saveOrUpdateOrder(orderToUpdate);
    }

    @Override
    @Transactional
    public void updateOrderCustomer(Long id, Customer customer) {

        Order orderToUpdate = getOrderById(id);
        orderToUpdate.setCustomer(customer);

        orderDao.saveOrUpdateOrder(orderToUpdate);
    }

    @Override
    @Transactional
    public void updateOrderStatus(Long id, OrderStatus status) throws OrderAccessDeniedException {

        Order order = getOrderById(id);

        if (order.getStatus() == OrderStatus.CLOSED || order.getStatus() == OrderStatus.CART) {
            throw new OrderAccessDeniedException();
        }

        order.setStatus(status);
        orderDao.saveOrUpdateOrder(order);

    }

    @Override
    @Transactional
    public void deleteOrder(Long id) {

        Order order = getOrderById(id);
        orderDao.deleteOrder(order);

    }

    @Override
    @Transactional
    public Order getOrderById(Long id) throws OrderNotFoundException {

        return orderDao.getOrderById(id)
                .orElseThrow(() -> new OrderNotFoundException(id));
    }

    @Override
    @Transactional
    public Map<String, Long> getOrderStatusCount() {
        return orderDao.getOrderStatusCount();
    }

    @Override
    @Transactional
    public Long getExpiredOrderCount() {
        return orderDao.getExpiredOrdersCount();
    }

    @Override
    public Order createOrder(Catalog catalog) {

        Order order = new Order();

        order.setProductType(catalog.getProductType());
        order.setWoodList(catalog.getWoodList());

        Set<OrderItem> orderItems = catalog.getAccessories().stream()
                .map(catalogItem ->
                        new OrderItem(catalogItem.getAmount(), order, catalogItem.getComponent()))
                .collect(Collectors.toSet());

        order.setAccessories(orderItems);

        return order;
    }

    @Override
    public void prepareForView(Order order, ProductType productType) {

        List<Wood> woodList = new ArrayList<>();
        woodList.add(new Wood());

        order.setWoodList(new HashSet<>(woodList));

        if (productType != null) {
            order.setProductType(productType);
        }
    }
}
