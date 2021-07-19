// 작성자 : 이윤정

package com.gd.obo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VolunteerController {
	
	// staff 봉사
	@GetMapping("/staff/getVolunteer")
	public String getVolunteer() {
		return "staff/getVolunteer";
	}
	
	// staff 일반봉사 - 모집공고
	@GetMapping("/staff/getVolunteerRecruitN")
	public String getVolunteerRecruitN(HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getVolunteerRecruitN";
	}
	
	// staff 일반봉사 - 모집공고
	@GetMapping("/staff/getVolunteerApplyN")
	public String getVolunteerApplyN(HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getVolunteerApplyN";
	}
	
	// staff 일반봉사 - 확인목록
	@GetMapping("/staff/getVolunteerCheckN")
	public String getVolunteerCheckN(HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getVolunteerCheckN";
	}
	
	// staff 정기봉사 - 모집공고
	@GetMapping("/staff/getVolunteerRecruitP")
	public String getVolunteerRecruitP(HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getVolunteerRecruitP";
	}
	
	// staff 정기봉사 - 모집공고
	@GetMapping("/staff/getVolunteerApplyP")
	public String getVolunteerApplyP(HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getVolunteerApplyP";
	}
	
	// staff 정기봉사 - 확인목록
	@GetMapping("/staff/getVolunteerCheckP")
	public String getVolunteerCheckP(HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getVolunteerCheckP";
	}
	
	
}
