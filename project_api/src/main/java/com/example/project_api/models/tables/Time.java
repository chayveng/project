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
    private long id;
    private long fieldId;
    private String startTime;
    private String endTime;

}
