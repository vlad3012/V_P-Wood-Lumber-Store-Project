package com.example.lumberstore.entity.components;
import com.example.lumberstore.additional.enums.ProcessingType;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@DiscriminatorValue("processing")
public class Processing implements Serializable, DefaultComponent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private ProcessingType type;

    private String name;

    @JsonIgnore
    private String symbol;

    private Float price;

    private Float priceUSD;

    @Transient
    private Integer quantity;

    @ManyToMany(mappedBy = "processingList")
    @JsonIgnore
    private Set<Wood> wood = new HashSet<>();

    public Processing() {
    }

    public ProcessingType getType() {
        return type;
    }

    public void setType(ProcessingType type) {
        this.type = type;
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

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
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

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
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
        Processing that = (Processing) o;
        return id.equals(that.id) && type.equals(that.type) && name.equals(that.name) && Objects.equals(symbol, that.symbol) && price == that.price;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, symbol, price, type);
    }
}
