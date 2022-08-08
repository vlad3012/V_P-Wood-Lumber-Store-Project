package com.example.lumberstore.entity.components;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "wood_type")
public class WoodType implements Serializable, DefaultComponent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    protected Long id;

    protected String name;

    private Integer diameter;

    private Float price;

    private Float priceUSD;

    @OneToMany(mappedBy = "woodType")
    @JsonIgnore
    private Set<Wood> wood = new HashSet<>();

    public WoodType() {
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

    public Integer getDiameter() {
        return diameter;
    }

    public void setDiameter(Integer diameter) {
        this.diameter = diameter;
    }

    public Set<Wood> getWood() {
        return wood;
    }

    public void setWood(Set<Wood> wood) {
        this.wood = wood;
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

    @Override
    public boolean isNew() {
        return id == null;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        WoodType woodType = (WoodType) o;
        return id.equals(woodType.id) && name.equals(woodType.name) && diameter.equals(woodType.diameter) && price == woodType.price;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, diameter, price);
    }
}
