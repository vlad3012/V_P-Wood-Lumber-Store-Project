package com.example.lumberstore.entity;

import com.example.lumberstore.entity.components.Accessory;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity(name = "order_item")
@JsonIgnoreProperties("order")
public class OrderItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int amount;
    @ManyToOne(optional = false)
    @JoinColumn(name = "order_id")
    private com.example.lumberstore.entity.Order order;

    @ManyToOne(optional = false)
    @JoinColumn(name = "component_id")
    private Accessory component;

    public OrderItem() {
    }

    public OrderItem(int amount, Order order, Accessory component) {

        this.amount = amount;
        this.order = order;
        this.component = component;
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

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
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
        OrderItem orderItem = (OrderItem) o;
        return amount == orderItem.amount && Objects.equals(id, orderItem.id) && Objects.equals(order, orderItem.order) && Objects.equals(component, orderItem.component);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, amount, order, component);
    }
}