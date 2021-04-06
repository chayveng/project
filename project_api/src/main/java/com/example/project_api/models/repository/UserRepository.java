package com.example.project_api.models.repository;

import com.example.project_api.models.tables.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
   Optional<User> findByUserName(String userName);
   Optional<User>findByUserNameAndPassWord(String userName, String password);
}
