package com.example.lumberstore.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import static org.apache.coyote.http11.Constants.a;

@Controller
@RequestMapping("/calculator")
public class LumberCalculatorController {
    private int length;
    private int width;
    private int height;

    public long multiply(int length, int width,int height) {
        return length * width * height;
    }
}
