//작성자 : 남궁혜영
package com.gd.obo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.obo.service.ManagerService;
import com.gd.obo.vo.Manager;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Controller
@Slf4j
@RequestMapping("/manager")
public class ManagerHomeController {
	@Autowired ManagerService managerService;
	
	@GetMapping("/home")
	public String managerHome() {
		log.debug("======managerHome");
		return "manager/home";
	}
	//manager 로그인
	@PostMapping("/login")
	public String managerLogin(HttpSession session, Manager manager, Model model) {
		log.debug("====== manager :"+manager.toString());
		Manager loginManager = managerService.login(manager);
	    if (loginManager != null) {
	        session.setAttribute("loginManager", loginManager);
	    }
	    model.addAttribute("manager", manager);
	    
		return "redirect:/manager/home";
	}
	
	//manager로그아웃
	@GetMapping("/logout")
	public String managerLogout(HttpSession session) {
		session.invalidate();
		return "manager/home";
	}
}
