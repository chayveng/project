package com.soccerhub.api.models.repository;

<<<<<<< HEAD:project_api/src/main/java/com/example/project_api/models/repository/UserImageRepository.java

import com.example.project_api.models.tables.UserImage;
=======
import com.soccerhub.api.models.tables.UserImage;
>>>>>>> master:project_api/src/main/java/com/soccerhub/api/models/repository/UserImageRepository.java
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserImageRepository extends JpaRepository<UserImage, Long> {
    Optional<UserImage> findByUserId(long userId);

}