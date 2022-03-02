package com.soccerhub.api.models.tables;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "time")
public class Time {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private long fieldId;
    private long userId;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    private LocalDateTime startTime;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    private LocalDateTime endTime;
    private boolean status;



    public Time(long fieldId, LocalDateTime startTime, LocalDateTime endTime) {
        this.fieldId = fieldId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

//    public static Time fromJson(Map<String, Object> time) {
//        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//        return new Time(
//                time.get("id") != null ? Long.parseLong(time.get("id").toString()) : 0,
//                time.get("fieldId") != null ? Long.parseLong(time.get("fieldId").toString()) : 0,
//                time.get("userId") != null ? Long.parseLong(time.get("userId").toString()) : 0,
//                time.get("startTime") != null ? LocalDateTime.parse(time.get("startTime").toString(), format) : null,
//                time.get("endTime") != null ? LocalDateTime.parse(time.get("endTime").toString(), format) : null
//        );
//    }
}
