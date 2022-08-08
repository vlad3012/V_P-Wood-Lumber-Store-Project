package com.example.lumberstore.additional.enums;

public enum ComponentType {

    WOOD_TYPE("woodType"),
    PROCESSING("processing"),
    ACCESSORY("accessory");

    private String name;

    ComponentType(String name) {
        this.name = name;
    }

    public static ComponentType valueOfName(String name){

        for (ComponentType componentType: values()) {
            if(componentType.getName().equals(name)){
                return componentType;
            }
        }

        return null;
    }

    public String getName() {
        return name;
    }
}
