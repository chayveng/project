package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.TimeRepository;
import com.example.project_api.models.tables.Time;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;
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
        timeRepository.save(time);
        return new ApiResponse(1, "saved time", timeRepository.findByFieldId(time.getFieldId()));
    }



    @GetMapping("/getByUserId/{userId}")
    public Object getByUserId(@PathVariable long userId) {
        List<Time> timeData = timeRepository.findByUserId(userId);
        if (timeData != null) {
            return new ApiResponse(1, "Time By UserId", timeData);
        } else {
            return new ApiResponse(0, "Fail", timeRepository.findByUserId(userId));
        }
    }


    @GetMapping("/getByFieldId/{fieldId}")
    public Object getByFieldId(@PathVariable long fieldId) {
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

    @GetMapping("/booking/{timeId}/{userId}")
    public Object booking(@PathVariable int timeId, @PathVariable int userId){
        Optional<Time> timeData = timeRepository.findById(timeId);
        if (timeData.isPresent()) {
            Time _time = timeData.get();
            _time.setUserId(userId);
            _time.setStatus(true);
            timeRepository.save(_time);
            return new ApiResponse(1, "booked", timeRepository.findById(timeId));
        }else{
            return  new ApiResponse(0, "booking is fail");
        }
    }

    @GetMapping("/changStatus/{timeId}")
    public Object unBooking(@PathVariable int timeId){
        Optional<Time> timeData = timeRepository.findById(timeId);
        if (timeData.isPresent()) {
            Time _time = timeData.get();
            boolean _status = _time.isStatus();
            _time.setUserId(0);
            _time.setStatus(!_status);
            timeRepository.save(_time);
            return new ApiResponse(1,"Change status", timeRepository.findById(timeId));
        }else{
            return new ApiResponse(0, "Change status fail");
        }
    }

    @GetMapping("/autoSave")
    public Object autoSave(){
        JSONParser parser = new JSONParser();
        try {
            String _fileName = "/Users/chayveng/Dev/project/project_api/src/main/java/com/example/project_api/js/times.json";
            Object obj = parser.parse(new FileReader(_fileName));
            JSONArray jsonObject = (JSONArray) obj;
            JSONArray objList = jsonObject;
            Iterator<JSONObject> iterator = objList.iterator();
            while (iterator.hasNext()) {
                JSONObject _jsonObject =(JSONObject) iterator.next();
                Time time = new Time();
                time.setFieldId((Long) _jsonObject.get("fieldId"));
                time.setUserId((Long) _jsonObject.get("userId"));
                time.setStartTime((String) _jsonObject.get("startTime"));
                time.setEndTime((String) _jsonObject.get("endTime"));
                time.setStatus((boolean) _jsonObject.get("status"));
                timeRepository.save(time);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return timeRepository.findAll();
    }
}
