package com.example.lumberstore.repository;

import com.example.lumberstore.additional.enums.OrderStatus;
import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.entity.Order;
import com.example.lumberstore.repository.interfaces.OrderDao;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.*;

@Repository
public class OrderDaoImp implements OrderDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public OrderDaoImp(SessionFactory sessionFactory) {

        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Order> getOrdersByStatus(OrderStatus status) {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_orders_by_status", Order.class)
                .setParameter("order_status", status.toString())
                .getResultList();
        return orderList;
    }

    @Override
    public List<Order> getOrdersByCustomer(Customer customer) {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_orders_by_status_by_customer", Order.class)
                .setParameter("order_status", OrderStatus.CART.toString())
                .setParameter("customer_id", customer.getId())
                .getResultList();
        return orderList;

    }

    @Override
    public List<Order> getOrders() {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_orders", Order.class)
                .setParameter("order_status", OrderStatus.CART.toString())
                .getResultList();
        return orderList;
    }

    @Override
    public List<Order> getExpiredOrders() {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_expired_orders", Order.class)
                .setParameter("current", LocalDateTime.now())
                .setParameter("order_status", Arrays.asList(OrderStatus.CART, OrderStatus.CLOSED))
                .getResultList();
        return orderList;
    }

    @Override
    public Optional<Order> getOrderById(Long id) {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_order_by_id", Order.class)
                .setParameter("order_status", OrderStatus.CART.toString())
                .setParameter("id", id)
                .getResultList();
        return orderList.stream().findFirst();

    }

    @Override
    public Long getExpiredOrdersCount() {

        Long count = sessionFactory.getCurrentSession()
                .createNamedQuery("get_expired_orders_count", Long.class)
                .setParameter("current", LocalDateTime.now())
                .setParameter("order_status", Arrays.asList(OrderStatus.CART, OrderStatus.CLOSED))
                .getSingleResult();

        return count;
    }

    @Override
    public List<Order> getCartOrders(OrderStatus status, Customer customer) {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_cart_orders", Order.class)
                .setParameter("order_status", status.toString())
                .setParameter("customer_id", customer.getId())
                .getResultList();
        return orderList;
    }

    @Override
    public Optional<Order> getCartOrderById(Long id) {

        List<Order> orderList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_cart_order_by_id", Order.class)
                .setParameter("order_status", OrderStatus.CART.toString())
                .setParameter("id", id)
                .getResultList();
        return orderList.stream().findFirst();
    }

    @Override
    public void saveOrUpdateOrder(Order order) {
        sessionFactory.getCurrentSession().saveOrUpdate(order);
    }

    @Override
    public Map<String, Long> getOrderStatusCount() {

        Map<String, Long> map = new HashMap<>();

        List list = sessionFactory.getCurrentSession()
                .createNamedQuery("get_order_status_count")
                .getResultList();

        Long sum = 0L;

        for (Object o : list) {

            Object[] row = (Object[]) o;

            if (row[0] != OrderStatus.CART) {
                sum += (Long) row[1];
            }

            map.put(row[0].toString().toLowerCase(), (Long) row[1]);
        }

        map.put("all", sum);

        return map;
    }

    @Override
    public void deleteOrder(Order order) {
        sessionFactory.getCurrentSession().delete(order);
    }

}
