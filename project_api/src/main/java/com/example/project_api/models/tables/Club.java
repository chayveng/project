package com.example.project_api.models.tables;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "club")
public class Club {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;
    @Column(name = "user_id")
    private int userId;
    @Column(name = "club_name")
    private String clubName;
    @Column(name = "detail")
    private String detail;
    @Column(name = "map")
    private String map;
    @Column(name = "tel")
    private String tel;

}
