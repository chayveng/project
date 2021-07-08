package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Field;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface FieldRepository extends JpaRepository<Field, Long> {
    Optional<Field> findByTitle(String title);
    List<Field> findByUserId(long userId);
}
