package com.example.lumberstore.controller;

import com.example.lumberstore.additional.JsonResponse;
import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.services.LocaleMessageHandler;
import com.example.lumberstore.services.interfaces.CatalogService;
import com.example.lumberstore.validation.CatalogValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/catalog")
public class CatalogController {

    private final CatalogService catalogService;
    private final CatalogValidator catalogValidator;
    private final LocaleMessageHandler localeMessageHandler;

    @Autowired
    public CatalogController(CatalogService catalogService,
                             CatalogValidator catalogValidator,
                             LocaleMessageHandler localeMessageHandler) {

        this.catalogService = catalogService;
        this.catalogValidator = catalogValidator;
        this.localeMessageHandler = localeMessageHandler;
    }

    @InitBinder("catalog")
    protected void initBinder(WebDataBinder binder) {

        binder.setValidator(catalogValidator);
    }

    @GetMapping("/")
    public ModelAndView catalog(@RequestParam(defaultValue = "mirror") ProductType productType) {

        ModelAndView modelAndView = new ModelAndView("user/catalog");

        modelAndView.addObject("productType", productType);
        modelAndView.addObject("listOfItems", catalogService.getItemsByProductType(productType));

        return modelAndView;
    }

    @GetMapping("/settings/list")
    public ModelAndView catalogSettings(@RequestParam(defaultValue = "mirror") ProductType productType) {

        ModelAndView modelAndView = new ModelAndView("admin/catalog/settings");

        modelAndView.addObject("activeType", productType);
        modelAndView.addObject("listOfItems", catalogService.getItemsByProductType(productType));
        modelAndView.addObject("productTypes", ProductType.values());

        return modelAndView;
    }

    @GetMapping("/settings")
    public ModelAndView catalogAddItem(@RequestParam(required = false) ProductType productType) {

        ModelAndView modelAndView = new ModelAndView("admin/catalog/add");
        modelAndView.addObject("activeType", productType);
        modelAndView.addObject("productTypes", ProductType.values());

        return modelAndView;
    }

    @GetMapping("/settings/{id}")
    public ModelAndView catalogShowItem(@PathVariable("id") Long id) {

        ModelAndView modelAndView = new ModelAndView("admin/catalog/show");

        Catalog catalog = catalogService.getItemById(id);
        modelAndView.addObject("catalog", catalog);

        return modelAndView;
    }

    @PostMapping("/settings/{id}/delete")
    @ResponseBody
    public JsonResponse catalogDeleteItem(@PathVariable("id") Long id) {

        JsonResponse jsonResponse = new JsonResponse();

        catalogService.deleteItem(id);
        jsonResponse.setStatus(HttpStatus.OK);
        jsonResponse.setMessage(localeMessageHandler.getMessage("message.notification.catalog.delete.success"));

        return jsonResponse;
    }

    @GetMapping("/settings/{id}/updateGlass")
    public ModelAndView updateGlass(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {

        ModelAndView modelAndView = new ModelAndView("redirect:/calculator/");

        Catalog catalog = catalogService.getItemById(id);

        redirectAttributes.addFlashAttribute("catalog", catalog);
        redirectAttributes.addFlashAttribute("isTemplate", true);

        return modelAndView;
    }

    @PostMapping("/settings")
    @ResponseBody
    public JsonResponse catalogSaveItem(@RequestBody @Validated Catalog catalog,
                                            BindingResult result) {

        JsonResponse response = new JsonResponse();

        if (result.hasErrors()) {
            response.setStatus(HttpStatus.BAD_REQUEST);
            response.setResult(result.getAllErrors());
            return response;
        }

        catalogService.updateItem(catalog);
        response.setStatus(HttpStatus.OK);
        response.setRedirect(true);
        response.setRedirectUrl("/catalog/settings/" + catalog.getId());

        return response;
    }


    @PostMapping("/settings/upload")
    @ResponseBody
    public JsonResponse catalogUploadFile(@RequestParam MultipartFile file, @RequestParam ProductType productType)
            throws RuntimeException {

        JsonResponse jsonResponse = new JsonResponse();

        Catalog catalog = catalogService.createItem(file, productType);
        jsonResponse.setStatus(HttpStatus.OK);
        jsonResponse.setRedirect(true);
        jsonResponse.setRedirectUrl("/catalog/settings/"+catalog.getId());

        return jsonResponse;
    }

    @GetMapping("/displayImage")
    public void catalogDisplayImage(@RequestParam Long id, HttpServletResponse response)
            throws IOException {

        Catalog catalog = catalogService.getItemById(id);
        response.setContentType("image/jpg,image/png");
        response.getOutputStream().write(catalog.getImage().getData());

        response.getOutputStream().close();
    }

}
