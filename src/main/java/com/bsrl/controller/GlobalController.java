package com.bsrl.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GlobalController {

    @RequestMapping("/to_login")
    public String toLogin(){
        return "login";
    }

    @RequestMapping("/")
    public String home(){
        return "home";
    }

    @RequestMapping("/userRlnShow")
    public String userRlnShow(){
        return "home";
    }
    @RequestMapping("/userRlnEdit")
    public String userRlnEdit(){
        return "UserRlnEdit";
    }

    @RequestMapping("/userList")
    public String userList(){
        return "UserList";
    }

}
