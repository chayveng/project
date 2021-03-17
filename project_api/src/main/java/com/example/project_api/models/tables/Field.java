package com.example.project_api.models.tables;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "field")
public class Field {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;
    @Column(name = "club_id")
    private int clubId;
    @Column(name = "field_name")
    private String fieldName;
    @Column(name = "detail")
    private String detail;
    @Column(name = "status")
    private boolean status;

}
