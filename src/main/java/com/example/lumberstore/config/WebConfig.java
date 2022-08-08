package com.example.lumberstore.config;

import com.example.lumberstore.additional.converters.ComponentTypeStringToEnumConverter;
import com.example.lumberstore.additional.converters.ProductTypeStringToEnumConverter;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.util.Properties;


    @Configuration
    @EnableWebMvc
    @ComponentScan(basePackages = "com.example.lumberstore.controller")
    public class WebConfig implements WebMvcConfigurer {

        @Override
        public void addViewControllers(ViewControllerRegistry registry) {

            registry.addViewController("/").setViewName("index");
            registry.addViewController("/accessDenied").setViewName("accessDenied");
            registry.addViewController("/contacts").setViewName("user/contacts");
            registry.addViewController("/main").setViewName("user/main");
        }

        @Override
        public void configureViewResolvers(ViewResolverRegistry registry) {

            registry.jsp("/WEB-INF/views/", ".jsp");
        }

        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {

            registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
        }

        @Bean
        public ResourceBundleMessageSource validationMessageSource() {

            ResourceBundleMessageSource rb = new ResourceBundleMessageSource();
            rb.setBasenames("classpath:messages/messages");
            rb.setDefaultEncoding("UTF-8");
            return rb;
        }

        @Override
        public void addFormatters(FormatterRegistry registry) {

            registry.addConverter(new ComponentTypeStringToEnumConverter());
            registry.addConverter(new ProductTypeStringToEnumConverter());
        }

        @Bean
        public MultipartResolver multipartResolver() {

            return new StandardServletMultipartResolver();
        }

        @Bean("messageSource")
        public MessageSource messageSource() {

            ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
            messageSource.setBasename("classpath:messages/messages");
            messageSource.setDefaultEncoding("UTF-8");

            return messageSource;
        }

        @Bean
        public LocaleResolver localeResolver() {

            SessionLocaleResolver localeResolver = new SessionLocaleResolver();
            return localeResolver;
        }

        @Override
        public void addInterceptors(InterceptorRegistry registry) {

            LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
            localeChangeInterceptor.setParamName("lang");
            registry.addInterceptor(localeChangeInterceptor);
        }

        @Bean
        public SimpleMappingExceptionResolver createSimpleMappingExceptionResolver() {

            SimpleMappingExceptionResolver r =
                    new SimpleMappingExceptionResolver();

            Properties mappings = new Properties();
            mappings.setProperty("DatabaseException", "databaseError");
            mappings.setProperty("InvalidCreditCardException", "creditCardError");

            r.setExceptionMappings(mappings);  // None by default
            r.setDefaultErrorView("error");    // No default
            r.setExceptionAttribute("ex");     // Default is "exception"
            r.setWarnLogCategory("example.MvcLogger");     // No default
            return r;
        }
    }

