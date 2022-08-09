package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.services.interfaces.ComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComponentServiceFactory {

    private final List<ComponentService> componentServiceList;

    @Autowired
    public ComponentServiceFactory(List<ComponentService> componentServiceList) {
        this.componentServiceList = componentServiceList;
    }

    public ComponentService getComponentService(ComponentType componentType) {

        return componentServiceList.stream()
                .filter(service -> service.canHandle(componentType))
                .findFirst()
                .get();

    }
}
