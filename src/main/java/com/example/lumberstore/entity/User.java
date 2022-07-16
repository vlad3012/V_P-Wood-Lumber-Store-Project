package com.example.lumberstore.entity;

import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "User")
@NamedQueries({
        @NamedQuery(name = "User.findAll", query = "SELECT p FROM User p"),
        @NamedQuery(name = "User.findById", query = "SELECT p FROM User p WHERE p.id = :id"),
        @NamedQuery(name = "User.findByFirstname", query = "SELECT p FROM User p WHERE p.firstName = :firstName"),
        @NamedQuery(name = "User.findByLastname", query = "SELECT p FROM User p WHERE p.lastName = :lastName"),
        @NamedQuery(name = "User.findByEmail", query = "SELECT p FROM User p WHERE p.email = :email"),
        @NamedQuery(name = "User.findByAddress", query = "SELECT p FROM User  p WHERE p.address = :address")})
public class User {
    @Id
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate birthdate;
    private String address;
    private String password;
    @JoinTable(name = "USER_GROUPS", joinColumns = {
            @JoinColumn(name = "USER_EMAIL", referencedColumnName = "EMAIL")}, inverseJoinColumns = {
            @JoinColumn(name = "GROUPS_NAME", referencedColumnName = "NAME")})
    @ManyToMany
    private List<Group> groupsList;
    @ManyToMany
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Set<Role> role;

    @OneToOne(orphanRemoval = true)
    @JoinTable(name = "user_basket",
            joinColumns = @JoinColumn(name = "user_null"),
            inverseJoinColumns = @JoinColumn(name = "basket"))
    private Basket basket;

    public Basket getBasket() {
        return basket;
    }

    public void setBasket(Basket basket) {
        this.basket = basket;
    }

    public User() {
        this.groupsList = new ArrayList<Group>();
    }

    public User(int id) {
        this.id = id;
        this.groupsList = new ArrayList<Group>();
    }

    public User(int id, String firstName, String lastName, String email, String address, String password) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.address = address;
        this.password = password;
        this.groupsList = new ArrayList<Group>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Group> getGroupsList() {
        return groupsList;
    }

    public void setGroupsList(List<Group> groupsList) {
        this.groupsList = groupsList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User person = (User) o;
        return id == person.id && Objects.equals(firstName, person.firstName) && Objects.equals(lastName, person.lastName) && Objects.equals(email, person.email) && Objects.equals(address, person.address) && Objects.equals(password, person.password) && Objects.equals(groupsList, person.groupsList);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, firstName, lastName, email, address, password, groupsList);
    }

    @Override
    public String toString() {
        return "Person{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", password='" + password + '\'' +
                ", groupsList=" + groupsList +
                '}';
    }
}

