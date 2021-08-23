package com.soccerhub.api;

import java.util.Random;

public class Constants {

    public String randomString() {
        int length = 8;
        String CHAR = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0987654321";
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHAR.length());
            char rndChar = CHAR.charAt(index);
            sb.append(rndChar);
        }
        return sb.toString();
    }

}
