package com.example.project_api.services;

import com.example.project_api.Config;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.repository.ClubRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@Service
public class MyService {

    static final String PATH_TEST = "/Users/chayveng/Dev/project/test/";

    @Autowired
    private ClubRepository clubRepository;

    public Object getIndex() {
        return "index";
    }

    public Object addImageClub(int userId, int clubId, MultipartFile[] fileImages) {
        try {
            String path = new String(Config.PATH_TEST + "/" + userId + "/" + clubId);
            if (!FileService.createDir(path)) {
                FileService.deleteDir(path);
                FileService.createDir(path);
            }
            for (int i = 0; i < fileImages.length ; i++) {
                String _path = (path + "/" + i + ".png");
                fileImages[i].transferTo(Paths.get(_path));
            }
            return new ApiResponse(1, "saved", null);
        } catch (IOException e) {
            e.printStackTrace();
            return new ApiResponse(0, "can't save", null);
        }
    }

}
