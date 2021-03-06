// 작성자 : 이윤정

package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.obo.service.ShelterService;
import com.gd.obo.service.StaffService;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/staff")	// staff 전용 페이지
public class StaffController {
	@Autowired StaffService staffService;
	@Autowired ShelterService shelterService;
	
	// staff 정보수정 창 이동
	@GetMapping("/modifyStaff")
	public String modifyStaff(Model model, HttpSession session) {
		log.debug("●●●●●●●●●●▶정보수정 이동!");
		// 세션의 내 정보 가져오기
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		
		// 서비스 호출
		Staff staffOne = staffService.getStaffOne(staffId);
		log.debug("●●●●▶staffOne: "+staffOne);
		
		// view 같이 보내기
		model.addAttribute("staffOne", staffOne);
		
		return "staff/modifyStaff";
	}
	
	// staff 정보수정 action
	@PostMapping("/modifyStaff")
	public String modifyStaff(Staff staff) {
		log.debug("●●●●●●●●●●▶정보수정 실행!");
		log.debug("●●●●▶staff 정보수정: "+staff);
		log.debug("●●●●▶staff id: "+staff.getStaffId());
		
		// 비밀번호 입력 안 했을 경우 -> 비밀번호 수정하지 않음
		if(staff.getStaffPw().equals("")) {
			log.debug("●●●●▶비밀번호 수정X");
			staff.setStaffPw(null);
			int modifyCnt = staffService.modifyStaff(staff);
			log.debug("●●●●▶modifyCnt(완료1, 실패0): " + modifyCnt);
			
			return "redirect:/staff/getStaffAccount";
		}
		
		// 비밀번호 입력 했을 경우 -> 비밀번호 같이 수정
		log.debug("●●●●▶비밀번호 수정O");
		
		// 서비스 실행
		int modifyCnt = staffService.modifyStaff(staff);
		log.debug("●●●●▶modifyCnt(완료1, 실패0): " + modifyCnt);
		
		return "redirect:/staff/getStaffAccount";
	}
	
	// staff account 창 이동
	@GetMapping("/getStaffAccount")
	public String getStaffAccount(Model model, HttpSession session) {
		log.debug("●●●●●●●●●●▶account 페이지 이동");
		// 세션의 staffId, shelterId 가져오기
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶로그인 계정의 staffId: " + staffId);
		log.debug("●●●●▶로그인 계정의 shelterId: " + shelterId);
		
		// 서비스 실행
		Map<String, Object> map = staffService.getStaffAccount(staffId, shelterId);
		
		// view에 함께 보내주기
		model.addAttribute("staffOne", map.get("staffOne"));
		model.addAttribute("staffLevel0", map.get("staffLevel0"));
		
		return "staff/getStaffAccount";
	}
	
	// staff 승인대기 창 이동
	@GetMapping("/modifyStaffState")
	public String modifyStaffState(Model model, HttpSession session) {
		log.debug("●●●●●●●●●●▶승인 페이지 이동");
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●●●●●●●▶세션의 shelterId-> "+shelterId);
		List<Map<String, Object>> staffList = staffService.getStaffListByMaster(shelterId);
		log.debug("●●●●●●●●●●▶불러온 staffList-> "+staffList);
		
		model.addAttribute("staffList", staffList);
		
		return "staff/modifyStaffState";
	}
	
	// staff 승인대기 action
	@PostMapping("/modifyStaffState")
	public String modifyStaffState() {
		log.debug("●●●●●●●●●●▶승인 페이지 이동");
		
		return "redirect:/staff/getStaffAccount";
	}

}
