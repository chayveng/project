package com.example.project_api.services;

import com.example.project_api.Config;

import java.io.File;

public class ImageService {

    static boolean createDirUser(String dir){
        File pathDir = new File(Config.PATH_TEST + "/" + dir);
        if (!pathDir.exists()) {
            pathDir.mkdir();
            return true;
        }else {
            return false;
        }
    }
}
