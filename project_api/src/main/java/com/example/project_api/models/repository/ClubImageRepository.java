package com.example.project_api.models.repository;


import com.example.project_api.models.tables.ClubImage;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface ClubImageRepository extends CrudRepository<ClubImage, Long> {
    Optional<ClubImage> findByFileName(String fileName);
//    Optional<ClubImage> findByCluIdAndFileName(int clubId,String fileName);
    List<ClubImage> findByClubId(int clubId);

}
