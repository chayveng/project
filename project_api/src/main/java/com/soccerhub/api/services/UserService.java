package com.soccerhub.api.services;

<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/services/UserService.java
import com.example.project_api.Config;
import com.example.project_api.Constants;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.UserImageRepository;
import com.example.project_api.models.repository.UserRepository;
import com.example.project_api.models.tables.User;
import com.example.project_api.models.tables.UserImage;
=======
import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.UserImageRepository;
import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import com.soccerhub.api.models.tables.UserImage;
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/services/UserService.java
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
import java.util.Optional;

@Service
public class UserService {
    final static String URL_DOWNLOAD ="/user/download-image/";

    @Autowired
    UserRepository repository;

    @Autowired
    UserImageRepository imageRepository;

    public ApiResponse register(User user) {
        Optional<User> userData = repository.findByUserName(user.getUserName());
        if (userData.isEmpty()) {
            repository.save(user);
            return new ApiResponse(1, "Register success", repository.findByUserName(user.getUserName()));
        } else {
            return new ApiResponse(0, "User exists", null);
        }
    }

    public ApiResponse login(User user) {
        Optional<User> userData = repository.findByUserNameAndPassWord(user.getUserName(), user.getPassWord());
        if (userData.isPresent()) {
            return new ApiResponse(1, "Login success", userData);
        } else {
            return new ApiResponse(0, "Login fail");
        }
    }

    public ApiResponse update(User user) {
        Optional<User> userData = repository.findById(user.getId());
        if (userData.isPresent()) {
            repository.save(user);
            return new ApiResponse(1, "update", repository.findById(user.getId()));
        } else {
            return new ApiResponse(0, "No User", null);
        }
    }

    // >> images service
    public Object uploadImage(long userId, MultipartFile file) {
        ApiResponse res = new ApiResponse(0, "upload fail", null);
        if (!file.isEmpty()) {
            boolean deletes = deleteImage(userId);
            upload(userId, file);
            res = new ApiResponse(1, urlImage(userId).toString(), imageRepository.findByUserId(userId));
        }
        return res;
    }

    public void upload(long userId, MultipartFile file){
        Constants constants = new Constants();
        try {
            byte[] bytes = file.getBytes();
            String fileName = constants.randomString() + userId + ".png";
            Path path = Paths.get(Config.USER_IMAGE_PATH + fileName);
            Files.write(path, bytes);
            UserImage imageSaved = imageRepository.save(new UserImage(userId, fileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Object downloadImage(String fileName) {
        ResponseEntity<Object> response = ResponseEntity.status(404).build();
        try {
            Path path = Paths.get(Config.USER_IMAGE_PATH + fileName);
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

    public Object urlImage(long userId) {
        Optional<UserImage> image = imageRepository.findByUserId(userId);
        if (image.isPresent()) {
            return ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path(URL_DOWNLOAD)
                    .path(image.get().getFileName().toString())
                    .toUriString();
        } else {
            return ResponseEntity.status(404).build();
        }
    }

    public boolean deleteImage(long userId) {
        boolean deleted = false;
        Optional<UserImage> image = imageRepository.findByUserId(userId);
        if (image.isPresent()) {
            try {
                Path path = Paths.get(Config.USER_IMAGE_PATH + image.get().getFileName());
                Files.deleteIfExists(path);
                imageRepository.deleteById(image.get().getId());
                deleted = true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return deleted;
    }
    // << image service
}
