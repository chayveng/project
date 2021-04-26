package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.UserRepository;
import com.example.project_api.models.tables.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;
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
        Optional<User> userData = userRepository.findByUserName(user.getUserName());
        if (userData.isEmpty()) {
            userRepository.save(user);
            return new ApiResponse(1, "Register success", userRepository.findByUserName(user.getUserName()));
        } else {
            return new ApiResponse(0, "User exists", null);
        }
    }

    @PostMapping("/login")
    public Object login(@RequestBody User user) {
        Optional<User> userData = userRepository.findByUserNameAndPassWord(user.getUserName(), user.getPassWord());
        if (userData.isPresent()) {
            return new ApiResponse(1, "Login success", userData);
        } else {
            return new ApiResponse(0, "Login fail");
        }
    }

    @PostMapping("/update")
    public Object update(@RequestBody User user) {
        Optional<User> userData = userRepository.findById(user.getId());
        if (userData.isPresent()) {
//            return "Have";
            userRepository.save(user);
            return new ApiResponse(1, "update", userRepository.findById(user.getId()));
        }else{
//            return "No";
            return new ApiResponse(0, "No User", null);
        }
    }


    @GetMapping("/autoSave")
    public Object autoSave(){
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
                }else{
                    return "Saved !";
                }
            }
        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
        return userRepository.findAll();
    }
}
