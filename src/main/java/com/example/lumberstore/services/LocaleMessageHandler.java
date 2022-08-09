package com.example.lumberstore.services;

import com.example.lumberstore.additional.UTF8Control;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

import java.util.ResourceBundle;

@Component
public class LocaleMessageHandler {

    private ResourceBundle resourceBundle;

    public String getMessage(String key){

        resourceBundle = ResourceBundle.getBundle("messages/messages",
                LocaleContextHolder.getLocale(), new UTF8Control());

        return resourceBundle.getString(key);
    }
}
