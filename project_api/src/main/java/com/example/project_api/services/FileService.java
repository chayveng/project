package com.example.project_api.services;

import com.example.project_api.Config;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;

public class FileService {

    public static boolean clearDir(String path){
        if (!FileService.createDir(path)) {
            FileService.deleteDir(path);
            FileService.createDir(path);
        }
        return true;
    }

    public static boolean createDir(String path) {
        String pathDir = new String(path);
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
            return true;
        } else {
            return false;
        }
    }

    public static boolean deleteDir(String path) {
        Path pathDir = Paths.get(path);
        try {
            Files.walk(pathDir)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    static void createDirectory(String pathToBeCreate) {
        Path path = Paths.get(Config.PATH + pathToBeCreate);
        try {
            Files.createDirectory(path);
            System.out.println("Create directory");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Create fail");
        }
    }

    static void deleteDirectory(String pathToBeDelete) {
        Path pathToBeDeleted = Paths.get(Config.PATH + pathToBeDelete);
        try {
            Files.walk(pathToBeDeleted)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
            Files.exists(pathToBeDeleted);
            System.out.println("Delete directory");

        } catch (IOException e) {
            e.printStackTrace();
            Files.exists(pathToBeDeleted);
            System.out.println("Directory still exists");
        }
    }

    static void addFile(String pathToBeAdd) {
        Path pathToBeDeleted = Paths.get(Config.PATH + pathToBeAdd);

    }

    static void deleteFile(String pathToBeDelete) {
        Path pathToBeDeleted = Paths.get(Config.PATH + pathToBeDelete);
    }

}
