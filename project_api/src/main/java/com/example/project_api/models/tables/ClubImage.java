package com.example.project_api.models.tables;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "club_image")
public class ClubImage implements Comparable<ClubImage>{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    private int clubId;

    @Column
    private String fileName;

    @Column
    @Lob
    private byte[] file;


    @Override
    public int compareTo(ClubImage o) {
        return this.fileName.compareTo(o.fileName);
    }
}
