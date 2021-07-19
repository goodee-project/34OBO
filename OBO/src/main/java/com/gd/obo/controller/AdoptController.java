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
public class AdoptController {
	
	
	// staff - 입양&케어 페이지 이동
	@GetMapping("/staff/getAdoptAndCare")
	public String getAdoptAndCare (HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getAdoptAndCare";
	}
	
	// staff - 입양 신청 목록 이동
	@GetMapping("/staff/getAdoptApplyInStaff")
	public String getAdoptApplyInStaff (HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getAdoptApplyInStaff";
	}
	
	// staff - 입양 승인 목록 이동
	@GetMapping("/staff/getAdoptApprovalInStaff")
	public String getAdoptApplyApprovalInStaff (HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getAdoptApprovalInStaff";
	}
	
	// staff - 입양 거절 목록 이동
	@GetMapping("/staff/getAdoptRejectInStaff")
	public String getAdoptRejectInStaff (HttpSession session, Model model) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		return "staff/getAdoptRejectInStaff";
	}
}
