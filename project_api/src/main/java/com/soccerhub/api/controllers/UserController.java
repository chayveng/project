package com.soccerhub.api.controllers;

import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import com.soccerhub.api.services.UserService;
import com.soccerhub.api.util.EncoderUtil;
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

  @Autowired
  private EncoderUtil encoderUtil;

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
    user.setPassWord(encoderUtil.passwordEncoder().encode(user.getPassWord()));
    return service.register(user);
  }

//    @PostMapping("/login")
//    public Object login(@RequestBody User user) {
//        return service.login(user);
//    }

  @PostMapping("/update")
  public Object update(@RequestBody User user) {
    return service.update(user);
  }

  // >> image controller
  @PostMapping("/upload-image")
  public Object uploadImage(@RequestParam("userId") long userId,
      @RequestParam("file") MultipartFile file) {
    return service.uploadImage(userId, file);
  }

  @GetMapping("/download-image/{fileName}")
  public Object downloadImage(@PathVariable String fileName) {
    return service.downloadImage(fileName);
  }

  @GetMapping("/urlImage/{userId}")
  public Object urlImage(@PathVariable long userId) {
    return service.urlImage(userId);
  }

  @DeleteMapping("/deleteImageByUserId/{userId}")
  public Object deleteImage(@PathVariable long userId) throws IOException {
    return service.deleteImage(userId);
  }
  // << image controller
}
