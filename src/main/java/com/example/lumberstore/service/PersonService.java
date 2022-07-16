package com.example.lumberstore.service;

import com.example.lumberstore.entity.User;
import com.example.lumberstore.validation.EmailExistException;

public interface PersonService {

    User registerNewPerson(User person) throws EmailExistException;

    User updateExistingPerson(User person) throws EmailExistException;

}
