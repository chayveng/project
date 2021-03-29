package com.example.project_api.models.tables;

import lombok.*;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "time")
public class Time {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int fieldId;
    private int userId;
    private String startTime;
    private String endTime;
    private boolean status;

}
