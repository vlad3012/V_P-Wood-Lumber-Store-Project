package com.example.lumberstore.entity;
import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.components.Wood;
import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@NamedQuery(name = "get_catalog_by_productType", query = "from Catalog where product_type=:product_type")

@Entity
public class Catalog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "product_type")
    private ProductType productType;

    @OneToOne()
    @JoinColumn(name = "image_id")
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.DELETE})
    private Image image;

    @OneToMany(fetch = FetchType.EAGER,
            mappedBy = "catalog", orphanRemoval = true)
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.DELETE})
    private Set<Wood> woodList = new HashSet<>();

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "catalog", orphanRemoval = true)
    @Cascade({org.hibernate.annotations.CascadeType.ALL})
    private Set<CatalogItem> accessories = new HashSet<>();

    public Catalog() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    public Set<Wood> getWoodList() {
        return woodList;
    }

    public void setGlassList(Set<Wood> woodList) {

        this.woodList.retainAll(woodList);
        this.woodList.addAll(woodList);
        for (Wood wood : woodList) {
            wood.setCatalog(this);
        }
    }

    public boolean isEmpty() {
        return woodList.isEmpty();
    }

    public Set<CatalogItem> getAccessories() {
        return accessories;
    }

    public void setAccessories(Set<CatalogItem> accessories) {

        this.accessories.retainAll(accessories);
        this.accessories.addAll(accessories);
        for (CatalogItem catalogItem : accessories) {
            catalogItem.setCatalog(this);
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Catalog catalog = (Catalog) o;
        return id.equals(catalog.id) && productType == catalog.productType;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, productType);
    }
}
