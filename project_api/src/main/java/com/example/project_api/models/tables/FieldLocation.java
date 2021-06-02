package com.example.project_api.models.tables;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "field_location")
public class FieldLocation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private long fieldId;
    private String latitude;
    private String longitude;
}
