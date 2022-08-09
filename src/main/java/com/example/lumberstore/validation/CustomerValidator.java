package com.example.lumberstore.validation;

import com.example.lumberstore.entity.Customer;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class CustomerValidator implements Validator {

    private final String PHONE_REGEX = "^\\+375\\s?\\(\\d{2}\\)\\s\\d{3}-\\d{2}-\\d{2}$";
    private final String EMAIL_REGEX = "^[_A-Za-z0-9-]+(\\." +
            "[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*" +
            "(\\.[A-Za-z]{2,})$";

    @Override
    public boolean supports(Class<?> aClass) {
        return Customer.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Customer customer = (Customer) object;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "message.notEmpty.customer.name");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "message.notEmpty.customer.phone");

        if(!customer.getPhone().isEmpty()) {
            Pattern pattern = Pattern.compile(PHONE_REGEX);
            Matcher matcher = pattern.matcher(customer.getPhone());
            if (!matcher.matches()) {
                errors.rejectValue("phone", "message.notMatches.customer.phone");
            }
        }

        if(!customer.getEmail().isEmpty()){
            Pattern patternEmail = Pattern.compile(EMAIL_REGEX);
            Matcher matcherEmail = patternEmail.matcher(customer.getEmail());
            if (!matcherEmail.matches()) {
                errors.rejectValue("email", "message.notMatches.user.email");
            }
        }

    }
}
