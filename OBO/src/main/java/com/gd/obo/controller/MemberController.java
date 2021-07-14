//작성자: 손영현
package com.gd.obo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gd.obo.service.MemberService;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.MemberAddress;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	MemberService memberService;
	
	//memeber 정보 상세보기(내 정보)
	@GetMapping("/member/getMemberOne")
	public String getMemberOne(HttpSession session, Model model) {
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		log.debug("■■■■■ 마이페이지 멤버아이디 : " + memberId);
		
		//내 정보 가져오기
		model.addAttribute("memberOne", memberService.getMemeberOne(memberId));
		return "main/getMemberOne";
	}
	
	//member 회원가입
	@PostMapping("/addMember")
	public String addMember(MemberAddress memberAddress) {
		log.debug("■■■■■ addMember param" + memberAddress);
		int row = memberService.addMember(memberAddress);
		
		log.debug("■■■■■ 회원 가입이 되면 2 : " + row);
		
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
