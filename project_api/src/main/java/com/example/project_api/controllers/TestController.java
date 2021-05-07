package com.example.project_api.controllers;

import com.example.project_api.Config;
import com.example.project_api.models.beans.ApiResponse;
import org.apache.commons.io.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

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
    @ResponseBody
    @RequestMapping(value = "/getAll", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public List<byte[]> getImages() throws Exception {
        String dirLocation = (Config.PATH + Config.PATH_TEST_IMAGE + "/test/");
        List<byte[]> imgs = null;
        try {
            List<File> files = Files.list(Paths.get(dirLocation))
                    .map(Path::toFile)
                    .collect(Collectors.toList());

//            files.forEach(System.out::println);
            Object[] arr = files.toArray();
            String path = arr[1].toString();
            InputStream in = new FileInputStream(path);
            var inImg = IOUtils.toByteArray(in);
            in.close();
            System.out.println();
//            imgs.add(inImg);
//            return imgs;
            return Collections.singletonList(inImg);
        } catch (IOException e) {
            // Error while reading the directory
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
