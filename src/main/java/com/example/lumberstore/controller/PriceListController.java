package com.example.lumberstore.controller;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.additional.JsonResponse;
import com.example.lumberstore.entity.components.Accessory;
import com.example.lumberstore.entity.components.WoodType;
import com.example.lumberstore.entity.components.Processing;
import com.example.lumberstore.services.ComponentServiceFactory;
import com.example.lumberstore.services.LocaleMessageHandler;
import com.example.lumberstore.services.interfaces.PriceListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/priceList")
public class PriceListController {

    private final ComponentServiceFactory componentServiceFactory;
    private final PriceListService priceListService;
    private final LocaleMessageHandler localeMessageHandler;

    @Autowired
    public PriceListController(ComponentServiceFactory componentServiceFactory,
                               PriceListService priceListService,
                               LocaleMessageHandler localeMessageHandler) {

        this.componentServiceFactory = componentServiceFactory;
        this.priceListService = priceListService;
        this.localeMessageHandler = localeMessageHandler;
    }

    @GetMapping("/all")
    public ModelAndView priceListAll() {

        ModelAndView modelAndView = new ModelAndView("admin/priceLists");

        List<WoodType> woodTypeList = componentServiceFactory.getComponentService(ComponentType.WOOD_TYPE).getComponentList();
        List<Processing> processingList = componentServiceFactory.getComponentService(ComponentType.PROCESSING).getComponentList();
        List<Accessory> accessoryList = componentServiceFactory.getComponentService(ComponentType.PROCESSING).getComponentList();;

        modelAndView.addObject("woodTypeList", woodTypeList);
        modelAndView.addObject("processingList", processingList);
        modelAndView.addObject("accessoryList", accessoryList);

        return modelAndView;
    }

    @PostMapping("/")
    @ResponseBody
    public JsonResponse priceListSave(@RequestParam Map<String,String> allParams) {

        priceListService.updatePriceListWoodType(allParams.get("WoodList"));
        priceListService.updatePriceListProcessing(allParams.get("processingList"));
        priceListService.updatePriceListAccessory(allParams.get("accessoryList"));

        JsonResponse response = new JsonResponse();
        response.setStatus(HttpStatus.OK);
        response.setMessage(localeMessageHandler.getMessage("message.notification.priceList.save.success"));

        return response;
    }
}
