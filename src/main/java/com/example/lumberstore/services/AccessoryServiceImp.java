package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.entity.components.Accessory;
import com.example.lumberstore.entity.components.DefaultComponent;
import com.example.lumberstore.exceptions.ComponentExtractionException;
import com.example.lumberstore.repository.interfaces.ComponentDao;
import com.example.lumberstore.services.interfaces.ComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AccessoryServiceImp implements ComponentService<Accessory> {

    private final ComponentDao componentDao;

    @Autowired
    public AccessoryServiceImp(ComponentDao componentDao) {
        this.componentDao = componentDao;
    }

    @Override
    public List<Accessory> getComponentList() {
        return componentDao.getAccessoryAll();
    }

    @Override
    public void addComponent(Accessory component) {

        component.setPrice(0.0F);
        component.setPriceUSD(0.0F);
        componentDao.addAccessory(component);

    }

    @Override
    public Accessory getComponentById(Long id) {
        return componentDao.getAccessoryById(id);
    }

    @Override
    public void updateComponent(Accessory accessory) {
        componentDao.updateAccessory(accessory);
    }

    @Override
    public void deleteComponent(Accessory component) {
        componentDao.deleteAccessory(component);
    }

    @Override
    public void updateComponentPrices(Accessory accessory) {
        componentDao.updateAccessoryPrices(accessory);
    }

    @Override
    public boolean canHandle(ComponentType componentType) {
        return componentType == ComponentType.ACCESSORY;
    }

    @Override
    public Accessory getEmptyComponent() {
        return new Accessory();
    }

    @Override
    public DefaultComponent extractComponentFromRequest(Map<String, String> params) throws ComponentExtractionException {

        Accessory accessory = new Accessory();
        accessory.setName(params.get("name"));
        try {
            if (!params.get("id").isEmpty()) {
                accessory.setId(Long.parseLong(params.get("id")));
            }
        } catch (NumberFormatException exception) {
            throw new ComponentExtractionException();
        }

        return accessory;
    }
}
