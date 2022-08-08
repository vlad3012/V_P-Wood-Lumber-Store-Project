package com.example.lumberstore.entity.components;
import com.example.lumberstore.entity.CatalogItem;
import com.example.lumberstore.entity.OrderItem;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
public class Accessory implements DefaultComponent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Long id;
    protected String name;
    protected Float price;
    protected Float priceUSD;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "component")
    @Cascade({org.hibernate.annotations.CascadeType.ALL})
    @JsonIgnore
    private Set<OrderItem> orderItems = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "component")
    @Cascade({org.hibernate.annotations.CascadeType.ALL})
    @JsonIgnore
    private Set<CatalogItem> catalogItems = new HashSet<>();

    public Accessory() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getPriceUSD() {
        return priceUSD;
    }

    public void setPriceUSD(Float priceUSD) {
        this.priceUSD = priceUSD;
    }

    public Set<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(Set<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public Set<CatalogItem> getCatalogItems() {
        return catalogItems;
    }

    public void setCatalogItems(Set<CatalogItem> catalogItems) {
        this.catalogItems = catalogItems;
    }

    @Override
    public boolean isNew() {
        return id == null;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Accessory accessory = (Accessory) o;
        return Objects.equals(id, accessory.id) && Objects.equals(name, accessory.name) && Objects.equals(price, accessory.price) && Objects.equals(priceUSD, accessory.priceUSD);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, price, priceUSD);
    }
}
