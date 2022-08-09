package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.entity.components.Accessory;
import com.example.lumberstore.entity.components.WoodType;
import com.example.lumberstore.entity.components.Processing;
import com.example.lumberstore.services.interfaces.PriceListService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class PriceListServiceImp implements PriceListService {

    private final ComponentServiceFactory componentServiceFactory;

    @Autowired
    public PriceListServiceImp(ComponentServiceFactory componentServiceFactory) {
        this.componentServiceFactory = componentServiceFactory;
    }

    @Override
    public void updatePriceListWoodType(String tableJson) {

        ObjectMapper objectMapper = new ObjectMapper();

        List<WoodType> table = null;
        try {
            table = objectMapper.readValue(tableJson, new TypeReference<List<WoodType>>() {
            });
        } catch (IOException e) {
            e.printStackTrace();
        }

        for (WoodType item : table) {
            componentServiceFactory.getComponentService(ComponentType.WOOD_TYPE).updateComponentPrices(item);
        }
    }

    @Override
    public void updatePriceListProcessing(String tableJson) {

        ObjectMapper objectMapper = new ObjectMapper();

        List<Processing> table = null;
        try {
            table = objectMapper.readValue(tableJson, new TypeReference<List<Processing>>() {
            });
        } catch (IOException e) {
            e.printStackTrace();
        }

        for (Processing item : table) {
            componentServiceFactory.getComponentService(ComponentType.PROCESSING).updateComponentPrices(item);
        }
    }

    @Override
    public void updatePriceListAccessory(String tableJson) {

        ObjectMapper objectMapper = new ObjectMapper();

        List<Accessory> table = null;
        try {
            table = objectMapper.readValue(tableJson, new TypeReference<List<Accessory>>() {
            });
        } catch (IOException e) {
            e.printStackTrace();
        }

        for (Accessory item : table) {
            componentServiceFactory.getComponentService(ComponentType.ACCESSORY).updateComponentPrices(item);
        }
    }
}
