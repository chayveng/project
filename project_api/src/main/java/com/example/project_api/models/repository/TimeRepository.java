package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Time;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TimeRepository extends JpaRepository<Time, Integer> {
    List<Time> findByFieldId(long fieldId);
    List<Time> findByUserId(long userId);
//    Optional<Time> findByStartTime(String startTime);
//    Optional<Time> findByStartTimeAndEndTime(String startTime, String endTime);
//    Optional<Time> findByStartTimeAndEndTimeAndFieldId(String startTime, String endTime,int fieldId);

}

