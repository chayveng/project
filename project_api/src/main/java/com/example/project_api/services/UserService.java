package com.example.project_api.services;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.UserImageRepository;
import com.example.project_api.models.repository.UserRepository;
import com.example.project_api.models.tables.User;
import com.example.project_api.models.tables.UserImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Objects;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserImageRepository userImageRepository;

    public ApiResponse register(User user) {
        Optional<User> userData = userRepository.findByUserName(user.getUserName());
        if (userData.isEmpty()) {
            userRepository.save(user);
            return new ApiResponse(1, "Register success", userRepository.findByUserName(user.getUserName()));
        } else {
            return new ApiResponse(0, "User exists", null);
        }
    }

    public ApiResponse login(User user) {
        Optional<User> userData = userRepository.findByUserNameAndPassWord(user.getUserName(), user.getPassWord());
        if (userData.isPresent()) {
            return new ApiResponse(1, "Login success", userData);
        } else {
            return new ApiResponse(0, "Login fail");
        }
    }

    public ApiResponse update(User user) {
        Optional<User> userData = userRepository.findById(user.getId());
        if (userData.isPresent()) {
            userRepository.save(user);
            return new ApiResponse(1, "update", userRepository.findById(user.getId()));
        } else {
            return new ApiResponse(0, "No User", null);
        }
    }

    public UserImage imagesUpload(int userId, MultipartFile file) throws IOException {
        Optional<UserImage> userImage = userImageRepository.findByUserId(userId);
        if (userImage.isEmpty()) {
            UserImage image = new UserImage();
            image.setUserId(userId);
            String fileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
            image.setFileName(fileName);
            image.setFile(file.getBytes());
            userImageRepository.save(image);
            return image;
        } else {
            UserImage image = userImage.get();
            image.setFile(file.getBytes());
            userImageRepository.save(image);
            return image;
        }
    }

    public ResponseEntity<?> imageDownload(String fileName) {
        Optional<UserImage> userImageData = userImageRepository.findByFileName(fileName);
        if (userImageData.isPresent()) {
            return ResponseEntity
                    .ok()
                    .contentType(MediaType.parseMediaType(MediaType.IMAGE_PNG_VALUE))
                    .body(userImageData.get().getFile());
        } else {
            return ResponseEntity.status(404).build();
        }
    }


}
