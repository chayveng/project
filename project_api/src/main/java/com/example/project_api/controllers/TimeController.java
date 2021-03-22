package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.beans.ApiResponse.ApiResponseBuilder;
import com.example.project_api.models.repository.TimeRepository;
import com.example.project_api.models.tables.Time;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/time")
public class TimeController {

    @Autowired
    private TimeRepository timeRepository;

    @GetMapping("/index")
    public Object index() {
        return new ApiResponse(1, "Time API", null);
    }

    @GetMapping("/getAll")
    public Object getAll() {
        return new ApiResponse(1, "Times", timeRepository.findAll());
    }

    @GetMapping("/getByFieldId/{fieldId}")
    public Object getByFieldId(@PathVariable int fieldId) {
        List<Time> times = timeRepository.findByFieldId(fieldId);
        if (times != null) {
            return new ApiResponse(1, "Time by field id", times);
        } else {
            return new ApiResponse(0, "No times by field id", null);
        }
    }

    @PostMapping("/delete/{id}")
    public Object delete(@PathVariable int id) {
        Optional<Time> timeData = timeRepository.findById(id);
        if (timeData.isPresent()) {
            timeRepository.deleteById(id);
            return ApiResponse.builder().status(1).message("Delete time succeed").build();
        } else {
            return new ApiResponse(0, "Delete time fail");
        }
    }
}
