package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Time;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TimeRepository extends JpaRepository<Time, Integer> {
    List<Time> findByFieldId(int fieldId);
    Optional<Time> findByStartTime(java.sql.Time startTime);
//    Optional<Time> findByFieldIdAndTime(int fieldId, java.sql.Time startTime, java.sql.Time endTim);


}

