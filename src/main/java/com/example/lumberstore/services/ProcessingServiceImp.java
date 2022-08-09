package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.additional.enums.ProcessingType;
import com.example.lumberstore.entity.components.DefaultComponent;
import com.example.lumberstore.entity.components.Processing;
import com.example.lumberstore.exceptions.ComponentExtractionException;
import com.example.lumberstore.repository.interfaces.ComponentDao;
import com.example.lumberstore.services.interfaces.ComponentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Locale;
import java.util.Map;

@Service
@Transactional
public class ProcessingServiceImp implements ComponentService<Processing> {

    private final ComponentDao componentDao;

    @Autowired
    public ProcessingServiceImp(ComponentDao componentDao) {
        this.componentDao = componentDao;
    }

    @Override
    public List<Processing> getComponentList() {
        return componentDao.getProcessingAll();
    }

    @Override
    public void addComponent(Processing component) {

        component.setPrice(0.0F);
        component.setPriceUSD(0.0F);
        componentDao.addProcessing(component);
    }

    @Override
    public Processing getComponentById(Long id) {
        return componentDao.getProcessingById(id);
    }

    @Override
    public void updateComponent(Processing component) {
        componentDao.updateProcessing(component);
    }

    @Override
    public void deleteComponent(Processing component) {
        componentDao.deleteProcessing(component);
    }

    @Override
    public void updateComponentPrices(Processing component) {
        componentDao.updateProcessingPrices(component);
    }

    @Override
    public boolean canHandle(ComponentType componentType) {
        return componentType == ComponentType.PROCESSING;
    }

    @Override
    public Processing getEmptyComponent() {
        return new Processing();
    }

    @Override
    public DefaultComponent extractComponentFromRequest(Map<String, String> params) throws ComponentExtractionException {

        Processing processing = new Processing();
        try {
            if(!params.get("id").isEmpty()) {
                processing.setId(Long.parseLong(params.get("id")));
            }
        } catch (NumberFormatException exception){
            throw new ComponentExtractionException();
        }
        processing.setType(ProcessingType.valueOf(params.get("type").toUpperCase(Locale.ROOT)));
        processing.setName(params.get("name"));
        processing.setSymbol(params.get("symbol"));

        return processing;
    }
}
