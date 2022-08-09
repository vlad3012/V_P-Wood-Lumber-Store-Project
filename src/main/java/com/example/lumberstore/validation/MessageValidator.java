package com.example.lumberstore.validation;

import com.example.lumberstore.entity.Message;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class MessageValidator implements Validator {

    private final String PHONE_REGEX = "^\\+375\\s?\\(\\d{2}\\)\\s\\d{3}-\\d{2}-\\d{2}$";

    @Override
    public boolean supports(Class<?> aClass) {
        return Message.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Message message = (Message) object;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customer.name", "message.notEmpty.customer.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "customer.phone", "message.notEmpty.customer.phone");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "message", "message.notEmpty.modal.message");

        if(!message.getCustomer().getPhone().isEmpty()) {
            Pattern pattern = Pattern.compile(PHONE_REGEX);
            Matcher matcher = pattern.matcher(message.getCustomer().getPhone());
            if (!matcher.matches()) {
                errors.rejectValue("customer.phone", "message.notMatches.customer.phone");
            }
        }
    }
}
