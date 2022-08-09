package com.example.lumberstore.repository.interfaces;

import com.example.lumberstore.entity.components.Accessory;
import com.example.lumberstore.entity.components.WoodType;
import com.example.lumberstore.entity.components.Processing;

import java.util.List;

public interface ComponentDao {

    List<WoodType> getWoodTypeAll();
    WoodType getWoodTypeById(Long id);
    void addWoodType(WoodType woodType);
    void updateWoodType(WoodType woodType);
    void updateWoodTypePrices(WoodType woodType);
    void deleteWoodType(WoodType woodType);

    List<Accessory> getAccessoryAll();
    Accessory getAccessoryById(Long id);
    void addAccessory(Accessory accessory);
    void updateAccessory(Accessory accessory);
    void updateAccessoryPrices(Accessory accessory);
    void deleteAccessory(Accessory accessory);

    List<Processing> getProcessingAll();
    Processing getProcessingById(Long id);
    void addProcessing(Processing processing);
    void updateProcessing(Processing processing);
    void updateProcessingPrices(Processing processing);
    void deleteProcessing(Processing processing);

}
