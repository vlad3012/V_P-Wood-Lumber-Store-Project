package com.example.lumberstore.repository;

import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.repository.interfaces.CustomerDao;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class CustomerDaoImp implements CustomerDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public CustomerDaoImp(SessionFactory sessionFactory) {

        this.sessionFactory = sessionFactory;
    }

    @Override
    public void saveOrUpdate(Customer customer) {

        sessionFactory.getCurrentSession().saveOrUpdate(customer);
    }

    @Override
    public Optional<Customer> getById(Long id) {

        List<Customer> customerList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_customer_by_id", Customer.class)
                .setParameter("id", id)
                .getResultList();

        return customerList.stream().findFirst();
    }
}
