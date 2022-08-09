package com.example.lumberstore.repository;

import com.example.lumberstore.entity.components.Accessory;
import com.example.lumberstore.entity.components.WoodType;
import com.example.lumberstore.entity.components.Processing;
import com.example.lumberstore.repository.interfaces.ComponentDao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ComponentDaoImp implements ComponentDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ComponentDaoImp(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<WoodType> getWoodTypeAll() {

        Session session = sessionFactory.getCurrentSession();
        List<WoodType> woodTypeList = session.createQuery("from WoodType", WoodType.class).getResultList();
        return woodTypeList;
    }

    @Override
    public WoodType getWoodTypeById(Long id) {
        return sessionFactory.getCurrentSession().get(WoodType.class, id);
    }

    @Override
    public void addWoodType(WoodType woodType) {
        sessionFactory.getCurrentSession().save(woodType);
    }

    @Override
    public void updateWoodType(WoodType woodType) {
        WoodType woodTypeToUpdate = getWoodTypeById(woodType.getId());
        woodTypeToUpdate.setName(woodType.getName());
        woodTypeToUpdate.setDiameter(woodType.getDiameter());
        sessionFactory.getCurrentSession().update(woodTypeToUpdate);
    }

    @Override
    public void updateWoodTypePrices(WoodType woodType) {
        WoodType woodTypeToUpdate = getWoodTypeById(woodType.getId());
        woodTypeToUpdate.setPriceUSD(woodType.getPriceUSD());
        woodTypeToUpdate.setPrice(woodType.getPrice());
        sessionFactory.getCurrentSession().update(woodTypeToUpdate);
    }

    @Override
    public void deleteWoodType(WoodType woodType) {
        sessionFactory.getCurrentSession().delete(woodType);
    }

    @Override
    public List<Accessory> getAccessoryAll() {

        Session session = sessionFactory.openSession();
        List<Accessory> accessoryList = session.createQuery("from Accessory", Accessory.class).getResultList();
        return accessoryList;

    }

    @Override
    public Accessory getAccessoryById(Long id) {
        return sessionFactory.getCurrentSession().get(Accessory.class, id);
    }

    @Override
    public void addAccessory(Accessory accessory) {
        sessionFactory.getCurrentSession().save(accessory);
    }

    @Override
    public void updateAccessory(Accessory accessory) {
        Accessory accessoryTypeToUpdate = getAccessoryById(accessory.getId());
        accessoryTypeToUpdate.setName(accessory.getName());
        sessionFactory.getCurrentSession().update(accessoryTypeToUpdate);
    }

    @Override
    public void updateAccessoryPrices(Accessory accessory) {
        Accessory accessoryTypeToUpdate = getAccessoryById(accessory.getId());
        accessoryTypeToUpdate.setPriceUSD(accessory.getPriceUSD());
        accessoryTypeToUpdate.setPrice(accessory.getPrice());
        sessionFactory.getCurrentSession().update(accessoryTypeToUpdate);
    }

    @Override
    public void deleteAccessory(Accessory accessory) {
        sessionFactory.getCurrentSession().delete(accessory);
    }

    @Override
    public List<Processing> getProcessingAll() {

        Session session = sessionFactory.openSession();
        List<Processing> processingList = session.createQuery("from Processing", Processing.class).getResultList();
        return processingList;
    }

    @Override
    public Processing getProcessingById(Long id) {
        return sessionFactory.getCurrentSession().get(Processing.class, id);
    }

    @Override
    public void addProcessing(Processing processing) {
        sessionFactory.getCurrentSession().save(processing);

    }

    @Override
    public void updateProcessing(Processing processing) {
        Processing processingToUpdate = getProcessingById(processing.getId());
        processingToUpdate.setType(processing.getType());
        processingToUpdate.setName(processing.getName());
        processingToUpdate.setSymbol(processing.getSymbol());
        sessionFactory.getCurrentSession().update(processingToUpdate);
    }

    @Override
    public void updateProcessingPrices(Processing processing) {
        Processing processingToUpdate = getProcessingById(processing.getId());
        processingToUpdate.setPriceUSD(processing.getPriceUSD());
        processingToUpdate.setPrice(processing.getPrice());
        sessionFactory.getCurrentSession().update(processingToUpdate);
    }

    @Override
    public void deleteProcessing(Processing processing) {
        sessionFactory.getCurrentSession().delete(processing);
    }


}
