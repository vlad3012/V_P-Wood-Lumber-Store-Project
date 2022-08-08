package com.example.lumberstore.additional.enums;

public enum OrderStatus {

    ACTIVE("active"),
    PAID("paid"),
    CLOSED("closed"),
    CART("cart");

    private String name;

    OrderStatus(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
