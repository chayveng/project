package com.example.project_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.sql.Time;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);

//        LocalDateTime myDateObj = LocalDateTime.now();
//        System.out.println("Before formatting: " + myDateObj);
//        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("HH:mm:ss");
//
//        String formattedDate = myDateObj.format(myFormatObj);
//        System.out.println("After formatting: " + formattedDate);

//        Time time2 = new Time(3600000);
//        int h = 7 * 3600000;
//        int m = 16 * 60000;
//        int s = 40 * 1000;
//        int sum = h+m+s;
//        int x2 = (17*3600000)*2;
//        Time time = new Time(x2);
//        java.sql.Time tt;

//        Time time = new Time(17*3600000);
//        time.setTime(0);
//        System.out.println(17*3600000);
//        System.out.println(time2);
//        System.out.println(time);
//
//        Time sqlTime1 = Time.valueOf("18:45:20");
//        System.out.println("SqlTime1: " + sqlTime1);
//
//        Time sqlTime2 = Time.valueOf(LocalTime.of(8, 15, 20, 1000));
//        System.out.println("SqlTime2: " + sqlTime2);

//        if(!(sqlTime1 <= sqlTime2)){
//
//        }

//        if (time < time2) {
//            System.out.println(true);
//        }
//        Time time1 = new Time();
//        time1.setId(1);
//        Time time2 = new Time();
//        time2.setId(2);
//        Time time3 = new Time();
//        time3.setId(3);
//        Time time4 = new Time();
//        time4.setId(4);
//        List<Time> lst = new ArrayList<Time>();
//        lst.add(time1);
//        lst.add(time2);
//        lst.add(time3);
//        lst.add(time4);
//        int id = 3;
//        for(Time element: lst){
//            if (element.getId() == id) {
//                System.out.println("have");
//                break;
//            }else{
//                System.out.println(element.getId());
//            }
//        }
    }

}
