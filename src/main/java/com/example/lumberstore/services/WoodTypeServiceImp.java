package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.entity.components.DefaultComponent;
import com.example.lumberstore.entity.components.WoodType;
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
public class WoodTypeServiceImp implements ComponentService<WoodType> {

    private final ComponentDao componentDao;

    @Autowired
    public WoodTypeServiceImp(ComponentDao componentDao) {
        this.componentDao = componentDao;
    }

    @Override
    public List<WoodType> getComponentList() {
        return componentDao.getWoodTypeAll();
    }

    @Override
    public void addComponent(WoodType component) {

        component.setPrice(0.0F);
        component.setPriceUSD(0.0F);
        componentDao.addWoodType(component);
    }

    @Override
    public WoodType getComponentById(Long id) {
        return componentDao.getWoodTypeById(id);
    }

    @Override
    public void updateComponent(WoodType component) {
        componentDao.updateWoodType(component);
    }

    @Override
    public void deleteComponent(WoodType component) {
        componentDao.deleteWoodType(component);
    }

    @Override
    public void updateComponentPrices(WoodType component) {
        componentDao.updateWoodTypePrices(component);
    }

    @Override
    public boolean canHandle(ComponentType componentType) {
        return componentType == ComponentType.WOOD_TYPE;
    }

    @Override
    public WoodType getEmptyComponent() {
        return new WoodType();
    }

    @Override
    public DefaultComponent extractComponentFromRequest(Map<String, String> params) throws ComponentExtractionException {

        WoodType woodType = new WoodType();
        woodType.setName(params.get("name"));
        try {
            if (!params.get("id").isEmpty()) {
                woodType.setId(Long.parseLong(params.get("id")));
            }
            if (!params.get("thickness").isEmpty()) {
                woodType.setDiameter(Integer.parseInt(params.get("thickness")));
            }
        } catch (NumberFormatException exception) {
            throw new ComponentExtractionException();
        }

        return woodType;
    }

}
