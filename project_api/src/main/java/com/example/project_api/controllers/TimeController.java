package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.TimeRepository;
import com.example.project_api.models.tables.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/add")
    public Object add(@RequestBody Time time) {
        Optional<Time> timeData = timeRepository.findByStartTimeAndEndTimeAndFieldId(time.getStartTime(),time.getEndTime(), time.getFieldId());
        if (timeData.isEmpty()) {
            time.setUserId(0);
            timeRepository.save(time);
            return new ApiResponse(1, "Add Time Succeed", timeRepository.findByStartTimeAndEndTime(time.getStartTime(), time.getEndTime()));
        } else {
            return new ApiResponse(0, "Time is exists", timeRepository.findByStartTimeAndEndTime(time.getStartTime(), time.getEndTime()));
        }
    }

    @GetMapping("/getByUserId/{userId}")
    public Object getByUserId(@PathVariable int userId) {
        List<Time> timeData = timeRepository.findByUserId(userId);
        if (timeData != null) {
            return new ApiResponse(1, "Time By UserId", timeData);
        } else {
            return new ApiResponse(0, "Fail", timeRepository.findByUserId(userId));
        }
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


    @GetMapping("/delete/{id}")
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
