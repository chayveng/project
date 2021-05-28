package com.example.project_api.controllers;

import com.example.project_api.Config;
import com.example.project_api.models.beans.ApiResponse;
import com.example.project_api.models.tables.Document;
import com.example.project_api.services.FileService;
import com.example.project_api.services.MyService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StreamUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.nio.file.*;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController
@RequestMapping("/my")
public class MyController {

    @Autowired
    MyService myService;

    @GetMapping("/index")
    public Object index() {
        return myService.getIndex();
    }


    @GetMapping("/getFilesName/{userId}/{clubId}")
    public Object getFilesName(@PathVariable int userId, @PathVariable int clubId) {
        String dir = "/Users/chayveng/Desktop/test" + "/" + 55 + "/" + 11 + "/";
        Set<String> fileList = new HashSet<>();
        try (DirectoryStream<Path> stream = Files.newDirectoryStream(Paths.get(dir))) {
            for (Path path : stream) {
                if (!Files.isDirectory(path)) {
                    fileList.add(path.getFileName().toString());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        ApiResponse res = new ApiResponse(1, "filesName", new ArrayList<String>(fileList));
        return res;
    }


    @GetMapping(value = "/zip-download", produces = "application/zip")
    public void zipDownload(@RequestParam List<String> name, HttpServletResponse response) throws IOException {
        String fileBasePath = "/Users/chayveng/Desktop/test" + "/" + 55 + "/" + 11 + "/";
        ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream());
        for (String fileName : name) {
            FileSystemResource resource = new FileSystemResource(fileBasePath + fileName);
            ZipEntry zipEntry = new ZipEntry(resource.getFilename());
            zipEntry.setSize(resource.contentLength());
            zipOut.putNextEntry(zipEntry);
            StreamUtils.copy(resource.getInputStream(), zipOut);
            zipOut.closeEntry();
        }
        zipOut.finish();
        zipOut.close();
        response.setStatus(HttpServletResponse.SC_OK);
        response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + "zipFileName" + "\"");
    }

    @PostMapping("/addImageClub")
    public Object addImageClub(
            @RequestParam int userId,
            @RequestParam int clubId,
            @RequestParam MultipartFile[] fileImages
    ) {
        return myService.addImageClub(userId, clubId, fileImages);
    }

    @PostMapping("/upload")
    public ResponseEntity upload(@RequestParam int userId, @RequestParam int clubId, @RequestParam("file") MultipartFile file) {
        String path = "/Users/chayveng/Desktop/test" + "/" + userId + "/" + clubId + "/";
        FileService.clearDir(path);
        return _uploadToLocalFileSystem(path, file);
    }

    @PostMapping("/uploads")
    public ResponseEntity uploads(@RequestParam int userId, @RequestParam int clubId, @RequestParam("files") MultipartFile[] files) {
        String path = new String(Config.PATH_TEST + "/" + userId + "/" + clubId + "/");
        FileService.clearDir(path);
        List<Object> fileDownloadUrls = new ArrayList<>();
        Arrays.asList(files)
                .stream()
                .forEach(file -> fileDownloadUrls.add(_uploadToLocalFileSystem(path, file).getBody()));
        return ResponseEntity.ok(fileDownloadUrls);
    }

    public ResponseEntity _uploadToLocalFileSystem(String setPath, MultipartFile file) {
        String fileBasePath = setPath;
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        Path path = Paths.get(fileBasePath + fileName);
        try {
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/files/download/")
                .path(fileName)
                .toUriString();
        return ResponseEntity.ok(fileDownloadUri);
    }

    @ResponseBody
    @RequestMapping(value = "/images/{userId}/{clubId}/{num}", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
    public byte[] getImage(@PathVariable int userId, @PathVariable int clubId, @PathVariable int num) {
        String path = new String(Config.PATH_TEST + "/" + userId + "/" + clubId + "/" + num + ".png");
        File file = new File(path);
        if (file.exists()) {
            try {
                InputStream inputStream = new FileInputStream(path);
                byte[] inImg = IOUtils.toByteArray(inputStream);
                inputStream.close();
                return inImg;
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        } else {
            return null;
        }
    }

    //    ************************************************************
    /*Single File Upload to Local File System in Spring Boot Rest*/
    @PostMapping("/_upload")
    public ResponseEntity uploadToLocalFileSystem(@RequestParam int userId, @RequestParam int clubId, @RequestParam("file") MultipartFile file) {
        String fileBasePath = "/Users/chayveng/Desktop/test" + "/" + userId + "/" + clubId + "/";
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        Path path = Paths.get(fileBasePath + fileName);
        try {
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/files/download/")
                .path(fileName)
                .toUriString();
        return ResponseEntity.ok(fileDownloadUri);
    }

    /*Multiple File Uploads to Local File System in Spring Boot Rest*/
    @PostMapping("/multi-upload")
    public ResponseEntity multiUpload(@RequestParam int userId, @RequestParam int clubId, @RequestParam("files") MultipartFile[] files) {
        String path = new String(Config.PATH_TEST + "/" + userId + "/" + clubId);
        if (!FileService.createDir(path)) {
            FileService.deleteDir(path);
            FileService.createDir(path);
        }
        List<Object> fileDownloadUrls = new ArrayList<>();
        Arrays.asList(files)
                .stream()
                .forEach(file -> fileDownloadUrls.add(uploadToLocalFileSystem(userId, clubId, file).getBody()));
        return ResponseEntity.ok(fileDownloadUrls);
    }

    /* upload file to database */

    @PostMapping("/upload/db")
    public ResponseEntity uploadToDB(@RequestParam("file") MultipartFile file) {
        Document doc = new Document();
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        doc.setDocName(fileName);
        try {
            doc.setFile(file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
//        documentDao.save(doc);
        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/files/download/")
                .path(fileName).path("/db")
                .toUriString();
        return ResponseEntity.ok(fileDownloadUri);
    }

    /* multi-upload file to database */

    @PostMapping("/multi-upload/db")
    public ResponseEntity multiUploadToDB(@RequestParam("file") MultipartFile[] file) {
        Document doc = new Document();
        String fileName = StringUtils.cleanPath(file[0].getOriginalFilename());
        doc.setDocName(fileName);
        try {
            doc.setFile(file[0].getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
//        documentDao.save(doc);
        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/files/download/")
                .path(fileName).path("/db")
                .toUriString();
        return ResponseEntity.ok(fileDownloadUri);
    }

    /*File Download in Spring Boot*/
    /*Spring Boot File Download from Local File System*/
    @GetMapping("/download/{userId}/{clubId}/{fileName}")
    public ResponseEntity downloadFileFromLocal(@PathVariable int userId, @PathVariable int clubId, @PathVariable String fileName) {
        String fileBasePath = "/Users/chayveng/Desktop/test/" + userId +"/" + clubId + "/";
        Path path = Paths.get(fileBasePath + fileName);
        Resource resource = null;
        try {
            resource = new UrlResource(path.toUri());
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(MediaType.IMAGE_PNG_VALUE))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                .body(resource);
    }

//      **************************************************************

//    public Object addImage(@RequestParam int clubId,@RequestParam(value = "fileImage", required = false) MultipartFile fileImage){
//        Random random = new Random();
//        ApiResponse res = new ApiResponse();
//        Optional<Club> clubData = clubRepository.findById(clubId);
//
//        if (clubData.isPresent()) {
//            try{
//                Club _club = clubData.get();
//                char a = (char) (random.nextInt(26) + 'a');
//                char b = (char) (random.nextInt(26) + 'a');
//                String photosPath = (String.valueOf(clubId) + String.valueOf(a) + String.valueOf(b) + ".png");
//                File fileToSave = new File(Config.PATH_IMAGE + clubId + a + b + ".png");
//                _club.setPhotosPath(photosPath);
//                fileImage.transferTo(fileToSave);
//                clubRepository.save(_club);
//                res.setStatus(1);
//                res.setMessage("add Image");
//                res.setData(clubRepository.findById(clubId));
//            } catch (IOException e) {
//                e.printStackTrace();
//                res.setStatus(0);
//                res.setMessage("add Image fail");
//            }
//        }
//        return res;
//    }

//    @ResponseBody
//    @RequestMapping(value = "/images", method = RequestMethod.GET, produces = MediaType.IMAGE_PNG_VALUE)
//    public byte[] getImage(@RequestParam String imageName) throws Exception {
//        System.out.println(imageName);
//        try {
//            InputStream in = new FileInputStream(Config.PATH_IMAGE + imageName);
//            var inImg = IOUtils.toByteArray(in);
//            in.close();
//            return inImg;
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }

}
