package com.soccerhub.api.controllers;

<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/controllers/FieldController.java
import com.example.project_api.models.tables.Field;
import com.example.project_api.services.FieldService;
=======
import com.soccerhub.api.config.Config;
import com.soccerhub.api.models.tables.Field;
import com.soccerhub.api.models.tables.FieldImage;
import com.soccerhub.api.services.FieldImageService;
import com.soccerhub.api.services.FieldService;
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/controllers/FieldController.java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/field")
public class FieldController {

    @Autowired
    private FieldService service;

//    @Autowired
//    private FieldImageService imageService;

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
<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/controllers/FieldController.java
        return service.delete(fieldId);
=======
        return fieldService.delete(fieldId);
    }

    @PostMapping("/upload-image")
    public String uploadImage(@RequestParam long fieldId, @RequestParam("file") MultipartFile file) throws IOException {
        if (imageService.uploadImage(fieldId, file)) {
            return ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path(Config.IMAGE_PATH + "/" + fieldId + "/")
                    .path(Objects.requireNonNull(file.getOriginalFilename()))
                    .toUriString();
        }
        return "Error Upload-image";
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/controllers/FieldController.java
    }

    // >> image controller
    @PostMapping("/upload-images")
    public Object uploadImage(@RequestParam("fieldId") long fieldId, @RequestParam("files") MultipartFile[] files) {
        return service.uploadImages(fieldId, files);
    }

    @GetMapping("/download-image/{fileName}")
    public Object urlImages(@PathVariable String fileName) {
        return service.downloadImage(fileName);
    }

    @GetMapping("/urlImages/{fieldId}")
    public List<?> urlImages(@PathVariable long fieldId) {
<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/controllers/FieldController.java
        return service.urlImages(fieldId);
=======
        List<FieldImage> images = imageService.findByFieldId(fieldId);
        Collections.sort(images);
        List<String> urlImages = new ArrayList<>();
        if (!images.isEmpty()) {
            for (var file : images) {
                String urlImage = ServletUriComponentsBuilder
                        .fromCurrentContextPath()
                        .path(Config.IMAGE_PATH + "/" + fieldId + "/")
                        .path(file.getFileName())
                        .toUriString();
                urlImages.add(urlImage);
            }
            return urlImages;
        }
        return null;
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/controllers/FieldController.java
    }
    // << image controller

//    @PostMapping("/upload-image")
//    public String uploadImage(@RequestParam long fieldId, @RequestParam("file") MultipartFile file) throws IOException {
//        if (imageService.uploadImage(fieldId, file)) {
//            return ServletUriComponentsBuilder
//                    .fromCurrentContextPath()
//                    .path("/field/download-image/" + fieldId + "/")
//                    .path(Objects.requireNonNull(file.getOriginalFilename()))
//                    .toUriString();
//        }
//        return "Error Upload-image";
//    }
//
//    @PostMapping("/upload-images")
//    public List<?> uploadImages(@RequestParam long fieldId, @RequestParam("files") MultipartFile[] files) throws IOException {
//        imageService.deleteImages(fieldId);
//        return Arrays.stream(files)
//                .map(file -> {
//                    try {
//                        return uploadImage(fieldId, file);
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    }
//                    return null;
//                })
//                .collect(Collectors.toList());
//    }
//
//    @GetMapping("/download-image/{fieldId}/{fileName}")
//    public ResponseEntity<?> downloadFromDB(@PathVariable long fieldId, @PathVariable String fileName) {
//        return imageService.downloadImage(fieldId, fileName);
//    }
//
//    @GetMapping("/urlImages/{fieldId}")
//    public List<?> urlImages(@PathVariable long fieldId) {
//        List<FieldImage> images = imageService.findByFieldId(fieldId);
//        Collections.sort(images);
//        List<String> urlImages = new ArrayList<>();
//        if (!images.isEmpty()) {
//            for (var file : images) {
//                String urlImage = ServletUriComponentsBuilder
//                        .fromCurrentContextPath()
//                        .path("/field/download-image/" + fieldId + "/")
//                        .path(file.getFileName())
//                        .toUriString();
//                urlImages.add(urlImage);
//            }
//            return urlImages;
//        }
//        return null;
//    }
//
}
