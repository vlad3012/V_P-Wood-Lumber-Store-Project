package com.example.lumberstore.services;

import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.entity.Image;
import com.example.lumberstore.entity.components.Wood;
import com.example.lumberstore.exceptions.notFoundExceptions.CatalogNotFoundException;
import com.example.lumberstore.repository.interfaces.CatalogDao;
import com.example.lumberstore.services.interfaces.CatalogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Service
public class CatalogServiceImp implements CatalogService {

    private final ImageStorageService imageStorageService;
    private final CatalogDao catalogDao;

    @Autowired
    public CatalogServiceImp(ImageStorageService imageStorageService, CatalogDao catalogDao) {

        this.imageStorageService = imageStorageService;
        this.catalogDao = catalogDao;
    }

    @Override
    @Transactional
    public Catalog createItem(MultipartFile file, ProductType productType) {

        try {
            Image image = imageStorageService.getImageFile(file);
            Catalog catalog = new Catalog();
            catalog.setImage(image);
            catalog.setProductType(productType);

            catalogDao.saveOrUpdateItem(catalog);
            return catalog;
        } catch (IOException exception) {
            throw new RuntimeException("Cannot store the image!");
        }
    }

    @Override
    @Transactional
    public void updateItem(Catalog catalog) {

        Catalog catalogToUpdate = getItemById(catalog.getId());
        catalogToUpdate.setWoodList(catalog.getWoodList());
        catalogToUpdate.setProductType(catalog.getProductType());
        catalogToUpdate.setAccessories(catalog.getAccessories());

        catalogDao.saveOrUpdateItem(catalogToUpdate);
    }

    @Override
    @Transactional
    public void deleteItem(Long id) {

        Catalog catalog = getItemById(id);
        catalogDao.deleteItem(catalog);
    }

    @Override
    @Transactional
    public List<Catalog> getItemsByProductType(ProductType productType) {

        return catalogDao.getItemsByProductType(productType);
    }

    @Override
    @Transactional
    public Catalog getItemById(Long id) {

        return catalogDao.getItemById(id)
                .orElseThrow(() -> new CatalogNotFoundException(id));
    }

    @Override
    public void prepareForView(Catalog catalog, ProductType productType) {

        if (catalog.isEmpty()) {
            List<Wood> woodList = new ArrayList<Wood>();
            woodList.add(new Wood());

            catalog.setWoodList(new HashSet<>(woodList));

            if (productType != null) {
                catalog.setProductType(productType);
            }
        }
    }
}
