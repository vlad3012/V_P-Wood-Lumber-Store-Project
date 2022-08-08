package com.example.lumberstore.exceptions;

import com.example.lumberstore.exceptions.notFoundExceptions.NotFoundException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(NotFoundException.class)
    public ModelAndView handleNotFoundException(NotFoundException e) {

        ModelAndView modelAndView = new ModelAndView("notFound");
        modelAndView.addObject("error", e.getMessage());
        modelAndView.addObject("status", 404);

        return modelAndView;
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception e) {

        ModelAndView modelAndView = new ModelAndView("notFound");
        modelAndView.addObject("error", e.getMessage());
        modelAndView.addObject("status", 404);

        return modelAndView;
    }
}
