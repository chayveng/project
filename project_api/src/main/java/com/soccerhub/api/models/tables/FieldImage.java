package com.soccerhub.api.models.tables;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@Table(name = "field_image")
@NoArgsConstructor
@AllArgsConstructor
public class FieldImage {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private long fieldId;
    private String fileName;

    public FieldImage(long fieldId, String fileName) {
        this.fieldId = fieldId;
        this.fileName = fileName;
    }
}
