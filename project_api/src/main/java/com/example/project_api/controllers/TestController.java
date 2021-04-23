package com.example.project_api.controllers;

import com.example.project_api.Config;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.tables.Club;
import org.apache.commons.io.IOUtils;
import org.springframework.boot.system.ApplicationPid;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Random;

@RestController
@RequestMapping("/testImage")
public class TestController {

    @PostMapping("/addUserImage")
    public Object addUserImage(@RequestParam int userId, @RequestParam(value = "fileImage", required = false) MultipartFile fileImage) {
        ApiResponse response = new ApiResponse();
        try {
            String path = (Config.PATH + Config.PATH_TEST_IMAGE + "/user/");
            File fileToSave = new File(path + userId + ".png");
            fileImage.transferTo(fileToSave);
            response.setMessage("add imaged");
        } catch (IOException e) {
            e.printStackTrace();
            response.setMessage("add image fail");
        }
        return response;
    }

    @ResponseBody
    @RequestMapping(value = "/getUserImage", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getImage(@RequestParam String imageName) throws Exception {
        System.out.println(imageName);
        try {
            String path = (Config.PATH + Config.PATH_TEST_IMAGE + "/user/");
            InputStream in = new FileInputStream(path + imageName);
            var inImg = IOUtils.toByteArray(in);
            in.close();
            return inImg;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @ResponseBody
    @RequestMapping(value = "/getUserImages", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getImages(@RequestParam String imageName) throws Exception {
        try {
            String path = (Config.PATH + Config.PATH_TEST_IMAGE + "/test/");
            InputStream in = new FileInputStream(path + imageName);
            var inImg = IOUtils.toByteArray(in);
            in.close();
            return inImg;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }



//    @PostMapping("/addClubImage")
//    public Object addClubImage(@RequestParam int userId, @RequestParam(value = "fileImage", required = false) MultipartFile fileImage) {
//        ApiResponse response = new ApiResponse();
//        try {
//            String path = (Config.PATH + Config.PATH_TEST_IMAGE + "/club/");
//            File fileToSave = new File(path + userId + ".png");
//            fileImage.transferTo(fileToSave);
//            response.setMessage("add imaged");
//        } catch (IOException e) {
//            e.printStackTrace();
//            response.setMessage("add image fail");
//        }
//        return response;
//    }

//    @GetMapping("/createFolder")
//    public Object createFolder() throws IOException {
//        String res;
//        String PATH_DIR = "/Users/chayveng/Dev/project/testImage";
//        String dir = "/a";
//        try {
//            Path path = Paths.get(PATH_DIR + dir);
//            Files.createDirectory(path);
//            res = "create folder";
//
//        } catch (IOException e) {
//            e.printStackTrace();
//            res = "create fail";
//        }
//        return res;
//        File index = new File("/Users/chayveng/Dev/project/testImage/a");
//        Files.walk(Path.of("/Users/chayveng/Dev/project/testImage/a"))
//                .sorted(Comparator.reverseOrder())
//                .map(Path::toFile)
//                .map(File::delete)
//                .close();
//        File file = new File("/Users/chayveng/Dev/project/testImage/a");
//        return res = "delete";
//    }

}
