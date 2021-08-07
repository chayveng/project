package com.soccerhub.api.models.tables;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "user_image")
public class UserImage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    private int userId;

    @Column
    private String fileName;

    @Column
    @Lob
    private byte[] file;
}
