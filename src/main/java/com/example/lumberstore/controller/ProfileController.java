package com.example.lumberstore.controller;

import com.example.lumberstore.entity.CustomUserDetails;
import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.entity.User;
import com.example.lumberstore.service.LocaleMessageHandler;
import com.example.lumberstore.service.interfaces.CustomerService;
import com.example.lumberstore.validation.CustomerValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    private final CustomerService customerService;
    private final CustomerValidator customerValidator;
    private final LocaleMessageHandler localeMessageHandler;

    @Autowired
    public ProfileController(CustomerService customerService,
                             CustomerValidator customerValidator,
                             LocaleMessageHandler localeMessageHandler) {

        this.customerService = customerService;
        this.customerValidator = customerValidator;
        this.localeMessageHandler = localeMessageHandler;
    }

    @InitBinder(value = "customer")
    protected void initBinder(WebDataBinder binder) {

        binder.setValidator(customerValidator);
    }

    @GetMapping("/")
    public ModelAndView profile(Authentication authentication,
                                @ModelAttribute("message") String message,
                                @ModelAttribute("status") String status){

        ModelAndView modelAndView =  new ModelAndView("user/profile");

        User currentUser = ((CustomUserDetails) authentication.getPrincipal()).getUser();

        modelAndView.addObject("customer",currentUser.getCustomer());
        modelAndView.addObject("username", currentUser.getUsername());

        modelAndView.addObject("message", message);
        modelAndView.addObject("status", status);

        return modelAndView;
    }

    @PostMapping("/")
    public ModelAndView saveProfile(@ModelAttribute("customer") @Validated Customer customer,
                                    BindingResult result,
                                    Authentication authentication,
                                    RedirectAttributes redirectAttributes){

        ModelAndView modelAndView = new ModelAndView();

        if(result.hasErrors()){
            modelAndView.setViewName("user/profile");
            return modelAndView;
        }

        customerService.update(customer, authentication);

        modelAndView.setViewName("redirect:/profile/");
        redirectAttributes.addFlashAttribute("message",
                localeMessageHandler.getMessage("message.notification.profile.save.success"));
        redirectAttributes.addFlashAttribute("status", "success");


        return modelAndView;
    }

}
