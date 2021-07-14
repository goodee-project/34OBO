// 작성자 : 이윤정

package com.gd.obo.controller.staff;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.obo.service.staff.ShelterService;
import com.gd.obo.service.staff.StaffService;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/staff")	// staff 전용 페이지
public class StaffController {
	@Autowired StaffService staffService;
	@Autowired ShelterService shelterService;
	
	// staff 회원가입 창 이동
	@GetMapping("/addStaff")
	public String addStaff(Model model){
		List<Shelter> shelterList = shelterService.getShelterList();
		log.debug("●●●●▶shelterList: "+shelterList);
		
		model.addAttribute("shelterList", shelterList);
		
		return "staff/addStaff";
	}
	
	// staff 회원가입 action
	@PostMapping("/addStaff")
	public String addStaff(Staff staff) {
		log.debug("●●●●▶회원가입 staff: "+staff);
		
		//서비스 실행
		int addCnt = staffService.addStaff(staff);
		log.debug("●●●●▶addCnt(완료1, 실패0): " + addCnt);
		
		return "redirect:/staff/";
	}
	
	// staff 정보수정 창 이동
	@GetMapping("/modifyStaff")
	public String modifyStaff() {
		return "modifyStaff";
	}
	
	// staff 정보수정 action
	@PostMapping("/modifyStaff")
	public String modifyStaff(Staff staff) {
		log.debug("●●●●▶staff 정보수정: "+staff);
		
		//서비스 실행
		int modifyCnt = staffService.modifyStaff(staff);
		log.debug("●●●●▶modifyCnt(완료1, 실패0): " + modifyCnt);
		
		return "redirect:/staff/getStaffAccount";
	}
	
	// staff account 창 이동
	@GetMapping("/getStaffAccount")
	public String getStaffAccount() {
		return "/staff/getStaffAccount";
	}

}
