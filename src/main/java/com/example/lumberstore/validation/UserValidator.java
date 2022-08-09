package com.example.lumberstore.validation;

import com.example.lumberstore.entity.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class UserValidator implements Validator {

    private final String EMAIL_REGEX = "^[_A-Za-z0-9-]+(\\." +
            "[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*" +
            "(\\.[A-Za-z]{2,})$";
    private final String PASSWORD_REGEX = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";


    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        User user = (User) object;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "message.notEmpty.user.login");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "message.notEmpty.user.password");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "message.notEmpty.user.confirmPassword");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "message.notEmpty.user.email");

        if(!user.getEmail().isEmpty()) {
            Pattern patternEmail = Pattern.compile(EMAIL_REGEX);
            Matcher matcherEmail = patternEmail.matcher(user.getEmail());
            if (!matcherEmail.matches()) {
                errors.rejectValue("email", "message.notMatches.user.email");
            }
        }

        if(!user.getConfirmPassword().isEmpty() && !user.getConfirmPassword().isEmpty()) {
            Pattern patternPassword = Pattern.compile(PASSWORD_REGEX);
            Matcher matcherPassword = patternPassword.matcher(user.getPassword());
            if (!matcherPassword.matches()) {
                errors.rejectValue("password", "message.notMatches.user.password");
            } else if (!user.getPassword().equals(user.getConfirmPassword())) {
                errors.rejectValue("password", "message.notConfirm.user.password");
                errors.rejectValue("confirmPassword", "message.notConfirm.user.password");
            }
        }


    }
}
