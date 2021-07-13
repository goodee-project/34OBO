// 작성자 : 이윤정

package com.gd.obo.controller.staff;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.obo.service.staff.StaffService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/staff")	// staff 전용 페이지
public class HomeController {
	@Autowired StaffService staffService;
	
	// staff 로그인 페이지
	@GetMapping({"/", "/home", "/index"})
	public String staffHome(HttpSession session, Model model) {
		log.debug("●●●●▶staffHome !");
		
		Staff loginStaff = (Staff)session.getAttribute("loginStaff");
		log.debug("●●●●▶loginStaff->"+loginStaff);
		
		return "staff/staffHome";
	}
	
	// staff 로그인 action
	@PostMapping("/login")
	public String login(HttpSession session, Staff staff) {
		log.debug("●●●●▶로그인 staff 정보: "+staff);
		
		// 로그인 세션 정보 -> 직원id, 이름, 보호소id 
		Staff loginStaff = staffService.login(staff);
		
		// 세션 세팅
		if(loginStaff != null) {
			session.setAttribute("loginStaff", loginStaff);
			log.debug("●●●●▶ 로그인 완료!!!!!");
		}
		
		if(loginStaff == null) {
			log.debug("●●●●▶ 로그인 실패!!!! 정보를 다시 확인해주세요!!!!");
		}
		
		return "redirect:/staff/";
	}
	
	// staff 로그아웃 action
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.debug("●●●●▶ 로그아웃 완료!!!!!!!");
		session.invalidate();
		
		return "redirect:/staff/";
	}
	
}
