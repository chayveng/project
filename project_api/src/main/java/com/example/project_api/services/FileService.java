package com.example.project_api.services;

import com.example.project_api.Config;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;

public class FileService {

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
