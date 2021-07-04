package com.example.project_api;

import com.example.project_api.controllers.UserController;
import com.example.project_api.models.tables.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;

public class ParseJson {
    public static void parseJsonToJavaObject() {
        JSONParser parser = new JSONParser();
        try {
            String _fileName = "/Users/chayveng/Dev/project/project_api/src/main/java/com/example/project_api/js/Users.json";
            Object obj = parser.parse(new FileReader(_fileName));
            JSONArray jsonObject = (JSONArray) obj;

            UserController userController = new UserController();
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
                userController.register(user);
            }
        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
    }
}
