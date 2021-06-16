package com.example.project_api.controllers;
import com.example.project_api.models.tables.Time;
import com.example.project_api.services.TimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/time")
public class TimeController {
    @Autowired
   private TimeService service;

    @GetMapping("/index")
    public Object index(){
        return "Hello, API TimeController";
    }

    @GetMapping("/findAll")
    public Object findAll(){
        return service.findAll();
    }

    @GetMapping("/findByFieldId/{timeId}")
    public Object findByFieldId(@RequestBody long fieldId){
        return service.findByFieldId(fieldId);
    }

    @PostMapping("/create")
    public Object create(@RequestBody Time time){
        return service.create(time);
    }

    @GetMapping("/deleteById/{timeId}")
    public Object deleteById(@PathVariable long timeId){
        return service.deleteById(timeId);
    }
}

