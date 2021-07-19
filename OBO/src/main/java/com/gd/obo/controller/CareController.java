// 작성자 : 이윤정

package com.gd.obo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CareController {
	
	// staff - 케어 info 보기 페이지 이동
	@GetMapping("/staff/getCareInfoInStaff")
	public String getCareInfoInStaff (Model model) {
		
		return "staff/getCareInfoInStaff";
	}
	
	// staff - 케어 plan 작성 페이지 이동
	@GetMapping("/staff/addCarePlanInStaff")
	public String addCarePlanInStaff (Model model) {
		
		return "staff/addCarePlanInStaff";
	}
	
	// staff - 케어 plan 목록 페이지 이동
	@GetMapping("/staff/getCarePlanInStaff")
	public String getCarePlanInStaff (Model model) {
		
		return "staff/getCarePlanInStaff";
	}
	
	// staff - 케어 plan 달력 보기 페이지 이동
	@GetMapping("/staff/getCarePlanCalInStaff")
	public String getCarePlanCalInStaff (Model model) {
		
		return "staff/getCarePlanCalInStaff";
	}
	
	// staff - 케어 record 작성 페이지 이동
	@GetMapping("/staff/addCareRecordInStaff")
	public String addCareRecordInStaff (Model model) {
		
		return "staff/addCareRecordInStaff";
	}
	
	// staff - 케어 record 목록 페이지 이동
	@GetMapping("/staff/getCareRecordInStaff")
	public String getCareRecordInStaff (Model model) {
		
		return "staff/getCareRecordInStaff";
	}
	
		
}
