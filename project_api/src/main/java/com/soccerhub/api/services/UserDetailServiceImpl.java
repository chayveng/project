package com.soccerhub.api.services;

import com.soccerhub.api.models.repository.UserRepository;
import com.soccerhub.api.models.tables.User;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userManagerRepository;


    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        Optional<User> userManager = userManagerRepository.findByUserName(
            s);
        if (userManager.isEmpty()) {
            throw new UsernameNotFoundException(s);
        }
        return new org.springframework.security.core.userdetails.User(userManager.get().getUserName(), "", getAuthority());
    }

    private List<SimpleGrantedAuthority> getAuthority() {
        return Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN"));
    }
}
