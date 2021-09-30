package com.soccerhub.api.controllers;

import com.soccerhub.api.models.tables.Field;
import com.soccerhub.api.services.FieldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/field")
public class FieldController {

    @Autowired
    private FieldService service;

    @GetMapping("/index")
    public Object index() {
        return "index";
    }

    @GetMapping("/findAll")
    public Object findAll() {
        return service.findAll();
    }

    @GetMapping("/findByUserId/{userId}")
    public Object findByUserId(@PathVariable long userId) {
        return service.findByUserId(userId);
    }

    @GetMapping("/findById/{fieldId}")
    public Object findById(@PathVariable long fieldId) {
        return service.findById(fieldId);
    }

    @PostMapping("/create")
    public Object create(@RequestBody Field field) {
        return service.create(field);
    }

    @PostMapping("/update")
    public Object update(@RequestBody Field field) {
        return service.update(field);
    }

    @DeleteMapping("/delete/{fieldId}")
    public Object delete(@PathVariable long fieldId) {
        return service.delete(fieldId);
    }

    // >> image controller
    @PostMapping("/upload-images")
    public Object uploadImage(@RequestParam("fieldId") long fieldId, @RequestParam("files") MultipartFile[] files) {
        return service.uploadImages(fieldId, files);
    }

    @GetMapping("/download-image/{fileName}")
    public Object downloadImage(@PathVariable String fileName) {
        return service.downloadImage(fileName);
    }

    @GetMapping("/fileNameImages/{fieldId}")
    public List<?> fileNameImages(@PathVariable long fieldId) {
        return service.fileNameImages(fieldId);
    }
    // << image controller
}
