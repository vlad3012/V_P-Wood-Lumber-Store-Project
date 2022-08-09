package com.example.lumberstore.repository.interfaces;

import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;

import java.util.List;
import java.util.Optional;

public interface CatalogDao {

    void saveOrUpdateItem(Catalog catalog); //save
    void deleteItem(Catalog catalog);
    List<Catalog> getItemsByProductType(ProductType productType);
    Optional<Catalog> getItemById(Long id);
}
