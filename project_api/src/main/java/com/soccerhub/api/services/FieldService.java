package com.soccerhub.api.services;

import com.soccerhub.api.Config;
import com.soccerhub.api.Constants;
import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.FieldImageRepository;
import com.soccerhub.api.models.repository.FieldRepository;
import com.soccerhub.api.models.tables.Field;
import com.soccerhub.api.models.tables.FieldImage;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Log4j2
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

    // >> image service
    final static String URL_DOWNLOAD = "/field/download-image/";

    @Autowired
    FieldImageRepository imageRepository;

    public Object uploadImages(long fieldId, MultipartFile[] files) {
        ApiResponse res = new ApiResponse(0, "uploads fail", null);
        List<FieldImage> images = new ArrayList<FieldImage>();
        boolean deleted = deleteImages(fieldId);
        try {
            for(int i = 0 ; i < files.length ; i++){
                images.add(upload(i,fieldId, files[i]));
            }
            res = new ApiResponse(1, urlImages(fieldId).toString(), images);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    public FieldImage upload(int index,long fieldId, MultipartFile file) throws IOException {
        Constants constants = new Constants();
        FieldImage image = new FieldImage();
        try {
            byte[] bytes = file.getBytes();
            String fileName = index + constants.randomString() + fieldId + ".png";
            Path path = Paths.get(Config.FIELD_IMAGE_PATH + fileName);
            Files.write(path, bytes);
            image = imageRepository.save(new FieldImage(fieldId, fileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return image;
    }

    public Object downloadImage(String fileName) {
        ResponseEntity<Object> response = ResponseEntity.status(404).build();
        try {
            Path path = Paths.get(Config.FIELD_IMAGE_PATH + fileName);
            byte[] imageData = Files.readAllBytes(path);
            response = ResponseEntity
                    .ok()
                    .contentType(MediaType.parseMediaType(MediaType.IMAGE_PNG_VALUE))
                    .body(imageData);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }

    public List<String> urlImages(long FieldId) {
        List<FieldImage> images = imageRepository.findByFieldId(FieldId);
        List<String> urls = new ArrayList<String>();
        if (images.size() != 0) {
            for (FieldImage image : images) {
//                  urls.add(image.getFileName());
//                  log.info(urlImage(image.getFileName()).toString());
                urls.add(urlImage(image.getFileName()).toString());
            }
            return urls;
        } else {
            return new ArrayList<>();
        }
    }

    public Object urlImage(String fileName) {
<<<<<<< HEAD
        return URL_DOWNLOAD + fileName;
//        return ServletUriComponentsBuilder
//                .fromCurrentContextPath()
//                .path(URL_DOWNLOAD)
//                .path(fileName)
//                .toUriString();
=======
        return ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path(URL_DOWNLOAD)
                .path(fileName)
                .toUriString();
>>>>>>> master
    }

    public boolean deleteImages(long fieldId) {
        boolean deleted = false;
        List<FieldImage> images = imageRepository.findByFieldId(fieldId);
        if (images.size() != 0) {
            for (FieldImage image : images) {
                try {
                    Path path = Paths.get(Config.FIELD_IMAGE_PATH + image.getFileName());
                    Files.deleteIfExists(path);
                    imageRepository.deleteById(image.getId());
                    deleted = true;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return deleted;
    }
    // << image service
}
