package com.vtoroe.vtoroe.service;

import com.vtoroe.vtoroe.domain.Rol;
import com.vtoroe.vtoroe.domain.User;
import com.vtoroe.vtoroe.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException{
        return userRepo.findByUsername(username);
    }
    public boolean addUser(User user){
        User userFromDb=userRepo.findByUsername(user.getUsername());

        if (userFromDb!=null){
            return false;
        }
        user.setActive(false);
        user.setRoles(Collections.singleton(Rol.ADMIN));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setDateReg(new Date());
        user.setDateLastSeen(new Date());
        user.setTheme("WithoutTheme");
        user.setLanguage("English");
        userRepo.save(user);
        sendMessage(user);
        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())){
            String message=String.format(
              "Hello, %s! \n"+
                      "Welcome to RecipeBook. Please,visit next link: http://localhost:8080/activate/%s \n" +
                      "                                                                                                                                                        Regards, K. Shprints",

                    user.getUsername(),
                    user.getActivationCode()
            );
             mailSender.send(user.getEmail(), "Activation code",message);
        }
    }

    public boolean activateUser(String code) {
        User user=userRepo.findByActivationCode(code);

        if (user==null){
            return false;
        }
        user.setActivationCode(null);
        user.setActive(true);
        userRepo.save(user);
        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Rol.values())
                .map(Rol::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Rol.valueOf(key));
            }
        }
        userRepo.save(user);
    }



    public void updateProfile(User user, String password, String email, String theme, String language) {
    String userEmail=user.getEmail();
        boolean isEmailChanged =(email != null && !email.equals(userEmail)) || (userEmail !=null && !userEmail.equals(email));
        if (isEmailChanged){
            user.setEmail(email);
            if (!StringUtils.isEmpty(email)){
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }
        if (!StringUtils.isEmpty(password)){
            user.setPassword(password);
        }
        user.setTheme(theme);
        user.setLanguage(language);
        userRepo.save(user);
        if(isEmailChanged) {
            sendMessage(user);
        }
    }
}