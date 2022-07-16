package com.example.lumberstore.service;

import com.example.lumberstore.repository.PersonRepository;
import com.example.lumberstore.repository.ProductRepository;
import com.example.lumberstore.entity.User;
import com.example.lumberstore.validation.EmailExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class PersonServiceImp implements PersonService {

    @Autowired
    PersonRepository personRepository;
    @Autowired
    ProductRepository productRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public User registerNewPerson(User person) throws EmailExistException {
        if (emailExist(person.getEmail())) {
            throw new EmailExistException("Such email already registered!");
        }
        person.setPassword(passwordEncoder.encode(person.getPassword()));
        return personRepository.save(person);
    }

    public boolean emailExist(String email) {
        return personRepository.findByEmail(email) != null;
    }


    @Override
    public User updateExistingPerson(User person) throws EmailExistException {
        final String email = person.getEmail();
        final User emailOwner = personRepository.findByEmail(email);
        if (emailOwner != null) {
            throw new EmailExistException("Email not available.");
        }
        if (person.getPassword() != null) {
            person.setPassword(passwordEncoder.encode(person.getPassword()));
        }
        return personRepository.save(person);
    }
}
