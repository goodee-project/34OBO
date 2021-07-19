// 작성자 : 이윤정
// 수정자 : 남궁혜영(2021-07-19)

package com.gd.obo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.VolunteerService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VolunteerController {
	@Autowired VolunteerService volunteerService;
	
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
	
	// 회원 봉사 메인페이지
	@GetMapping("/getVolunteer")
	public String getMemberVolunteer() {
		return "main/getVolunteer";
	}
	
	// 회원 일반봉사
	@GetMapping("/member/getVolunteerN")
	public String getVolunteerN(Model model,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
			@RequestParam(value="searchWord", required = false) String searchWord,
			@RequestParam(value="categoryName", required = false) String categoryName) {
		
		if(searchWord != null && searchWord.equals("")) {
			searchWord=null;
		}
		if(categoryName != null && categoryName.equals("")) {
			categoryName=null;
		}
		Map<String, Object> map = volunteerService.getVolunteerN(currentPage, rowPerPage, searchWord, categoryName);
		model.addAttribute("recruitList", map.get("recruitList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("total", map.get("recruitTotal"));
		model.addAttribute("categoryName",categoryName);
		model.addAttribute("categoryNameList", map.get("categoryNameList"));
		log.debug("=====map:"+map);
		return "main/getVolunteerN";
	}
}
