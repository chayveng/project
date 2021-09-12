package com.soccerhub.api.util;

import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class ContextUtil {

    @Autowired
    private UserRepository userRepository;

    public Optional<User> getUserDataFromContext() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<User> optUserData = userRepository.findByUserName(user.getUserName());
        if(optUserData == null){
            return Optional.empty();
        } else {
            return optUserData;
        }
    }

}
