// 작성자 : 이윤정

package com.gd.obo.restapi;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.ShelterService;
import com.gd.obo.service.StaffService;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class StaffRestapi {
	@Autowired ShelterService shelterService;
	@Autowired StaffService staffService;
	
	// staff 로그인 유효성 검사
	@GetMapping("/checkStaffLogin")
	public int checkStaffLogin(@RequestParam(value="loginStaffId", required = true)String loginStaffId, 
							@RequestParam(value="loginStaffPw", required = true)String loginStaffPw) {
		log.debug("●●●●▶로그인 staffId유효성: "+loginStaffId);
		log.debug("●●●●▶로그인 staffPw유효성: "+loginStaffPw);
		
		//받아온 값 넣어주기
		Staff staff = new Staff();
		staff.setStaffId(loginStaffId);
		staff.setStaffPw(loginStaffPw);
		
		return staffService.checkStaffLogin(staff);
	}
	
	// staff id 중복확인
	@GetMapping("/getStaffIdCheck")
	public int getStaffIdCheck(@RequestParam(value = "staffId", required = true) String staffId){
		log.debug("●●●●▶중복확인용 staffId: "+staffId);
		int idCnt = staffService.getStaffIdCheck(staffId);
		return idCnt;
	}
	
	// 보호소 이름 자동완성
	@GetMapping("/getShelterNameList")
	public List<Shelter> getShelterNameList(@RequestParam(value="searchWord", required = false) String searchWord){
		log.debug("●●●●▶검색어: "+searchWord);
		return shelterService.getShelterName(); // 매개변수 searchWord 넣고 service->mapper.java->mapper.xml 수정 꼭
	}
}
