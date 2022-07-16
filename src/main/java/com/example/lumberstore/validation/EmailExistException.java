package com.example.lumberstore.validation;

public class EmailExistException extends Throwable {
    public EmailExistException(String message) {
        super(message);
    }
}
