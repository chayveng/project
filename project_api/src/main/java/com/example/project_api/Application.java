package com.example.project_api;

import com.example.project_api.models.tables.Time;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
//        Time time = new Time();
//        time.setStatus(false);
//        System.out.println(time.isStatus());
    }
}