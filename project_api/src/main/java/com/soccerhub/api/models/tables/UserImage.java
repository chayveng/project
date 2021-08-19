package com.soccerhub.api.models.tables;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Entity
@Table(name = "user_image")
@AllArgsConstructor
@NoArgsConstructor
public class UserImage {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private long userId;
    private String fileName;

    public UserImage(long userId, String fileName) {
        this.userId = userId;
        this.fileName = fileName;
    }

}
