package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Time;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface TimeRepository extends JpaRepository<Time, Long> {
    List<Time> findByFieldId(long fieldId);

    List<Time> findByUserId(long userId);

    boolean deleteByFieldId(long fieldId);

    @Query(value = "SELECT * FROM time WHERE (endTime > :newStartTime AND startTime < :newEndTime) AND fieldId = :fieldId", nativeQuery = true)
    List<Time> findOverlapTimes(@Param("newStartTime") String startTime, @Param("newEndTime") String endTime, @Param("fieldId") long fieldId);
//    List<Time> findOverlapTime(@Param("newStartTime") String startTime, @Param("newEndTime") String endTime);
//    @Query(value = "SELECT * FROM time WHERE fieldId = 99", nativeQuery = true)
//    List<Time> findOverlapTime();

}

