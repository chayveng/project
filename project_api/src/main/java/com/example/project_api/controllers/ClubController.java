package com.example.project_api.controllers;

import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.ClubRepository;
import com.example.project_api.models.tables.Club;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/club")
public class ClubController {

    @Autowired
    private ClubRepository clubRepository;

    @GetMapping("/index")
    public Object index() {
        return new ApiResponse(1, "Club API");
    }

    @GetMapping("/getById/{id}")
    public Object getById(@PathVariable int id) {
        return new ApiResponse(1, "Get a club by id", clubRepository.findById(id));
    }

    @GetMapping("/getByUserId/{userId}")
    public Object getByUserId(@PathVariable int userId) {
        return new ApiResponse(1, "Get a club by id", clubRepository.findByUserId(userId));
    }

    @GetMapping("/getAll")
    public Object getAll() {
        return new ApiResponse(1, "Get clubs", clubRepository.findAll());
    }

    @PostMapping("/add")
    public Object add(@RequestBody Club club) {
        Optional<Club> clubData = clubRepository.findByTitle(club.getTitle());
        if (clubData.isEmpty()) {
            clubRepository.save(club);
            return new ApiResponse(1, "Add a club an succeed", clubRepository.findByTitle(club.getTitle()));
        } else {
            return new ApiResponse(0, "Add a club fail");
        }
    }

    @PostMapping("/delete/{id}")
    public Object delete(@PathVariable int id) {
        Optional<Club> clubData = clubRepository.findById(id);
        if (clubData.isPresent()) {
            clubRepository.deleteById(id);
            return new ApiResponse(1, "Delete club succeed");
        } else {
            return new ApiResponse(0, "No club");
        }
    }

    @PostMapping("/update/{id}")
    public Object update(@PathVariable int id, @RequestBody Club club) {
        Optional<Club> clubData = clubRepository.findById(id);
        if (clubData.isPresent()) {
            Club _club = clubData.get();
            _club.setId(clubData.get().getId());
            _club.setTitle(club.getTitle());
            _club.setDetail(club.getDetail());
            _club.setMap(club.getMap());
            _club.setTel(club.getTel());
            clubRepository.save(_club);
            return new ApiResponse(1, "Update a club is succeed", _club);
        } else {
            return new ApiResponse(0, "Update fail");
        }
    }

    @GetMapping("/dummy/{num}")
    public Object dummy(@PathVariable int num) {
        for (int i = 0; i < num; i++) {
            Club _club = new Club();
            _club.setUserId(i);
            _club.setTitle("Title" + i);
            _club.setDetail("detail" + i);
            _club.setMap("map" + i);
            _club.setTel("000000000" + i);
            clubRepository.save(_club);
        }
        return new ApiResponse(1, "Dummy club: " + num, clubRepository.findAll());
    }

}
