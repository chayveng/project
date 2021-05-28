package com.example.project_api.services;

import com.example.project_api.models.repository.ClubImageRepository;
import com.example.project_api.models.repository.ClubRepository;
import com.example.project_api.models.tables.ClubImage;
import com.example.project_api.models.tables.UserImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Objects;
import java.util.Optional;

@Service
public class ClubService {
    @Autowired
    ClubImageRepository clubImageRepository;

    public ClubImage imagesUpload(int clubId, MultipartFile file) throws IOException {
            ClubImage image = new ClubImage();
            image.setClubId(clubId);
            String fileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
            image.setFileName(fileName);
            image.setFile(file.getBytes());
            clubImageRepository.save(image);
            return image;
    }

    public ResponseEntity<?> imageDownload(String fileName) {
        Optional<ClubImage> clubImageData = clubImageRepository.findByFileName(fileName);
        if (clubImageData.isPresent()) {
            return ResponseEntity
                    .ok()
                    .contentType(MediaType.parseMediaType(MediaType.IMAGE_PNG_VALUE))
                    .body(clubImageData.get().getFile());
        } else {
            return ResponseEntity.status(404).build();
        }
    }
}
