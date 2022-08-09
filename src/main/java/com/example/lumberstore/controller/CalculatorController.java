package com.example.lumberstore.controller;

import com.example.lumberstore.additional.JsonResponse;
import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.additional.enums.Shape;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.entity.Order;
import com.example.lumberstore.services.interfaces.CalculatorService;
import com.example.lumberstore.services.interfaces.CatalogService;
import com.example.lumberstore.services.interfaces.OrderService;
import com.example.lumberstore.validation.WoodValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/calculator")
public class CalculatorController {

    private final CalculatorService calculatingService;
    private final OrderService orderService;
    private final CatalogService catalogService;
    private final WoodValidator woodValidator;

    @Autowired
    public CalculatorController(CalculatorService calculatingService,
                                OrderService orderService,
                                CatalogService catalogService,
                                WoodValidator woodValidator) {

        this.calculatingService = calculatingService;
        this.orderService = orderService;
        this.catalogService = catalogService;
        this.woodValidator = woodValidator;
    }

    @GetMapping("/")
    public ModelAndView calculator(@RequestParam(name = "productType", required = false) ProductType productType,
                                   @ModelAttribute("order") Order order,
                                   @ModelAttribute("catalog") Catalog catalog,
                                   @ModelAttribute("isTemplate") Boolean isTemplate,
                                   @ModelAttribute("message") String message) {

        ModelAndView modelAndView = new ModelAndView("general/calculator");

        if (isTemplate) {
            catalogService.prepareForView(catalog, productType);
            modelAndView.addObject("model", catalog);
        } else {
            modelAndView.addObject("model", order);
        }
        modelAndView.addObject("isForTemplate", isTemplate);
        modelAndView.addObject("message", message);
        modelAndView.addObject("productTypes", ProductType.values());
        modelAndView.addObject("shapes", Shape.values());

        return modelAndView;

    }

    @PostMapping("/calculate")
    @ResponseBody
    public JsonResponse calculate(@RequestBody Order order) {

        float resultPrice = calculatingService.calculatePrice(order);

        JsonResponse response = new JsonResponse();
        response.setStatus(HttpStatus.OK);
        response.setResult(resultPrice);

        return response;
    }

    @ModelAttribute("order")
    public void prepareOrder(Order order, ProductType productType){

        if(order.isNew()){
            orderService.prepareForView(order, productType);
        }
    }

    @ModelAttribute("isTemplate")
    public void prepareOrder(Model model){

        model.addAttribute("isTemplate", Boolean.FALSE);
    }

}
