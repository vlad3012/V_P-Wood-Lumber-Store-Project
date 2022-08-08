package com.example.lumberstore.entity;
import com.example.lumberstore.entity.components.Accessory;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

import java.io.Serializable;
import java.util.Objects;

@Entity(name = "catalog_item")
@JsonIgnoreProperties("catalog")
public class CatalogItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int amount;
    @ManyToOne(optional = false)
    @JoinColumn(name = "catalog_id")
    private Catalog catalog;

    @ManyToOne(optional = false)
    @JoinColumn(name = "component_id")
    private Accessory component;

    public CatalogItem() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Catalog getCatalog() {
        return catalog;
    }

    public void setCatalog(Catalog catalog) {
        this.catalog = catalog;
    }

    public Accessory getComponent() {
        return component;
    }

    public void setComponent(Accessory item) {
        this.component = item;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CatalogItem that = (CatalogItem) o;
        return amount == that.amount && Objects.equals(id, that.id) && Objects.equals(catalog, that.catalog) && Objects.equals(component, that.component);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, amount, catalog, component);
    }
}