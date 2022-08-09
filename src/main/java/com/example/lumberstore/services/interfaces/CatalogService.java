package com.example.lumberstore.services.interfaces;

import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface CatalogService {

    Catalog createItem(MultipartFile multipartFile, ProductType productType) ;
    void updateItem(Catalog catalog);
    void deleteItem(Long id);
    List<Catalog> getItemsByProductType(ProductType productType);
    Catalog getItemById(Long id);
    void prepareForView(Catalog catalog, ProductType productType);
}
