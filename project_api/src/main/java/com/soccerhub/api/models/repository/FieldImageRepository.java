package com.soccerhub.api.models.repository;

import com.soccerhub.api.models.tables.FieldImage;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface FieldImageRepository extends CrudRepository<FieldImage, Long> {
    Optional<FieldImage> findByFileName(String fileName);
    Optional<FieldImage> findByFieldIdAndFileName(long fieldId, String fileName);
    List<FieldImage> findByFieldId(long filedId);
}
