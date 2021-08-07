package com.soccerhub.api.models.repository;

import com.soccerhub.api.models.tables.UserImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserImageRepository extends JpaRepository<UserImage, Long> {
    Optional<UserImage> findByUserId(int userId);
    Optional<UserImage> findByFileName(String fileName);
}