package com.soccerhub.api.models.tables;

import java.util.List;
import lombok.*;

import javax.persistence.*;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

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
