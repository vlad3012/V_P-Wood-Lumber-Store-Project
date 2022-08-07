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
    @Autowired
    private UserService userService;

    @GetMapping("/admin")
    public String userList(Model model) {
        model.addAttribute("allUsers", userService.allUsers());
        return "admin";
    }

    @PostMapping("/admin")
    public String deleteUser(@PathVariable("id") int userId, Model model) {
        userService.deleteUserById(userId);
        return "redirect:/admin";
    }

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

    @RequestMapping("/showUserByName")
    public String findByUserName() {
        return "findByUserName";
    }

    @RequestMapping("/findByUserName")
    public String findByUserName(Model model, HttpServletRequest request) {
        String name = request.getParameter("userName");
        model.addAttribute("User", userService.findByUserName(name));
        return "showUserByName";
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
        model.addAttribute("user", new User());
        return "createUser";
    }

    @PostMapping("/createNewUser")
    public String newUser(@ModelAttribute("users") @Valid User user) {
    userService.save(user);
        return "createNewUser";
    }


    @GetMapping("/updateUserById")
    public String updateUserById(Model model) {
        model.addAttribute("updateUser", userService.loadUserById(20L));
        return "updateUserById";
    }

    @PostMapping("/updateUserById")
    public String update(@ModelAttribute("user") @Valid User usersForm) {
        userService.save(usersForm);
        return "updateUserById";
    }
}
