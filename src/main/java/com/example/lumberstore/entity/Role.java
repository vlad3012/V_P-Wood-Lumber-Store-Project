package com.example.lumberstore.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.Set;
@Entity
@Getter
@Setter
public class Role implements GrantedAuthority {
    @Id
    private int id;
    private String Name;
    @OneToMany(mappedBy = "role")
    private Set<User> users;

    public Role() {
    }

    public Role(int l, String name) {
        this.id = id;
        Name = name;
    }

    @Override
    public String getAuthority() {
        return getName();
    }
}
