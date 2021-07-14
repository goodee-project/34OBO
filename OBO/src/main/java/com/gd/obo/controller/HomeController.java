//작성자: 손영현
package com.gd.obo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {

	@GetMapping({"/home", "/index", "/"})
	public String getHome() {
		log.debug("■■■■■ 메인 홈페이지로");

		return "/main/home";
	}
}