package com.example.lumberstore.repository;

import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import com.example.lumberstore.repository.interfaces.CatalogDao;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class CatalogDaoImp implements CatalogDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public CatalogDaoImp(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void saveOrUpdateItem(Catalog catalog) {

        sessionFactory.getCurrentSession().saveOrUpdate(catalog);
    }

    @Override
    public void deleteItem(Catalog catalog) {

        sessionFactory.getCurrentSession().delete(catalog);
    }

    @Override
    public List<Catalog> getItemsByProductType(ProductType productType) {

        List<Catalog> catalogList = sessionFactory.getCurrentSession()
                .createNamedQuery("get_catalog_by_productType", Catalog.class)
                .setParameter("product_type", productType.toString())
                .getResultList();

        return catalogList;
    }

    @Override
    public Optional<Catalog> getItemById(Long id) {

        return Optional.ofNullable(sessionFactory.getCurrentSession().get(Catalog.class, id));
    }
}
