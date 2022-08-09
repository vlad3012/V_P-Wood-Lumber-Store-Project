package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.entity.Order;

public interface CalculatorService {

    float calculatePrice(Order order);
}
