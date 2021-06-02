package com.example.project_api.controllers;

import com.example.project_api.Config;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.ClubImageRepository;
import com.example.project_api.models.repository.ClubRepository;
import com.example.project_api.models.tables.Club;
import com.example.project_api.models.tables.ClubImage;
import com.example.project_api.models.tables.UserImage;
import com.example.project_api.services.ClubService;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

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
    public Object getById(@PathVariable long id) {
        return new ApiResponse(1, "Get a club by id", clubRepository.findById(id));
    }

    @GetMapping("/getByUserId/{userId}")
    public Object getByUserId(@PathVariable long userId) {
        Optional<Club> clubData = clubRepository.findByUserId(userId);
        if (clubData.isPresent()) {
            return new ApiResponse(1, "Get By User Id", clubRepository.findById(clubData.get().getId()));
        } else {
            return new ApiResponse(0, "Fail", null);
        }
    }

    @GetMapping("/getByTitle/{title}")
    public Object getByTitle(@RequestParam String title) {
        return new ApiResponse(1, "Get By Title", clubRepository.findByTitle(title));
    }

    @GetMapping("/getAll")
    public Object getAll() {
        return new ApiResponse(1, "Get clubs", clubRepository.findAll());
    }

    @PostMapping("/create")
    public Object add(@RequestBody Club club) {
        Optional<Club> data = clubRepository.findByTitle(club.getTitle());
        if (data.isEmpty()) {
            clubRepository.save(club);
            return new ApiResponse(1, "Saved", clubRepository.findByTitle(club.getTitle()));
        } else {
            return new ApiResponse(0, "Club exists", clubRepository.findByTitle(club.getTitle()));
        }
    }

    @PostMapping("/addImage")
    public Object addImage(@RequestParam long clubId, @RequestParam(value = "fileImage", required = false) MultipartFile fileImage) {
        Random random = new Random();
        ApiResponse res = new ApiResponse();
        Optional<Club> clubData = clubRepository.findById(clubId);

        if (clubData.isPresent()) {
            try {
                Club _club = clubData.get();
                char a = (char) (random.nextInt(26) + 'a');
                char b = (char) (random.nextInt(26) + 'a');
                String photosPath = (String.valueOf(clubId) + String.valueOf(a) + String.valueOf(b) + ".png");
                File fileToSave = new File(Config.PATH_IMAGE + clubId + a + b + ".png");
                _club.setPhotosPath(photosPath);
                fileImage.transferTo(fileToSave);
                clubRepository.save(_club);
                res.setStatus(1);
                res.setMessage("add Image");
                res.setData(clubRepository.findById(clubId));
            } catch (IOException e) {
                e.printStackTrace();
                res.setStatus(0);
                res.setMessage("add Image fail");
            }
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

    @GetMapping("/delete/{id}")
    public Object delete(@PathVariable long id) {
        Optional<Club> clubData = clubRepository.findById(id);
        if (clubData.isPresent()) {
            clubRepository.deleteById(id);
            return new ApiResponse(1, "Delete club succeed");
        } else {
            return new ApiResponse(0, "No club");
        }
    }

    @PostMapping("/update")
    public Object update(@RequestBody Club club) {
        Optional<Club> clubData = clubRepository.findById(club.getId());
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
                JSONObject _jsonObject = (JSONObject) iterator.next();
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
                } else {
                    return "Saved";
                }
            }
        } catch (ParseException | IOException e) {
            e.printStackTrace();
        }
        return clubRepository.findAll();
    }


    @Autowired
    ClubService clubService;

    @Autowired
    ClubImageRepository clubImageRepository;

    @GetMapping("/urlImages/{clubId}")
    public List<String> deleteByClubId(@PathVariable int clubId) {
        var res = clubImageRepository.findByClubId(clubId);
        Collections.sort(res);
        List<String> urls = new ArrayList<>();
        for (var file : res) {
            Map<String, Object> lstMap = new HashMap<>();
            String fileDownloadUri = ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path("/club/image-download/")
                    .path(file.getFileName())
                    .toUriString();
            urls.add(fileDownloadUri);
        }
        return urls;
    }

    @PostMapping("/image-upload")
    public Map<String, Object> imageUpload(@RequestParam int clubId, @RequestParam("file") MultipartFile file) throws IOException {
        ClubImage clubImage = clubService.imagesUpload(clubId, file);
        String fileDownloadUri = ServletUriComponentsBuilder
                .fromCurrentContextPath()
                .path("/club/image-download/")
                .path(Objects.requireNonNull(file.getOriginalFilename()))
//                .path(String.valueOf(clubId))
                .toUriString();
        Map<String, Object> fileMapping = new HashMap<>();
        fileMapping.put("fileName", clubImage.getFileName());
        fileMapping.put("uri", fileDownloadUri);
        fileMapping.put("type", file.getContentType());
        fileMapping.put("size", file.getSize());
        return fileMapping;

    }

    @PostMapping("/image-uploads")
    public List<?> imageUploads(@RequestParam int clubId, @RequestParam("files") MultipartFile[] files) {
        var res = clubImageRepository.findByClubId(clubId);
        for (var file : res) clubImageRepository.deleteById(file.getId());
        return Arrays.asList(files)
                .stream()
                .map(file -> {
                    try {
                        return imageUpload(clubId, file);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    return null;
                })
                .collect(Collectors.toList());
    }

    @GetMapping("/image-download/{fileName}")
    public ResponseEntity<?> downloadFromDB(@PathVariable String fileName) {
        return clubService.imageDownload(fileName);
    }
}