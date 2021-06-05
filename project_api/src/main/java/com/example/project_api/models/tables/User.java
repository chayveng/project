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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String userName;
    private String passWord;
    private String firstName;
    private String lastName;
    private String tel;
    private String email;

    @Lob
    private byte[] image;

}
