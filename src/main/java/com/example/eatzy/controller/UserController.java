package com.example.eatzy.controller;


import com.example.eatzy.common.ApiResponse;
import com.example.eatzy.model.User;
import com.example.eatzy.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class UserController {

    @Autowired
    private UserServiceImpl service;

    @PostMapping("/signup")
    public String signUpCustomer(@ModelAttribute User c, RedirectAttributes redirectAttributes) {

        String responseMessage = service.signUpCustomer(c);

        if (responseMessage.equals("signup successfull")) {
            redirectAttributes.addFlashAttribute("message", "Signup successful!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Email already exists");
        }

        return "redirect:/login-page";
    }
    @GetMapping("/orders")
    public String customerOrders() {
        return "Customer Orders";
    }

}

