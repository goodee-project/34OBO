//작성자: 손영현
package com.gd.obo.restapi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.MemberService;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class MemberRestapi {
	@Autowired
	MemberService memberService;
	
	//회원가입을 위한 아이디 중복 검사
	@GetMapping("/getMemeberIdByAddMember")
	public String getMemberIdByAddMember(@RequestParam(value = "memberId", required = true)String memberId) {
		log.debug("■■■■■ getMemberByLogin param: " + memberId);
		
		return memberService.getMemberIdByAddMember(memberId);
	}
	
	//회원 로그인
	@PostMapping("/getMemberByLogin")
	public boolean getMemberByLogin(HttpSession session, Member member) {
		boolean result = false; //로그인 성공 true, 실패 false
		log.debug("■■■■■ getMemberByLogin param: " + member);
		
		Member loginMember = memberService.getMemberByLogin(member);
		
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			result = true;
		}
		
		return result;
	}
}
