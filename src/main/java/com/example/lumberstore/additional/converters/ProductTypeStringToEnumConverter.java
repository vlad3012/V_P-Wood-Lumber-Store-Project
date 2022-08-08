package com.example.lumberstore.additional.converters;

import com.example.lumberstore.additional.enums.ProductType;
import com.example.lumberstore.additional.enums.ProductType;
import org.springframework.core.convert.converter.Converter;

import java.util.Locale;

public class ProductTypeStringToEnumConverter implements Converter<String, ProductType> {

    @Override
    public ProductType convert(String s) {
        return ProductType.valueOf(s.toUpperCase(Locale.ROOT));
    }
}
