package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Time;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TimeRepository extends JpaRepository<Time, Long> {
    List<Time> findByFieldId(long fieldId);

}

