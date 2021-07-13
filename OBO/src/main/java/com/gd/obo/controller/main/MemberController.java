//작성자: 손영현
package com.gd.obo.controller.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	
	//member 회원가입
	@PostMapping("/addMember")
	public String addMember(Member member) {
		log.debug("회원가입" + member);
		
		return "redirect:/home";
	}
	
	//member 회원가입 폼으로
	@GetMapping("/addMember")
	public String addMember() {
		log.debug("로그인 폼으로");
		
		return "/main/addMember";
	}
	
	//member 로그아웃
	@GetMapping("/memberLogout")
	public String memberLogout(HttpSession session) {
		log.debug("■■■■■ memberLogout : member로그아웃");
		
		session.invalidate();
		//메인 홈페이지로 돌아가기
		return "redirect:/home";
	}
	
}
