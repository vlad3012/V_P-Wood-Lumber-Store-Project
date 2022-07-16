package com.example.lumberstore.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@Data
public class Item {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long itemId;
    private double coast;
    private long amountProduct;


    @OneToOne
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Product product;



    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    @JoinColumn(name = "group", nullable = false)
    private Group group;


    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @JoinColumn(name = "basket_item", referencedColumnName = "id")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private BasketItem basketItems;
}
