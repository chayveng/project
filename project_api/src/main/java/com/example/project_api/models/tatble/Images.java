package com.example.project_api.models.tatble;

import lombok.Data;

import javax.persistence.*;
import java.io.File;

@Data
@Entity
@Table(name = "images")
public class Images {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String name;
    @Lob
    private byte[] file;
}
