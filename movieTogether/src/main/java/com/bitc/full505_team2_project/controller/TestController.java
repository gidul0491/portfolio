package com.bitc.full505_team2_project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestController {

  @RequestMapping(value = {"/aa", "/index"})
  public String index() throws Exception {
    return "/index";
  }
}
