package com.example.lumberstore.additional.enums;

public enum ProductType {

    WOOD("wood", 1.1),
   LINING("LINING", 1.2), //вагонка
    BOARD("BOARD", 1.5);


    private String name;

    private double ratio;

    ProductType(String name, double ratio) {

        this.name = name;
        this.ratio = ratio;
    }

    public String getName() {
        return name;
    }

    public double getRatio() {
        return ratio;
    }
}
