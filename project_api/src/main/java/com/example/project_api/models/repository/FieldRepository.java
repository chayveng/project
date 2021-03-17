package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Field;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FieldRepository extends JpaRepository<Field, Integer> {

    Optional<Field> findByClubId(int clubId);
    Optional<Field> findByFieldName(String fieldName);

}
