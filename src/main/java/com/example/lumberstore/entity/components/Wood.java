package com.example.lumberstore.entity.components;

import com.example.lumberstore.additional.enums.Shape;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.entity.Order;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

@Entity
@JsonIgnoreProperties(ignoreUnknown = true)
public class Wood implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Integer width;
    private Integer height;
    private Integer amount;

    @Enumerated(EnumType.STRING)
    private Shape shape;

    @ManyToOne
    @JoinColumn(name = "glass_type_id")
    @JsonProperty("type")
    private WoodType woodType;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "Wood_Processing",
            joinColumns = {@JoinColumn(name = "wood_id")},
            inverseJoinColumns = {@JoinColumn(name = "processing_id")}
    )
    private Set<Processing> processingList = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "catalog_id")
    private Catalog catalog;

    public Wood() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public WoodType getWoodType() {
        return woodType;
    }

    public void setWoodType(WoodType woodType) {
        this.woodType = woodType;
    }

    public Set<Processing> getProcessingList() {
        return processingList;
    }

    public void setProcessingList(Set<Processing> processingList) {

        this.processingList = processingList;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public List<Processing> getProcessingListAsList() {
        return new ArrayList<>(processingList);
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Catalog getCatalog() {
        return catalog;
    }

    public void setCatalog(Catalog catalog) {
        this.catalog = catalog;
    }


    public Shape getShape() {
        return shape;
    }

    public void setShape(Shape shape) {
        this.shape = shape;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Wood wood = (Wood) o;
        return Objects.equals(id, wood.id) && Objects.equals(width, wood.width) && Objects.equals(height, wood.height)
                && Objects.equals(amount, wood.amount) && shape == wood.shape && Objects.equals(woodType, wood.woodType)
                && Objects.equals(order, wood.order) && Objects.equals(catalog, wood.catalog);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, width, height, amount, shape, woodType, order, catalog);
    }
}
