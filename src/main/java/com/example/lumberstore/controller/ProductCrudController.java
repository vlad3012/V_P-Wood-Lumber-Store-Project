package com.example.lumberstore.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;

public class ProductCrudController {
    @GetMapping("/")
    public String init() {
        return "index";
    }
    @GetMapping("/getOption")
    public String selectOption(@RequestParam("option") int option, HttpServletResponse servletResponse) {
        switch (option) {
            case 1: {
                return "productInformation";
            }
            case 2: {
                return ("productCreation");
            }
            case 3: {
                return "productUpdate";
            }
            case 4: {
                return "redirect:/showAll";
            }
            case 5: {
                return "removeProduct";
            }
        }
        servletResponse.setStatus(HttpServletResponse.SC_NOT_FOUND);
        return "invalidPage";
    }
}
