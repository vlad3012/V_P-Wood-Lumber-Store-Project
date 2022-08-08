package com.example.lumberstore.additional.converters;

import com.example.lumberstore.additional.enums.ComponentType;
import com.example.lumberstore.additional.enums.ComponentType;
import org.springframework.core.convert.converter.Converter;

public class ComponentTypeStringToEnumConverter implements Converter<String, ComponentType> {

    @Override
    public ComponentType convert(String s) {
        return ComponentType.valueOfName(s);
    }
}
