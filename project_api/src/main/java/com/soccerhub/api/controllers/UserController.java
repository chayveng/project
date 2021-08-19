package com.soccerhub.api.controllers;

<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/controllers/UserController.java
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.UserImageRepository;
import com.example.project_api.models.repository.UserRepository;
import com.example.project_api.models.tables.User;
import com.example.project_api.services.UserService;
=======
import com.soccerhub.api.config.Config;
import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.UserImageRepository;
import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import com.soccerhub.api.models.tables.UserImage;
import com.soccerhub.api.services.UserService;
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/controllers/UserController.java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserRepository repository;
    @Autowired
    private UserService service;

    @GetMapping("/index")
    public Object index() {
        return new ApiResponse(1, "index");
    }

    @GetMapping("/getById/{id}")
    public Object user(@PathVariable long id) {
        return new ApiResponse(1, "userById: " + id, repository.findById(id));
    }

    @GetMapping("/getAll")
    public Object users() {
        return new ApiResponse(1, "Users", repository.findAll());
    }

    @PostMapping("/register")
    public Object register(@RequestBody User user) {
        return service.register(user);
    }

    @PostMapping("/login")
    public Object login(@RequestBody User user) {
        return service.login(user);
    }

    @PostMapping("/update")
    public Object update(@RequestBody User user) {
        return service.update(user);
    }

    // >> image controller
    @PostMapping("/upload-image")
    public Object uploadImage(@RequestParam("userId") long userId, @RequestParam("file") MultipartFile file) {
        return service.uploadImage(userId, file);
    }

<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/controllers/UserController.java
    @GetMapping("/download-image/{fileName}")
    public Object downloadImage(@PathVariable String fileName) {
        return service.downloadImage(fileName);
    }

    @GetMapping("/urlImage/{userId}")
    public Object urlImage(@PathVariable long userId) {
        return service.urlImage(userId);
=======
    @PostMapping("/image-upload")
    public ResponseEntity<?> store(@RequestParam int userId, @RequestParam("file") MultipartFile file) throws IOException {
        UserImage userImage = userServices.imagesUpload(userId, file);
        String fileDownloadUri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path(Config.IMAGE_PATH)
                .path(userImage.getFileName())
                .toUriString();
        return ResponseEntity.ok(fileDownloadUri);
    }

    @GetMapping("/urlImage/{userId}")
    public Object urlImage(@PathVariable int userId) {
        Optional<UserImage> userImage = userImageRepository.findByUserId(userId);
        if (userImage.isPresent()) {
            return ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path(Config.IMAGE_PATH)
                    .path(userImage.get().getFileName().toString())
//                    .path(userImage.get().getFileName().toString())
                    .toUriString();
        } else {
            return ResponseEntity.status(404).build();
        }
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/controllers/UserController.java
    }

    @DeleteMapping("/deleteImageByUserId/{userId}")
    public Object deleteImage(@PathVariable long userId) throws IOException {
        return service.deleteImage(userId);
    }
    // << image controller
}
