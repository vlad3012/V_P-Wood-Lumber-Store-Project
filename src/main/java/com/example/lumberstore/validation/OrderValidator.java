package com.example.lumberstore.validation;

import com.example.lumberstore.entity.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class OrderValidator implements Validator {

    private final WoodValidator woodValidator;

    @Autowired
    public OrderValidator(WoodValidator woodValidator) {
        this.woodValidator = woodValidator;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return Order.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Order order = (Order) object;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productType", "message.notEmpty.calculator.productType");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cost", "message.notEmpty.calculator.cost");

        if (order.getCost() != null && order.getCost() <= 0) {
            errors.rejectValue("cost", "message.notEmpty.calculator.cost");
        }
    }
}
