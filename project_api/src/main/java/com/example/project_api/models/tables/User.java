package com.example.project_api.models.tables;

import lombok.*;

import javax.persistence.*;

@Data
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;
    @Column(name = "user_name")
    private String username;
    @Column(name = "pass_word")
    private String password;

}
