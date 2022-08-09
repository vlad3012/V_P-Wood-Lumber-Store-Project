package com.example.lumberstore.validation;

import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.entity.Catalog;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CatalogValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return Catalog.class.equals(aClass);
    }

    @Override
    public void validate(Object object, Errors errors) {

        Catalog catalog = (Catalog) object;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "productType", "NotEmpty.calculator.productType");

        if(catalog.getProductType() == ProductType.WOOD){
            errors.rejectValue("productType", "NotEmpty.calculator.productType");
        }
    }
}
