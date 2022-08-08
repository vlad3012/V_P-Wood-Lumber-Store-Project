package com.example.lumberstore.controller;

import com.example.lumberstore.entity.Customer;
import com.example.lumberstore.service.interfaces.OrderService;
import com.example.lumberstore.validation.CustomerValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    private final OrderService orderService;
    private final CustomerValidator customerValidator;

    @Autowired
    public CustomerController(OrderService orderService,
                              CustomerValidator customerValidator) {

        this.orderService = orderService;
        this.customerValidator = customerValidator;
    }

    @InitBinder(value = "customer")
    protected void initBinder(WebDataBinder binder) {

        binder.setValidator(customerValidator);
    }

    @GetMapping("/add")
    public ModelAndView addCustomer(@ModelAttribute("customer") Customer customer,
                                    @RequestParam("orderId") Long orderId){

        ModelAndView modelAndView = new ModelAndView("/admin/customers/add");

        modelAndView.addObject("customer", customer);
        modelAndView.addObject("orderId", orderId);

        return  modelAndView;
    }

    @PostMapping("/")
    public ModelAndView saveOrderCustomer(@ModelAttribute("customer") @Validated Customer customer,
                                          BindingResult result,
                                          @RequestParam("orderId") Long orderId) {

        ModelAndView modelAndView = new ModelAndView();

        if(result.hasErrors()){

            modelAndView.setViewName("/admin/customers/add");
            modelAndView.addObject("orderId", orderId);

            return modelAndView;
        }

        modelAndView.setViewName("redirect:/order/" + orderId);

        orderService.updateOrderCustomer(orderId, customer);

        return modelAndView;
    }

}
