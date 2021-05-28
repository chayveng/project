package com.example.project_api.models.tables;


import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "document")
public class Document {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    private String docName;

    @Column
    @Lob
    private byte[] file;

}
