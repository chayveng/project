package com.soccerhub.api;

public class Config {
    public static final String MAIN_PATH = System.getenv("soccerhub_image_path");
    public static final String USER_IMAGE_PATH = MAIN_PATH +"/user-images/";
    public static final String FIELD_IMAGE_PATH =  MAIN_PATH +"/field-images/";
}
