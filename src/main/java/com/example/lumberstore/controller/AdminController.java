package com.example.lumberstore.controller;

import com.example.lumberstore.entity.User;
import com.example.lumberstore.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
public class AdminController {
//    @Autowired
//    private UserService userService;
//
//    @GetMapping("/admin")
//    public String userList(Model model) {
//        model.addAttribute("allUsers", userService.allUsers());
//        return "admin";
//    }
//
//    @PostMapping("/admin")
//    public String deleteUser(@RequestParam(required = true, defaultValue = "") int userId,
//                             @RequestParam(required = true, defaultValue = "") String action,
//                             Model model) {
//        if (action.equals("delete")) {
//            userService.deleteUser(userId);
//        }
//        return "redirect:/admin";
//    }
@Autowired
private UserService userService;

    @RequestMapping("/admins")
    public String admin() {
        return "administration";
    }

    @RequestMapping("/operationWithUsers")
    public String usersOperation() {
        return "handlerAdminOperation";
    }

    @RequestMapping("/showAllUsers")
    public String showAllUsers(Model model) {
        model.addAttribute("allUsers", userService.allUsers());
        return "allUsers";
    }

    @RequestMapping("/showUserById")
    public String showUserById() {
        return "loadUserById";
    }

    @RequestMapping("/loadUserById")
    public String loadUserById(Model model, HttpServletRequest request) {
        Long id = Long.valueOf(request.getParameter("id"));
        model.addAttribute("User", userService.loadUserById(id).get());
        return "showUserById";
    }

    @RequestMapping("/showUserByLogin")
    public String showUserByLogin() {
        return "loadUserByLogin";
    }

    @RequestMapping("/loadUserByLogin")
    public String loadUserByLogin(Model model, HttpServletRequest request) {
        String login = request.getParameter("login");
        model.addAttribute("User", userService.loadUserByLogin(login));
        return "showUserByLogin";
    }

    @RequestMapping("/showUsersByName")
    public String loadUsersByName() {
        return "loadUsersByName";
    }

    @RequestMapping("/loadUsersByName")
    public String showUsersByName(Model model, HttpServletRequest request) {
        String name = request.getParameter("nameUser");
        model.addAttribute("User", userService.loadUserByUsername(name));
        return "showUsersByName";
    }

    @RequestMapping("/deleteUserById")
    public String deleteUserById() {
        return "deleteUserById";
    }

    @RequestMapping("/loadUserByIdForDelete")
    public String loadUserByIdForDelete(Model model, HttpServletRequest request) {
        Long id = Long.valueOf(request.getParameter("id"));
        model.addAttribute("User", userService.loadUserById(id).get());
        return "deleteUserById";
    }
    @RequestMapping("/loadUserByLoginForDelete")
    public String loadUserByLoginForDelete(Model model, HttpServletRequest request) {
        String login = (request.getParameter("login"));
        model.addAttribute("User", userService.loadUserByLogin(login));
        return "deleteUserByLogin";
    }
    @RequestMapping("/deleteUser/{id}")
    public String deleteUser(@PathVariable Integer id) {
        userService.deleteUserById(id);
        return "deleteUserById";
    }

    @RequestMapping("/deleteUserLogin/{login}")
    public String deleteUserLogin(@PathVariable String login) {
        Integer id = userService.loadUserByLogin(login).getId();
        userService.deleteUserById((id));
        return "deleteUserByLogin";
    }

    @RequestMapping("/deleteUserByLogin")
    public String deleteUserByLogin() {
        return "deleteUserByLogin";
    }

    @GetMapping("/createNewUser")
    public String createNewUser(Model model) {
        model.addAttribute("usersForm", new User());
        return "createUser";
    }

    @PostMapping("/createNewUser")
    public String newUser(@ModelAttribute("users") @Valid User user, Model model) {
//        if (!user.getPassword().equals(user.getPassword())) {
//            model.addAttribute("passwordError", "");
//            return "createUser";
//        }
//        if (!userService.save(user);) {
//            model.addAttribute("Error", "use something else");
//            return "createUser";
//        }
//        return "createUser";

    userService.save(user);
    model.addAttribute("Everything is ok");
        return "A new user has been created";
    }


    @GetMapping("/updateUserById")
    public String updateUserById(Model model) {
        model.addAttribute("updateUserForm", userService.loadUserById(20L));
        return "updateUserById";
    }

    @PostMapping("/updateUserById")
    public String update(@ModelAttribute("usersForm") @Valid User usersForm) {
        userService.save(usersForm);
        return "updateUserById";
    }
}
