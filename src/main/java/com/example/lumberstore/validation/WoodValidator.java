package com.example.lumberstore.validation;

import com.example.lumberstore.entity.components.Wood;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class WoodValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return Wood.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Wood wood = (Wood) object;

        if (wood.getWidth() != null && wood.getWidth() <= 0) {
            errors.rejectValue("glassList[0].width", "message.notEmpty.calculator.glass.width");
        }

        if (wood.getHeight() != null && wood.getHeight() <= 0) {
            errors.rejectValue("height", "message.notEmpty.calculator.glass.height");
        }

        if (wood.getAmount() != null && wood.getAmount() <= 0) {
            errors.rejectValue("amount", "message.notEmpty.calculator.glass.amount");
        }

    }
}
