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
    @Column(name = "id")
    private int id;
    @Column(name = "field_id")
    private int fieldId;
    @Column(name = "user_id")
    private int userId;
    @Column(name = "start_time")
    private java.sql.Time startTime;
    @Column(name = "end_time")
    private java.sql.Time endTime;
    @Column(name = "status")
    private boolean status;

}
