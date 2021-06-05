package com.example.project_api.models.repository;

import com.example.project_api.models.tables.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUserName(String userName);

    Optional<User>findByUserNameAndPassWord(String userName, String password);

}
