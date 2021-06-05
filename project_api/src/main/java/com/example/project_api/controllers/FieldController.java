package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.tables.Field;
import com.example.project_api.models.tables.FieldImage;
import com.example.project_api.services.FieldImageService;
import com.example.project_api.services.FieldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/field")
public class FieldController {

    @Autowired
    private FieldService fieldService;

    @Autowired
    private FieldImageService imageService;

    @GetMapping("/index")
    public Object index() {
        return "index";
    }

    @GetMapping("/findAll")
    public Object findAll() {
        return fieldService.findAll();
    }

    @GetMapping("/findByUserId/{userId}")
    public Object findByUserId(@PathVariable long userId) {
        return fieldService.findByUserId(userId);
    }

    @GetMapping("/findById/{fieldId}")
    public Object findById(@PathVariable long fieldId) {
        return fieldService.findById(fieldId);
    }


    @PostMapping("/create")
    public Object create(@RequestBody Field field) {
        return fieldService.create(field);
    }

    @PostMapping("/update")
    public Object update(@RequestBody Field field) {
        return fieldService.update(field);
    }

    @GetMapping("/delete/{fieldId}")
    public Object delete(@PathVariable long fieldId) {
        return fieldService.delete(fieldId);
    }

    @PostMapping("/upload-image")
    public String uploadImage(@RequestParam long fieldId, @RequestParam("file") MultipartFile file) throws IOException {
        if (imageService.uploadImage(fieldId, file)) {
            return ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path("/field/download-image/" + fieldId + "/")
                    .path(Objects.requireNonNull(file.getOriginalFilename()))
                    .toUriString();
        }
        return "Error Upload-image";
    }

    @PostMapping("/upload-images")
    public List<?> uploadImages(@RequestParam long fieldId, @RequestParam("files") MultipartFile[] files) throws IOException {
        imageService.deleteImages(fieldId);
        return Arrays.stream(files)
                .map(file -> {
                    try {
                        return uploadImage(fieldId, file);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    return null;
                })
                .collect(Collectors.toList());
    }

    @GetMapping("/download-image/{fieldId}/{fileName}")
    public ResponseEntity<?> downloadFromDB(@PathVariable long fieldId, @PathVariable String fileName) {
        return imageService.downloadImage(fieldId, fileName);
    }

    @GetMapping("/urlImages/{fieldId}")
    public List<?> urlImages(@PathVariable long fieldId) {
        List<FieldImage> images = imageService.findByFieldId(fieldId);
        Collections.sort(images);
        List<String> urlImages = new ArrayList<>();
        if (!images.isEmpty()) {
            for (var file : images) {
                String urlImage = ServletUriComponentsBuilder
                        .fromCurrentContextPath()
                        .path("/field/download-image/" + fieldId + "/")
                        .path(file.getFileName())
                        .toUriString();
                urlImages.add(urlImage);
            }
            return urlImages;
        }
        return null;
    }

}
