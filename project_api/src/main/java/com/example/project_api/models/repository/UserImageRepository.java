package com.example.project_api.models.repository;

import com.example.project_api.models.tables.UserImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface UserImageRepository extends JpaRepository<UserImage, Long> {
    Optional<UserImage> findByUserId(int userId);
    Optional<UserImage> findByFileName(String fileName);
}