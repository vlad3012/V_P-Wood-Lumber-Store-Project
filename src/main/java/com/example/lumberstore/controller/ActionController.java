package com.example.lumberstore.controller;

import com.example.lumberstore.entity.Group;
import com.example.lumberstore.entity.Product;
import com.example.lumberstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.Optional;

@Controller
public class ActionController {
    @Autowired
    private ProductService productService;

    @PostMapping("/updateProduct")
    @ResponseBody
    public String updateProduct(@ModelAttribute("product") Product product) {
        if (productService.findProductById(product.getId()).isPresent()) {
            try {
                productService.updateProduct(product);
                return "product is updated!";
            } catch (Exception e) {
                e.printStackTrace();
                return "product is not update due to an db error";
            }
        } else {
            return "product is not exist";
        }
    }
    @PostMapping("/addProduct")
    @ResponseBody
    public String addProduct(@ModelAttribute("product") Product product) {
        productService.addProduct(product);
        return "new product is created!";
    }
}
