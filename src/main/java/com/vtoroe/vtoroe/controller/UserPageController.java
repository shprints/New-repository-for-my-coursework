package com.vtoroe.vtoroe.controller;
import com.vtoroe.vtoroe.domain.Comment;
import com.vtoroe.vtoroe.domain.Rating;
import com.vtoroe.vtoroe.domain.User;
import com.vtoroe.vtoroe.repos.CommentRepo;
import com.vtoroe.vtoroe.repos.RatingRepo;
import com.vtoroe.vtoroe.repos.SummRepo;
import com.vtoroe.vtoroe.domain.Summ;
import com.vtoroe.vtoroe.repos.UserRepo;
import com.vtoroe.vtoroe.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
public class UserPageController {
    @Autowired
    private SummRepo summRepo;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private CommentRepo commentRepo;

    @Autowired
    private UserService userService;

    @Autowired
    private RatingRepo ratingRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/Recipes")
    public String UserPage(Summ summ, Model model, Comment comment, Rating rating) {
        List<Summ> summs=summRepo.findAll();
        Summ[] summs1=summs.toArray(new Summ[summs.size()]);
        Arrays.sort(summs1);
        model.addAttribute("user", userService.findAll());
        model.addAttribute("summs1",summs1);
        return "Recipes";
    }



    @GetMapping("/Recipes/{summ}")
    public String userForm(@PathVariable Summ summ, Model model,@AuthenticationPrincipal User user) {
        if(summ==null){
            return "redirect:/Recipes";
        }
        Iterable<Summ> summs = summRepo.findAll();
        model.addAttribute("rating",getRatingUserInSummary(user, summ));
        model.addAttribute("summs", summs);
        return "RecipesNumber";
    }

    @GetMapping("/home/{summ}")
    public String userS(@PathVariable Summ summ, Model model) {
        if (summ==null){
            return "redirect:/home";
        }
        Iterable<Summ> summs = summRepo.findAll();
        model.addAttribute("summs", summs);
        return "HomeRecipes";}

    @GetMapping("/Recipes/Page/{summ}")
    public String userFormPage(@PathVariable Summ summ, Model model) {
        if(summ==null){
            return "redirect:/cabinet";
        }
        Iterable<Summ> summs = summRepo.findAll();
        model.addAttribute("summs", summs);
        return "EditingNotes";
    }
    @GetMapping("/cabinet")
    public String userMessages(@AuthenticationPrincipal User user,
                               Model model) {
        List<Summ> summs=userRepo.getOne(user.getId()).getSumm();
        model.addAttribute("user", user);
        model.addAttribute("summs",summs);
        return "cabinet";
    }

    @PostMapping("/Recipes")
    public String summSave(
            @RequestParam String commentar,
            @RequestParam Long summId,
            @AuthenticationPrincipal User user
            ) {
        Comment comment = new Comment(commentar);
        comment.setUser(user);
        Summ summ = summRepo.getOne(summId);
        comment.setSumm(summ);
        commentRepo.save(comment);

        return "redirect:/Recipes/"+summ.getId();
    }

    @PostMapping("/Recipes/Page")
     public String editSave(
             @RequestParam String title,
            @RequestParam String descript,
           @RequestParam String number,
           @RequestParam String text,
             @RequestParam String imageURL,

            @RequestParam Map<String, Object> model,
            @RequestParam("summId") Summ summ,
            @AuthenticationPrincipal User user
    ) throws IOException {

        summ.setTitle(title);
        summ.setDescript(descript);
        summ.setNumber(number);
        summ.setImageURL(imageURL);
        summ.setText(text);
        summRepo.save(summ);

       return "redirect:/cabinet";
    }
    private double getRatingUserInSummary(User user, Summ summ) {
        double rating = 0;
        List<Rating> ratingsUser = userRepo.getOne(user.getId()).getRatings();
        for(int i = 0; i < ratingsUser.size(); i++) {
            if (ratingsUser.get(i).getSumm() == summ) {
                rating = ratingsUser.get(i).getRating();
                return rating;
            }
        }
        return rating;
    }

    }

