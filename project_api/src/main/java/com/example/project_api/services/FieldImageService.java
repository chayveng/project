package com.example.project_api.services;

import com.example.project_api.models.repository.FieldImageRepository;
import com.example.project_api.models.tables.FieldImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class FieldImageService {

    @Autowired
    private FieldImageRepository repository;


    public List<FieldImage> findByFieldId(long fieldId) {
        return repository.findByFieldId(fieldId);
    }

    public boolean uploadImage(long fieldId, MultipartFile file) throws IOException {
        FieldImage image = new com.example.project_api.models.tables.FieldImage();
        image.setFieldId(fieldId);
        image.setFileName(file.getOriginalFilename());
        image.setFile(file.getBytes());
        try {
            repository.save(image);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean deleteImages(long fieldId) {
        List<FieldImage> images = findByFieldId(fieldId);
        if (!images.isEmpty()) {
            for (var file : images) {
                repository.deleteById(file.getId());
            }
            return true;
        }
        return false;
    }


    public ResponseEntity<?> downloadImage(long fieldId,String fileName) {
        Optional<FieldImage> image = repository.findByFieldIdAndFileName(fieldId,fileName);
        if (image.isPresent()) {
            return ResponseEntity
                    .ok()
                    .contentType(MediaType.parseMediaType(MediaType.IMAGE_PNG_VALUE))
                    .body(image.get().getFile());
        } else {
            return ResponseEntity.status(404).build();
        }
    }


}
