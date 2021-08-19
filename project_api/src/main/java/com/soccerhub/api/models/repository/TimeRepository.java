package com.soccerhub.api.models.repository;

import com.soccerhub.api.models.tables.Time;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TimeRepository extends JpaRepository<Time, Long> {
    List<Time> findByUserId(long userId);

    boolean deleteByUserId(long fieldId);

    @Query(value = "SELECT * FROM time WHERE fieldId=:fieldId ORDER BY startTime DESC ", nativeQuery = true)
    List<Time> findByFieldId(@Param("fieldId") long fieldId);

    @Query(value = "SELECT * FROM time WHERE (endTime > :newStartTime AND startTime < :newEndTime) AND fieldId = :fieldId", nativeQuery = true)
    List<Time> findOverlapTimes(@Param("newStartTime") String startTime, @Param("newEndTime") String endTime, @Param("fieldId") long fieldId);

}