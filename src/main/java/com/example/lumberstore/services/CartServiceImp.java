package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.OrderStatus;
import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.entity.Order;
import com.example.lumberstore.exceptions.notFoundExceptions.OrderNotFoundException;
import com.example.lumberstore.repository.interfaces.OrderDao;
import com.example.lumberstore.services.interfaces.CalculatorService;
import com.example.lumberstore.services.interfaces.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CartServiceImp implements CartService {

    private final OrderDao orderDao;
    private final LocalDateTimeHandler dateTimeHandler;
    private final CalculatorService calculatorService;

    @Autowired
    public CartServiceImp(OrderDao orderDao, LocalDateTimeHandler dateTimeHandler, CalculatorService calculatorService) {

        this.orderDao = orderDao;
        this.dateTimeHandler = dateTimeHandler;
        this.calculatorService = calculatorService;
    }

    @Override
    @Transactional
    public List<Order> getOrders(Customer customer) {
        return orderDao.getCartOrders(OrderStatus.CART, customer);
    }

    @Override
    @Transactional
    public Order getOrderById(Long id) {
        return orderDao.getCartOrderById(id)
                .orElseThrow(() -> new OrderNotFoundException(id));
    }

    @Override
    @Transactional
    public void addOrder(Order order, Customer customer) {

        order.setCustomer(customer);
        order.setCost(calculatorService.calculatePrice(order));
        order.setStatus(OrderStatus.CART);

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
    public void submitCartOrder(Order order, boolean pay) {

        Order orderToUpdate = getOrderById(order.getId());

        LocalDateTime creationDate = LocalDateTime.now();
        LocalDateTime deadLine = dateTimeHandler.addWorkDays(creationDate, 7);

        orderToUpdate.setCreationDate(creationDate);
        orderToUpdate.setDeadline(deadLine);
        if(pay){
            orderToUpdate.setStatus(OrderStatus.PAID);
        }else {
            orderToUpdate.setStatus(OrderStatus.ACTIVE);
        }

        orderToUpdate.setDelivery(order.getDelivery());
        if(order.getDelivery()){
            orderToUpdate.setDeliveryAddress(order.getDeliveryAddress());
        }

        orderToUpdate.setPaymentMethod(order.getPaymentMethod());

        orderDao.saveOrUpdateOrder(orderToUpdate);

    }
}
