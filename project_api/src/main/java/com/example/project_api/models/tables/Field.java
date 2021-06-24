package com.example.project_api.models.tables;

import lombok.Data;

import javax.persistence.*;


@Data
@Entity
@Table(name = "field")
public class Field {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column
    private long id;
    private long userId;
    private String title;
    private String detail;
    private String address;
    private String tel;
    private String hours;
    private String price;
    private String location;

}
