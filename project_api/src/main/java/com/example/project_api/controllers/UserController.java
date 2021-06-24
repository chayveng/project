package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.UserImageRepository;
import com.example.project_api.models.repository.UserRepository;
import com.example.project_api.models.tables.User;
import com.example.project_api.models.tables.UserImage;
import com.example.project_api.services.UserService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
                .path("/user/image-download/")
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
                    .path("/user/image-download/")
                    .path(userImage.get().getFileName().toString())
                    .toUriString();
        } else {
            return ResponseEntity.status(404).build();
        }
    }


    @GetMapping("/image-download/{fileName}")
    public ResponseEntity<?> downloadFromDB(@PathVariable String fileName ) {
        return userServices.imageDownload(fileName);
    }


    @GetMapping("/autoSave")
    public Object autoSave() {
        JSONParser parser = new JSONParser();
        try {
            String _fileName = "/Users/chayveng/Dev/project/project_api/src/main/java/com/example/project_api/js/users.json";
            Object obj = parser.parse(new FileReader(_fileName));
            JSONArray jsonObject = (JSONArray) obj;
            JSONArray objList = jsonObject;
            Iterator<JSONObject> iterator = objList.iterator();
            while (iterator.hasNext()) {
                JSONObject _jsonObject = iterator.next();
                User user = new User();
                user.setUserName((String) _jsonObject.get("userName"));
                user.setPassWord((String) _jsonObject.get("passWord"));
                user.setFirstName((String) _jsonObject.get("firstName"));
                user.setLastName((String) _jsonObject.get("lastName"));
                user.setTel((String) _jsonObject.get("tel"));
                user.setEmail((String) _jsonObject.get("email"));
                System.out.println(user);
                Optional<User> userData = userRepository.findByUserName(user.getUserName());
                if (userData.isEmpty()) {
                    userRepository.save(user);
                } else {
                    return "Saved !";
                }
            }
        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
        return userRepository.findAll();
    }
}
