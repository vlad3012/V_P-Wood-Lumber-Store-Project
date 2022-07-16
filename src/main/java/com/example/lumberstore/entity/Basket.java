package com.example.lumberstore.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@Data
@Entity
@NoArgsConstructor
public class Basket {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    @OneToOne(mappedBy = "basket")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private User person;

    @OneToOne
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private BasketItem basketItem;
}
