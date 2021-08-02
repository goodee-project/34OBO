// 작성자 : 이윤정

package com.gd.obo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.obo.service.StaffService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/s")	// staff 전용 페이지
public class StaffHomeController {
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
	public String login(HttpSession session, String loginStaffId, String loginStaffPw) {
		log.debug("●●●●▶로그인 staffId: "+loginStaffId);
		log.debug("●●●●▶로그인 staffPw: "+loginStaffPw);
		
		Staff staff = new Staff();
		staff.setStaffId(loginStaffId);
		staff.setStaffPw(loginStaffPw);
		
		// 로그인 세션 정보 -> 직원id, 이름, 보호소id 
		Staff loginStaff = staffService.login(staff);
		
		if(loginStaff == null) {
			log.debug("●●●●▶ 로그인 실패!!!! 정보를 다시 확인해주세요!!!!");
			return "redirect:/s/";
		}
		
		int staffLevel = loginStaff.getStaffLevel();
		if(staffLevel == 0) {
			log.debug("●●●●▶ 레벨0. 승인 대기중!");
			return "redirect:/s/";
		}
			
		// 세션 세팅
		if(loginStaff != null) {
			session.setAttribute("loginStaff", loginStaff);
			log.debug("●●●●▶ 로그인 완료!!!!!");
		}
		
		return "redirect:/s/";
	}
	
	// staff 로그아웃 action
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.debug("●●●●▶ 로그아웃 완료!!!!!!!");
		session.invalidate();
		
		return "redirect:/s/";
	}
	
	// staff 회원가입 창 이동
	@GetMapping("/addStaff")
	public String addStaff(Model model){
		
		return "staff/addStaff";
	}
	
	// staff 회원가입 action
	@PostMapping("/addStaff")
	public String addStaff(Staff staff) {
		log.debug("●●●●▶회원가입 staff: "+staff);
		
		//서비스 실행
		int addCnt = staffService.addStaff(staff);
		log.debug("●●●●▶addCnt(완료1, 실패0): " + addCnt);
		
		return "redirect:/s/";
	}
}
