package com.example.lumberstore.controller;

import com.example.lumberstore.entity.Product;
import com.example.lumberstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
public class AdminProductController {
    @Autowired
    private ProductService productService;
    @RequestMapping("/operationWithProduct")
    public String handlerProduct(){
        return "handlerProduct";
    }
    @RequestMapping("/showProductById")
    public String showProductById(){
        return "showProductById";
    }

    @RequestMapping("/showAllProduct")
    public String getAllProduct(Model model) {
        model.addAttribute("allProducts",  productService.getAllProduct());
        return "showAllProduct";
    }
    @GetMapping("/createProduct")
    public String createProduct(Model model){
        model.addAttribute("productForm", new Product());
        return "createProduct";
    }
    @PostMapping("/createProduct")
    public String createProductPost(@ModelAttribute("productForm") @Valid Product productForm){
        productService.addProduct(productForm);
        return "createProduct";
    }

    @RequestMapping("/deleteProduct")
    public String deleteProduct(){
        return "deleteProduct";
    }
    @RequestMapping("/deleteProductById")
    public String delete(HttpServletRequest request){
        Long id = Long.valueOf(request.getParameter("id"));
        productService.delete(id);
        return "deleteProduct";
    }
}
