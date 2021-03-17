package com.example.project_api.controllers;

import com.example.project_api.models.tables.User;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/index")
    public Object getIndex() {
        return new ApiResponse(1, "Index", "Index");
    }

    @GetMapping("/getById/{id}")
    public Object user(@PathVariable int id) {
        return new ApiResponse(1, "userById: " + id, userRepository.findById(id));
    }

    @GetMapping("/getAll")
    public Object users() {
        return new ApiResponse(1, "Users", userRepository.findAll());
    }

    @PostMapping("/register")
    public Object register(@RequestBody User user) {
        Optional<User> userData = userRepository.findByUsername(user.getUsername());
        if (userData.isEmpty()) {
            userRepository.save(user);
            return new ApiResponse(1, "Register success", userRepository.findByUsername(user.getUsername()));
        } else {
            return new ApiResponse(0, "User exists", userRepository.findByUsername(user.getUsername()));
        }
    }

    @PostMapping("/login")
    public Object login(@RequestBody User user) {
        Optional<User> userData = userRepository.findByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (userData.isPresent()) {
            return new ApiResponse(1, "Login success", userData);
        } else {
            return new ApiResponse(0, "Login fail");
        }
    }
}
