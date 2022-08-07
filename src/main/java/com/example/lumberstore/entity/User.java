package com.example.lumberstore.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.*;

@Entity
@Getter
@Setter
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int id;
    private String login;
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
    @ManyToOne
    @JoinColumn(name = "roleId")
    private Role role;

    @OneToOne
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Basket basket;


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return (Collection<? extends GrantedAuthority>) getRole();
    }

    @Override
    public String getUsername() {
        return firstName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}

