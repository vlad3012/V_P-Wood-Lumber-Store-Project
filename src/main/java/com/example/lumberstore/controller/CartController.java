package com.example.lumberstore.controller;

import com.example.lumberstore.entity.CustomUserDetails;
import com.example.lumberstore.additional.JsonResponse;
import com.example.lumberstore.entity.Order;
import com.example.lumberstore.entity.User;
import com.example.lumberstore.services.LocaleMessageHandler;
import com.example.lumberstore.services.interfaces.CartService;
import com.example.lumberstore.validation.OrderValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;
    private final OrderValidator orderValidator;
    private final LocaleMessageHandler localeMessageHandler;

    @Autowired
    public CartController(CartService cartService,
                          OrderValidator orderValidator,
                          LocaleMessageHandler localeMessageHandler) {

        this.cartService = cartService;
        this.orderValidator = orderValidator;
        this.localeMessageHandler = localeMessageHandler;
    }

    @InitBinder("order")
    protected void initBinder(WebDataBinder binder) {

        binder.setValidator(orderValidator);
    }

    @GetMapping("/")
    public ModelAndView cart(Authentication authentication) {

        User currentUser = ((CustomUserDetails) authentication.getPrincipal()).getUser();

        ModelAndView modelAndView = new ModelAndView("/user/cart");
        modelAndView.addObject("orders",
                cartService.getOrders(currentUser.getCustomer()));
        modelAndView.addObject("address", currentUser.getCustomer().getAddress());

        return modelAndView;
    }

    @PostMapping("/add")
    @ResponseBody
    public JsonResponse cartAddAjax(@RequestBody @Validated Order order,
                                    BindingResult result,
                                    Authentication authentication) {

        JsonResponse response = new JsonResponse();

        if (result.hasErrors()) {
            response.setStatus(HttpStatus.BAD_REQUEST);
            response.setResult(result.getAllErrors());
            return response;
        }

        User currentUser = ((CustomUserDetails) authentication.getPrincipal()).getUser();
        cartService.addOrder(order, currentUser.getCustomer());
        response.setStatus(HttpStatus.OK);
        response.setMessage(localeMessageHandler.getMessage("message.notification.order.addCart.success"));

        return response;
    }


    @PostMapping("/{id}/delete")
    @ResponseBody
    public JsonResponse cartDeleteItem(@PathVariable Long id) {

        JsonResponse jsonResponse = new JsonResponse();

        cartService.deleteOrder(id);
        jsonResponse.setStatus(HttpStatus.OK);
        jsonResponse.setMessage(localeMessageHandler.getMessage("message.notification.order.delete.success"));

        return jsonResponse;

    }

    @PostMapping("/submit")
    @ResponseBody
    public JsonResponse cartSubmit(@RequestBody List<Order> orders) {

        for (Order order : orders) {
            cartService.submitCartOrder(order, false);
        }

        JsonResponse response = new JsonResponse();
        response.setStatus(HttpStatus.OK);
        response.setMessage(localeMessageHandler.getMessage("message.notification.order.submit.success"));

        return response;
    }

    @PostMapping("/submitAndPay")
    @ResponseBody
    public JsonResponse cartSubmitAndPay(@RequestBody List<Order> orders) {

        for (Order order : orders) {
            cartService.submitCartOrder(order, true);
        }

        JsonResponse response = new JsonResponse();
        response.setStatus(HttpStatus.OK);
        response.setMessage(localeMessageHandler.getMessage("message.notification.order.pay.success"));

        return response;
    }
}
