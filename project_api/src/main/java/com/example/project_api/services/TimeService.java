package com.example.project_api.services;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.TimeRepository;
import com.example.project_api.models.tables.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class TimeService {

    @Autowired
    private TimeRepository repository;

    public ApiResponse findAll() {
        return new ApiResponse(1, "findAll", repository.findAll());
    }

    public ApiResponse findByUserId(long userId){
        List<Time> times = repository.findByUserId(userId);
        return new ApiResponse(1, "find by userId", times);
    }

    public ApiResponse findByFieldId(long fieldId) {
        List<Time> newTimes = new ArrayList<>();
        List<Time> Times = repository.findByFieldId(fieldId);
        Date date = new Date();
        long time = date.getTime();
        Timestamp current = new Timestamp(time);
        for (var element : Times) {
            Timestamp _startTime = Timestamp.valueOf(element.getStartTime());
            Timestamp _endTime = Timestamp.valueOf(element.getEndTime());
            if (_startTime.before(current) && _endTime.before(current)) {
                repository.deleteById(element.getId());
            } else {
                newTimes.add(element);
            }
        }
        return new ApiResponse(1, "findByFieldId", newTimes);
    }

    public ApiResponse testFindByFieldId(long fieldId, String currentTime) {
        List<Time> newTimes = new ArrayList<>();
        List<Time> Times = repository.findByFieldId(fieldId);
//        Date date = new Date();
//        long time = date.getTime();
//        Timestamp current = new Timestamp(time);
        Timestamp current = Timestamp.valueOf(currentTime);
        for (var element : Times) {
            Timestamp _startTime = Timestamp.valueOf(element.getStartTime());
            Timestamp _endTime = Timestamp.valueOf(element.getEndTime());
            if (_startTime.before(current) && _endTime.before(current)) {
                System.out.println("No");
//                repository.deleteById(element.getId());
            } else {
                newTimes.add(element);
            }
        }
        return new ApiResponse(1, "findByFieldId", newTimes);
    }

    public ApiResponse create(Time time) {
        return new ApiResponse(1, "created", repository.save(time));
    }

    public Object deleteById(long timeId) {
        Optional<Time> timeData = repository.findById(timeId);
        if (timeData.isPresent()) {
            repository.deleteById(timeId);
            return new ApiResponse(1, "delete by id: " + timeId);
        } else {
            return new ApiResponse(0, "no time at id: " + timeId);
        }
    }

    public Object autoSave() {
        List<Time> times = repository.findByFieldId(99);
        for (var _time : times) {
            repository.deleteById(_time.getId());
        }
        for (int i = 0; i < 10; i++) {
            Time time = new Time();
            time.setFieldId(99);
            time.setStartTime("2020-05-05 0" + i + ":00:00");
            time.setEndTime("2020-05-05 0" + String.valueOf(i+1) + ":00:00");
            repository.save(time);
        }
        return repository.findByFieldId(99);
    }
}