package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.entity.Message;

public interface MessageService {

    String getMessageText(Message message, String lang);
}
