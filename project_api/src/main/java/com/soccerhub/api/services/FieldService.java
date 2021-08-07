package com.soccerhub.api.services;

import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.FieldRepository;
import com.soccerhub.api.models.tables.Field;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class FieldService {

    @Autowired
    private FieldRepository repository;

    public Object findAll() {
        return new ApiResponse(1, "Field all",repository.findAll());
    }

    public Object findById(long fieldId) {
        return new ApiResponse(1, "Field by id",repository.findById(fieldId));
    }

    public Object findByUserId(long userId) {
        return new ApiResponse(1, "Field by id",repository.findByUserId(userId));
    }

    public Object create(Field field) {
        Optional<Field> fieldDB = repository.findByTitle(field.getTitle());
        if (fieldDB.isEmpty()) {
            repository.save(field);
            return new ApiResponse(1, "created", repository.findByTitle(field.getTitle()));
        } else {
            return new ApiResponse(0, "field exist", repository.findByTitle(field.getTitle()));
        }
    }

    public Object update(Field field) {
        Optional<Field> filedDB = repository.findById(field.getId());
        if (filedDB.isPresent()) {
            repository.save(field);
            return new ApiResponse(1, "updated", repository.findById(field.getId()));
        } else {
            return new ApiResponse(0, "no field");
        }
    }

    public Object delete(long fieldId) {
        Optional<Field> fieldDB = repository.findById(fieldId);
        if (fieldDB.isPresent()) {
            repository.deleteById(fieldId);
            return new ApiResponse(1, "deleted");
        } else {
            return new ApiResponse(0, "no field");
        }
    }
}
