package com.soccerhub.api.controllers;

import com.soccerhub.api.config.Config;
import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.UserImageRepository;
import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import com.soccerhub.api.models.tables.UserImage;
import com.soccerhub.api.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.*;
import java.util.*;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userServices;

    @Autowired
    private UserImageRepository userImageRepository;

    @GetMapping("/index")
    public Object index(){
        return new ApiResponse(1, "index");
    }

    @GetMapping("/getById/{id}")
    public Object user(@PathVariable long id) {
        return new ApiResponse(1, "userById: " + id, userRepository.findById(id));
    }

    @GetMapping("/getAll")
    public Object users() {
        return new ApiResponse(1, "Users", userRepository.findAll());
    }

    @PostMapping("/register")
    public Object register(@RequestBody User user) {
        return userServices.register(user);
    }

    @PostMapping("/login")
    public Object login(@RequestBody User user) {
        return userServices.login(user);
    }

    @PostMapping("/update")
    public Object update(@RequestBody User user) {
        return userServices.update(user);
    }

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
    }

    @GetMapping("/image-download/{fileName}")
    public ResponseEntity<?> downloadFromDB(@PathVariable String fileName ) {
        return userServices.imageDownload(fileName);
    }
}
