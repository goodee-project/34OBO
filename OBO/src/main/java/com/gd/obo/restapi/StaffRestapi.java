// 작성자 : 이윤정

package com.gd.obo.restapi;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	@Autowired JavaMailSender javaMailSender;	// gmail 인증 코드 발송
	
	// staff 로그인 유효성 검사
	@GetMapping("/checkStaffLogin")
	public int checkStaffLogin(@RequestParam(value="loginStaffId", required = true)String loginStaffId, 
							@RequestParam(value="loginStaffPw", required = true)String loginStaffPw) {
		//받아온 값 넣어주기
		Staff staff = new Staff();
		staff.setStaffId(loginStaffId);
		staff.setStaffPw(loginStaffPw);
		log.debug("●●●●▶로그인 staff 유효성 확인 : "+staff);
		
		return staffService.checkStaffLogin(staff);
	}
	
	// staff id 중복확인
	@GetMapping("/getStaffIdCheck")
	public int getStaffIdCheck(@RequestParam(value = "staffId", required = true) String staffId,
								@RequestParam(value = "staffPw", required = false) String staffPw){
		log.debug("●●●●▶중복확인용 staffId: "+staffId);
		
		int cnt = staffService.getStaffAccountCheck(staffId, staffPw);
		log.debug("●●●●▶중복확인(0:중복아님, 1:중복)->: "+cnt);
		
		return cnt;
	}
	
	// staff 회원가입 email 인증 코드 발송
	@PostMapping("/checkEmail")
	public String checkEmail(@RequestParam(value = "email", required = true) String email) {
		// 랜덤 - 난수 생성
		Random random = new Random();
		String key = "";  // 인증번호 
		
		// key값 설정 -> 숫자6
		/*
		for(int i=0; i<3; i++) { // 알파벳3
			int index = random.nextInt(25)+65;
			key += (char)index;
		}*/
		int numIndex = random.nextInt(999999); // 숫자6
		key += numIndex;
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email); // 인증 받을 email
		message.setSubject("인증번호 입력을 위한 메일 전송");	// 메일 제목
		message.setText("인증 번호 : "+key);	// 메일 내용
		
		//javaMailSender.send(message);	// 테스트 중에는 주석처리
		
		return key;
	}
	
	// staff 정보 수정 시 pw 일치하는지 확인
	@PostMapping("/checkStaffPw")
	public int checkStaffPw(HttpSession session, @RequestParam(value = "staffPw", required = true) String staffPw) {
		log.debug("●●●●▶입력한 pw->: "+staffPw);
		
		// 세션에서 id를 가져온다.
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		int cnt = staffService.getStaffAccountCheck(staffId, staffPw);
		log.debug("●●●●▶일치확인(0:불일치, 1:일치)->: "+cnt);
		
		return cnt;
	}
	
	@PostMapping("/changeStaffState")
	public int changeStaffState(@RequestParam(value = "staffLevel", required = false) Integer staffLevel,
								@RequestParam(value = "staffActive", required = false) Integer staffActive,
								@RequestParam(value = "staffId", required = true) String staffId) {
		log.debug("●●●●▶선택한 staffId->: "+staffId);
		log.debug("●●●●▶변경할 staffLevel->: "+staffLevel);
		log.debug("●●●●▶변경할 staffActive->: "+staffActive);
		
		int cnt = staffService.modifyStaffState(staffLevel, staffActive, staffId);
		log.debug("●●●●▶수정확인(0:수정미완, 1:수정완료)->: "+cnt);
		
		return cnt;
	}
	
	// 보호소 이름 자동완성
	@GetMapping("/getShelterNameList")
	public List<Shelter> getShelterNameList(@RequestParam(value="searchWord", required = false) String searchWord){
		log.debug("●●●●▶검색어: "+searchWord);
		return shelterService.getShelterName(searchWord); // 매개변수 searchWord 넣고 service->mapper.java->mapper.xml 수정 꼭
	}
}
