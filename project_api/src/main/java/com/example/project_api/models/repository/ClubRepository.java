package com.example.project_api.models.repository;

import com.example.project_api.models.tables.Club;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ClubRepository extends JpaRepository<Club, Integer> {
    Optional<Club> findByTitle(String title);
    Optional<Club> findByUserId(int userId);
}
