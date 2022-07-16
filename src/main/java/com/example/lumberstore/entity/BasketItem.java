package com.example.lumberstore.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.util.List;
@Data
@NoArgsConstructor
@Entity
public class BasketItem {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;



    @OneToMany(mappedBy = "basketItems", cascade = CascadeType.ALL)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Item> item ;



    @OneToOne(mappedBy = "basketItem")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Basket basket;
}
