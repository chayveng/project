package com.soccerhub.api.services;

import com.soccerhub.api.Config;
import com.soccerhub.api.Constants;
import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.UserImageRepository;
import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import com.soccerhub.api.models.tables.UserImage;
import com.soccerhub.api.oauth2.TokenService;
import com.soccerhub.api.util.EncoderUtil;
import java.util.HashMap;
import java.util.Map;
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

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EncoderUtil encoderUtil;

    @Autowired
    private TokenService tokenService;

    public ApiResponse register(User user) {
        Optional<User> userData = repository.findByUserName(user.getUserName());
        if (userData.isEmpty()) {
            repository.save(user);
            return new ApiResponse(1, "Register success", repository.findByUserName(user.getUserName()));
        } else {
            return new ApiResponse(0, "User exists", null);
        }
    }

    public ApiResponse login2(User user) {
        Optional<User> userData = repository.findByUserNameAndPassWord(user.getUserName(), user.getPassWord());
        if (userData.isPresent()) {
            return new ApiResponse(1, "Login success", userData);
        } else {
            return new ApiResponse(0, "Login fail");
        }
    }

    public Optional<Map<String, Object>> login(LoginBean loginBean) {
        Optional<User> optUser = userRepository.findByUserName(loginBean.getUsername());
        Map<String, Object> ret = new HashMap<>();
        if (optUser.isPresent()) {
            User user = optUser.get();
            String userPassWord = user.getPassWord();

            if (encoderUtil.passwordEncoder().matches(loginBean.getPassword(), userPassWord)) {
                ret.put("data", 1);
                ret.put("token", tokenService.createToken(user));
                ret.put("userId", user.getId());
                return Optional.of(ret);
            } else {
                ret.put("data", 0);
                return Optional.of(ret);
            }
        }else {
            ret.put("data", 0);
        }
        return Optional.of(ret);
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
            res = new ApiResponse(1, "upload success", imageRepository.findByUserId(userId));
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

    public Object downloadImage(long userId ) {
        ResponseEntity<Object> response = ResponseEntity.status(404).build();
        try {
            Optional<UserImage> userImage = imageRepository.findByUserId(userId);
            String fileName = userImage.get().getFileName();
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
