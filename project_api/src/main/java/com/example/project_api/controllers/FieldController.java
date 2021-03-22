package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.FieldRepository;
import com.example.project_api.models.tables.Field;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/field")
public class FieldController {

    @Autowired
    private FieldRepository fieldRepository;

    @GetMapping("/index")
    public Object index() {
        return new ApiResponse(1, "Field API");
    }

    @GetMapping("/getByClubId/{clubId}")
    public Object getByClubId(@PathVariable int clubId) {
        return new ApiResponse(1, "get by Club id", fieldRepository.findByClubId(clubId));
    }

    @GetMapping("/getAll")
    public Object getAll() {
        return new ApiResponse(1, "get All", fieldRepository.findAll());
    }

    @PostMapping("/add")
    public Object add(@RequestBody Field field) {
        Optional<Field> fieldData = fieldRepository.findByTitle(field.getTitle());
        if (fieldData.isEmpty()) {
            fieldRepository.save(field);
            return new ApiResponse(1, "Add a field an succeed", fieldRepository.findByTitle(field.getTitle()));
        } else {
            return new ApiResponse(0, "Add a field fail");
        }
    }

    @PostMapping("/delete/{id}")
    public Object delete(@PathVariable int id) {
        Optional<Field> fieldData = fieldRepository.findById(id);
        if (fieldData.isPresent()) {
            fieldRepository.deleteById(id);
            return new ApiResponse(1, "Delete succeed");
        } else {
            return new ApiResponse(0, "Delete fail");
        }
    }

    @GetMapping("/dummy/{num}")
    public Object dummy(@PathVariable int num) {
        for (int i = 0; i < num; i++) {
            for (int j = 0; j < num; j++) {
                Field _field = new Field();
                _field.setClubId(i);
                _field.setTitle("Field" + j);
                _field.setDetail("detail" + j);
                _field.setStatus(true);
                fieldRepository.save(_field);
            }
        }
        return new ApiResponse(1, "dummy field: " + num + "unit", fieldRepository.findAll());
    }

}
