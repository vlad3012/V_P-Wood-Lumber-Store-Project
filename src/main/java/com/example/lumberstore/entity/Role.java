package com.example.lumberstore.entity;

import lombok.*;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "role")
@NoArgsConstructor
@Setter
@Getter
@ToString
@EqualsAndHashCode
public class Role implements GrantedAuthority {
    @Id
    private long id;
    private String name;
    @Transient
    @OneToMany(mappedBy = "role", fetch = FetchType.EAGER)
    private Set<User> users;

    @Override
    public String getAuthority() {
        return getName();
    }

    public Role(Long id) {
        this.id = id;
    }

    public Role(Long id, String name) {
        this.id = id;
        this.name = name;
    }
}
