package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.entity.components.DefaultComponent;
import com.example.lumberstore.exceptions.ComponentExtractionException;

import java.util.List;
import java.util.Map;

public interface ComponentService<Type> {

    List<Type> getComponentList();
    void addComponent(Type component);
    Type getComponentById(Long id);
    void updateComponent(Type component);
    void deleteComponent(Type component);
    void updateComponentPrices(Type component);

    boolean canHandle(ComponentType componentType);
    Type getEmptyComponent();
    DefaultComponent extractComponentFromRequest(Map<String, String> params) throws ComponentExtractionException;
}
