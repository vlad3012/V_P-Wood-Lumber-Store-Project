package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.entity.Order;
import com.example.lumberstore.entity.OrderItem;
import com.example.lumberstore.entity.components.Accessory;
import com.example.lumberstore.entity.components.WoodType;
import com.example.lumberstore.entity.components.Processing;
import com.example.lumberstore.entity.components.Wood;
import com.example.lumberstore.services.interfaces.CalculatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class CalculatorServiceImp implements CalculatorService {

    private final ComponentServiceFactory componentServiceFactory;

    @Autowired
    public CalculatorServiceImp(ComponentServiceFactory componentServiceFactory) {
        this.componentServiceFactory = componentServiceFactory;
    }

    @Override
    public float calculatePrice(Order order) {

        Set<Wood> woodList = order.getWoodList();
        Set<OrderItem> orderItems = order.getAccessories();
        float price = 0;

        for (Wood wood : woodList) {

            float currentWoodPrice;

            float square = wood.getShape().getSquare(wood.getWidth(), wood.getHeight());
            float perimeter = wood.getShape().getPerimeter(wood.getWidth(), wood.getHeight());

            WoodType woodType = (WoodType) componentServiceFactory.getComponentService(ComponentType.WOOD_TYPE).getComponentById(wood.getWoodType().getId());
            currentWoodPrice = square * woodType.getPrice();
            for (Processing currentProcessing : wood.getProcessingList()) {

                Processing processing = (Processing) componentServiceFactory.getComponentService(ComponentType.PROCESSING).getComponentById(currentProcessing.getId());
                currentWoodPrice += processing.getPrice() * perimeter * (currentProcessing.getQuantity() != 0 ? currentProcessing.getQuantity() : 1);
            }

            price += currentWoodPrice * wood.getAmount();
        }

        if (order.getInstallation()) {

            price *= order.getProductType().getRatio();
        }

        for (OrderItem orderItem : orderItems) {

            Accessory accessory = (Accessory) componentServiceFactory.getComponentService(ComponentType.ACCESSORY).getComponentById(orderItem.getComponent().getId());
            price += accessory.getPrice() * orderItem.getAmount();

        }

        return Math.round(price);
    }
}
