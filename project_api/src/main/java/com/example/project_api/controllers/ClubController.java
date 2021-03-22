package com.example.project_api.controllers;

import com.example.project_api.Config;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.ClubRepository;
import com.example.project_api.models.tables.Club;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Iterator;
import java.util.Optional;
import java.util.Random;

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
    public Object add(Club club, @RequestParam(value = "fileImage", required = false) MultipartFile fileImage) {
        ApiResponse res = new ApiResponse();
        Random random = new Random();
        try {
            if (fileImage != null) {
                char a = (char) (random.nextInt(26) + 'a');
                char b = (char) (random.nextInt(26) + 'a');
                club.setPhotosPath(String.valueOf(club.getId()) + String.valueOf(a) + String.valueOf(b) + ".png");
                File fileToSave = new File(Config.PATH_IMAGE + club.getId() + a + b + ".png");
                fileImage.transferTo(fileToSave);
                clubRepository.save(club);
                res.setStatus(1);
                res.setData("add success");
                res.setData(clubRepository.findByTitle(club.getTitle()));
            }
        } catch (Exception err) {
            res.setStatus(0);
            res.setMessage("add fail ");
        }
        return res;
    }

    @ResponseBody
    @RequestMapping(value = "/images", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getImage(@RequestParam String imageName) throws Exception {
        System.out.println(imageName);
        try {
            InputStream in = new FileInputStream(Config.PATH_IMAGE + imageName);
            var inImg = IOUtils.toByteArray(in);
            in.close();
            return inImg;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

//    @PostMapping("/add")
//    public Object add( Club club, @RequestParam(value = "value", required = false) MultipartFile fileImage) {
//        System.out.println(club);
//        Random random = new Random();
//        try {
//            Optional<Club> clubData = clubRepository.findByTitle(club.getTitle());
//            if (clubData.isEmpty()) {
//                if (fileImage != null) {
//                    char a = (char) (random.nextInt(26) + 'a');
//                    char b = (char) (random.nextInt(26) + 'a');
//
//                    club.setPhotosPath(String.valueOf(club.getId()) + String.valueOf(a) + String.valueOf(b) + ".png");
//                    File fileToSave = new File(Config.URL_IMAGE + club.getId() + a + b + ".png");
//                    fileImage.transferTo(fileToSave);
//                }
//                return new ApiResponse(1, "Add a club an succeed", clubRepository.findByTitle(club.getTitle()));
//            } else {
//                return new ApiResponse(0, "Add a club fail");
//            }
//        } catch (Exception err) {
//            return new ApiResponse(0, "Add a club fail");
//        }
//    }

    @GetMapping("/delete/{id}")
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
            _club.setAddress(club.getAddress());
            _club.setPrice(club.getPrice());
            _club.setTel(club.getTel());
            _club.setMap(club.getMap());
            clubRepository.save(_club);
            return new ApiResponse(1, "Update a club is succeed", _club);
        } else {
            return new ApiResponse(0, "Update fail");
        }
    }

    @PostMapping("/save")
    public Object save(@RequestBody Club club) {
        Optional<Club> clubData = clubRepository.findByTitle(club.getTitle());
        if (clubData.isEmpty()) {
            clubRepository.save(club);
            return clubRepository.findByTitle(club.getTitle());
        } else {
            return "Club exists";
        }
    }

    @GetMapping("/autoSave")
    public Object autoSave() {
        JSONParser parser = new JSONParser();
        try {
            String _fileName = "/Users/chayveng/Dev/project/project_api/src/main/java/com/example/project_api/js/clubs.json";
            Object obj = parser.parse(new FileReader(_fileName));
            JSONArray jsonObject = (JSONArray) obj;
            JSONArray objList = jsonObject;
            Iterator<JSONObject> iterator = objList.iterator();
            while (iterator.hasNext()) {
                JSONObject _jsonObject =(JSONObject) iterator.next();
                Club club = new Club();
                club.setUserId((Long) _jsonObject.get("userId"));
                club.setTitle((String) _jsonObject.get("title"));
                club.setDetail((String) _jsonObject.get("detail"));
                club.setAddress((String) _jsonObject.get("address"));
                club.setOpen((String) _jsonObject.get("open"));
                club.setPrice((String) _jsonObject.get("price"));
                club.setTel((String) _jsonObject.get("tel"));
                club.setMap((String) _jsonObject.get("map"));
                club.setPhotosPath((String) _jsonObject.get("photosPath"));
                Optional<Club> clubData = clubRepository.findByTitle(club.getTitle());
                if (clubData.isEmpty()) {
                    clubRepository.save(club);
                }else{
                    return "Saved";
                }
            }
        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
     return  clubRepository.findAll();
    }

}
