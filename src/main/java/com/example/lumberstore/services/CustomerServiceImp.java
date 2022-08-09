package com.example.lumberstore.services;

import com.example.lumberstore.entity.CustomUserDetails;
import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.exceptions.notFoundExceptions.CustomerNotFoundException;
import com.example.lumberstore.repository.interfaces.CustomerDao;
import com.example.lumberstore.services.interfaces.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CustomerServiceImp implements CustomerService {

    private final CustomerDao customerDao;

    @Autowired
    public CustomerServiceImp(CustomerDao customerDao) {

        this.customerDao = customerDao;
    }

    @Override
    @Transactional
    public void update(Customer customer, Authentication authentication) {

        Customer customerToUpdate = getById(customer.getId());
        customerToUpdate.setName(customer.getName());
        customerToUpdate.setEmail(customer.getEmail());
        customerToUpdate.setPhone(customer.getPhone());
        customerToUpdate.setAddress(customer.getAddress());

        customerDao.saveOrUpdate(customerToUpdate);

        ((CustomUserDetails) authentication.getPrincipal()).getUser().setCustomer(customerToUpdate);
    }

    @Override
    @Transactional
    public Customer getById(Long id) {

        return customerDao.getById(id)
                .orElseThrow(() -> new CustomerNotFoundException(id));
    }
}
