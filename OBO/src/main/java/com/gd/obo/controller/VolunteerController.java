// 작성자 : 이윤정

package com.gd.obo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VolunteerController {
	
	// staff 봉사
	@GetMapping("/staff/getVolunteer")
	public String getVolunteer() {
		return "staff/getVolunteer";
	}
	
	
	// staff 일반봉사
	@GetMapping("/staff/getVolunteerN")
	public String getVolunteerN() {
		return "staff/getVolunteerN";
	}
	
	// staff 정기봉사
	@GetMapping("/staff/getVolunteerP")
	public String getVolunteerP() {
		return "staff/getVolunteerP";
	}
}
