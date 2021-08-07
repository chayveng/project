package com.soccerhub.api.models.tables;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "field_image")
public class FieldImage implements Comparable<FieldImage>{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column
    private long fieldId;

    @Column
    private String fileName;

    @Column
    @Lob
    private byte[] file;

    @Override
    public int compareTo(FieldImage o) {
        return this.fileName.compareTo(o.fileName);
    }

}