package com.soccerhub.api.services;

import com.soccerhub.api.models.beans.ApiResponse;
import com.soccerhub.api.models.repository.TimeRepository;
import com.soccerhub.api.models.tables.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class TimeService {

    @Autowired
    private TimeRepository repository;

    public ApiResponse findAll() {
        var findAll = repository.findAll();
        return new ApiResponse(1, "findAll : " + findAll.size() + " item", findAll);
    }

    public ApiResponse findByUserId(long userId) {
        List<Time> times = repository.findByUserId(userId);
        return new ApiResponse(1, "find by userId", times);
    }

    public ApiResponse findByFieldId(long fieldId) {
        List<Time> times = repository.findByFieldId(fieldId);
        return new ApiResponse(1, "Find All", times);
    }
//    public ApiResponse findByFieldId(long fieldId) {
//        List<Time> newTimes = new ArrayList<>();
//        List<Time> Times = repository.findByFieldId(fieldId);
//        Date date = new Date();
//        long time = date.getTime();
//        Timestamp current = new Timestamp(time);
//        for (var element : Times) {
//            Timestamp _startTime = Timestamp.valueOf(element.getStartTime());
//            Timestamp _endTime = Timestamp.valueOf(element.getEndTime());
//            if (_startTime.before(current) && _endTime.before(current)) {
//                repository.deleteById(element.getId());
//            } else {
//                newTimes.add(element);
//            }
//        }
//        return new ApiResponse(1, "findByFieldId : " + fieldId, newTimes);
//    }

    public ApiResponse createAccept(Time time) {
//        return new ApiResponse(1, "uuuuu", time);
        List<Time> overlapTimes = repository.findOverlapTimes(time.getStartTime().toString(), time.getEndTime().toString(), time.getFieldId());
        if (time.getStartTime().isBefore(time.getEndTime()) && overlapTimes.size() == 0) {
            return new ApiResponse(1, "create not accept time success", repository.save(time));
        } else if (time.getStartTime().isAfter(time.getEndTime())) {
            return new ApiResponse(0, "create not accept fail, start time after end time");
        } else if (time.getStartTime().equals(time.getEndTime())) {
            return new ApiResponse(0, "create not accept fail, start time equal end time");
        } else {
            return new ApiResponse(0, "create not accept fail, time is overlap " + "field_Id: " + time.getFieldId() + " overlapTime: " + overlapTimes.size());
        }

//        if (time.getStartTime().isBefore(time.getEndTime()) && overlapTimes.size() == 0) {
//            return new ApiResponse(1, "create time success", repository.save(time));
//        } else {
//            return new ApiResponse(0, "create fail, time is overlap " + overlapTimes.size() + " item", overlapTimes);
//        }
    }

    public ApiResponse createNotAccept(Time time) {
        if (time.getStartTime().isBefore(time.getEndTime())) {
            return new ApiResponse(1, "create not accept time success", repository.save(time));
        } else if (time.getStartTime().isAfter(time.getEndTime())) {
            return new ApiResponse(0, "create not accept fail, start time after end time");
        } else if (time.getStartTime().equals(time.getEndTime())) {
            return new ApiResponse(0, "create not accept fail, start time equal end time");
        } else {
            return new ApiResponse(0, "create not accept fail, time is overlap");
        }
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

    public Object update(Time time) {
        return new ApiResponse(1, "update time", repository.save(time));
    }

    public Object getOverLabTimes(Time time) {
        List<Time> timeAll = repository.findAll();
        List<Time> times = repository.findOverlapTimesAll(time.getStartTime().toString(), time.getEndTime().toString());
        List<Long> fieldsId = new ArrayList<>();
        for (int i = 0; i < times.size(); i++){
            fieldsId.add(times.get(i).getFieldId());
        }
        LinkedHashSet<Long> set = new LinkedHashSet<>();
        for (int i = 0; i < fieldsId.size(); i++){
            set.add(fieldsId.get(i));
        }
//        return new ApiResponse(1, "Over Lab Times", times.size());
        return new ApiResponse(1, "Over Lab Times", set);
    }

    public Object autoSave() {
        List<Time> times = repository.findByFieldId(99);
        for (var _time : times) {
            repository.deleteById(_time.getId());
        }
        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        for (int i = 0; i < 5; i++) {
            String start = "2020-05-05 0" + i + ":00:00";
            String end = "2020-05-05 0" + (i + 1) + ":00:00";
            Time time = new Time();
            time.setFieldId(99);
            time.setStartTime(LocalDateTime.parse(start, format));
            time.setEndTime(LocalDateTime.parse(end, format));
            repository.save(time);
        }
        repository.save(new Time(99, LocalDateTime.parse("2020-05-05 10:00:00", format), LocalDateTime.parse("2020-05-05 11:00:00", format)));
        repository.save(new Time(99, LocalDateTime.parse("2020-05-05 11:00:00", format), LocalDateTime.parse("2020-05-05 12:00:00", format)));
        return repository.findByFieldId(99);
    }
}