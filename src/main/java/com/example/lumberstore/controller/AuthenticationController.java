package com.example.lumberstore.controller;

import com.example.lumberstore.entity.User;
import com.example.lumberstore.exceptions.UserAlreadyExistsException;
import com.example.lumberstore.service.interfaces.UserService;
import com.example.lumberstore.validation.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthenticationController {

    private final UserValidator userValidator;

    private final UserService userService;

    @Autowired
    public AuthenticationController(UserValidator userValidator, UserService userService) {

        this.userValidator = userValidator;
        this.userService = userService;
    }

    @InitBinder
    protected void initBinder(WebDataBinder binder) {

        binder.setValidator(userValidator);
    }

    @GetMapping("/login")
    public ModelAndView loginPage() {

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("general/login");

        return modelAndView;
    }

    @GetMapping("/signUp")
    public ModelAndView signUpPage() {

        ModelAndView modelAndView = new ModelAndView("general/registration");
        modelAndView.addObject("user", new User());

        return modelAndView;
    }

    @PostMapping("/signUp")
    public ModelAndView signUp(@ModelAttribute @Validated User user,
                               BindingResult result) {

        ModelAndView modelAndView = new ModelAndView();

        if (result.hasErrors()) {

            modelAndView.addObject("user", user);
            modelAndView.setViewName("general/registration");

            return modelAndView;
        }

        try {

            userService.registerNewUser(user);

        } catch (UserAlreadyExistsException exception){

            result.rejectValue("email", "message.alreadyExists.user.email");
            modelAndView.addObject("user", user);
            modelAndView.setViewName("general/registration");

            return modelAndView;
        }

        modelAndView.setViewName("redirect:/login");

        return modelAndView;
    }
}
