package com.soccerhub.api.controllers;

import com.soccerhub.api.models.tables.Time;
import com.soccerhub.api.services.TimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/time")
public class TimeController {
    @Autowired
    private TimeService service;

    @GetMapping("/index")
    public Object index() {
        return "Hello, API TimeController";
    }

    @GetMapping("/findAll")
    public Object findAll() {
        return service.findAll();
    }

    @GetMapping("/findByFieldId/{fieldId}")
    public Object findByFieldId(@PathVariable long fieldId) {
        return service.findByFieldId(fieldId);
    }

    @GetMapping("/findByUserId/{userId}")
    public Object findByUserId(@PathVariable long userId) {
        return service.findByUserId(userId);
    }

    @PostMapping("/create")
    public Object create(@RequestBody Time timeFromJson){
        return service.create(timeFromJson);
    }

    @DeleteMapping("/deleteById/{timeId}")
    public Object deleteById(@PathVariable long timeId) {
        return service.deleteById(timeId);
    }

//    @DeleteMapping("/deleteId/{timeId}")
//    public Object deleteId(@PathVariable long timeId){
//        return  "delete time id : " + timeId;
//    }

    @GetMapping("/autoSave")
    public Object autoSave() {
        return service.autoSave();
    }
}

