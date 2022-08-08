package com.example.lumberstore.entity;


import com.example.lumberstore.additional.enums.OrderStatus;
import com.example.lumberstore.additional.enums.PaymentMethod;
import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.components.Wood;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@NamedQuery(name = "get_orders_by_status",
        query = "from orders where order_status=:order_status order by creation_date desc")
@NamedQuery(name = "get_orders_by_status_by_customer",
        query = "from orders where order_status!=:order_status and customer_id=:customer_id order by creation_date desc")
@NamedQuery(name = "get_orders",
        query = "from orders where order_status!=:order_status order by creation_date desc")
@NamedQuery(name = "get_expired_orders",
        query = "from orders as o where o.deadline<:current and o.status not in (:order_status) order by o.creationDate desc")
@NamedQuery(name = "get_order_by_id",
        query = "from orders where order_status!=:order_status and id=:id")
@NamedQuery(name = "get_order_status_count",
        query = "select o.status, count(o) from orders as o group by o.status")
@NamedQuery(name = "get_expired_orders_count",
        query = "select count(o) from orders as o where o.deadline<:current and o.status not in (:order_status)")


@NamedQuery(name = "get_cart_orders",
        query = "from orders where customer_id=:customer_id and order_status=:order_status order by creation_date desc")
@NamedQuery(name = "get_cart_order_by_id",
        query = "from orders where order_status=:order_status and id=:id")

@Entity(name = "orders")
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE})
    private Customer customer;

    private Float cost;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_type")
    private ProductType productType;

    @Enumerated(EnumType.STRING)
    @Column(name = "order_status")
    private OrderStatus status;

    @Column(name = "creation_date")
    private LocalDateTime creationDate;

    @Transient
    private DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");

    private LocalDateTime deadline;

    private Boolean delivery = false;

    @Column(name = "delivery_address")
    private String deliveryAddress;

    private Boolean installation = false;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method")
    private PaymentMethod paymentMethod = PaymentMethod.CASH;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "order", orphanRemoval = true)
    @Cascade({org.hibernate.annotations.CascadeType.ALL})
    private Set<OrderItem> accessories = new HashSet<>();

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "order", orphanRemoval = true)
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.DELETE})
    private Set<Wood> woodList = new HashSet<>();

    public Order() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Float getCost() {
        return cost;
    }

    public void setCost(Float cost) {
        this.cost = cost;
    }

    public LocalDateTime getCreationDate() {
        return creationDate;
    }

    public String getCreationDateFormat() {

        if (creationDate != null) {
            return creationDate.format(dateFormat);
        }
        return "";
    }

    public void setCreationDate(LocalDateTime creationDate) {
        this.creationDate = creationDate;
    }

    public LocalDateTime getDeadline() {
        return deadline;
    }

    public String getDeadlineFormat() {

        if (deadline != null) {
            return deadline.format(dateFormat);
        }
        return "";
    }

    public void setDeadline(LocalDateTime deadline) {
        this.deadline = deadline;
    }

    public Set<OrderItem> getAccessories() {
        return accessories;
    }

    public void setAccessories(Set<OrderItem> accessories) {

        this.accessories.retainAll(accessories);
        this.accessories.addAll(accessories);
        for (OrderItem orderItem : accessories) {
            orderItem.setOrder(this);
        }

    }

    public Set<Wood> getWoodList() {
        return woodList;
    }

    public void setWoodList(Set<Wood> woodList) {

        this.woodList.retainAll(woodList);
        this.woodList.addAll(woodList);
        for (Wood wood : woodList) {
            wood.setOrder(this);
        }
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public boolean isNew() {
        return id == null;
    }

    public boolean isExpired() {
        return deadline != null && deadline.isBefore(LocalDateTime.now()) &&
                status != OrderStatus.CLOSED && status != OrderStatus.CART;
    }

    public DateTimeFormatter getDateFormat() {
        return dateFormat;
    }

    public void setDateFormat(DateTimeFormatter dateFormat) {
        this.dateFormat = dateFormat;
    }

    public Boolean getDelivery() {
        return delivery;
    }

    public void setDelivery(Boolean delivery) {
        this.delivery = delivery;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public Boolean getInstallation() {
        return installation;
    }

    public void isInstallation(Boolean installation) {
        this.installation = installation;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Order order = (Order) o;
        return id.equals(order.id) && Objects.equals(customer, order.customer) && cost.equals(order.cost) && productType.equals(order.productType) && status.equals(order.status) && creationDate.equals(order.creationDate) && Objects.equals(deadline, order.deadline);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, customer, cost, productType, status, creationDate, deadline);
    }
}