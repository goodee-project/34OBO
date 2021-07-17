//작성자: 손영현
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
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.MemberService;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.MemberAddress;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	MemberService memberService;
	
	//카카오 로그인
	@PostMapping("/loginByKakao")
	public String loginByKakao(HttpSession session, Member member) {
		
		log.debug("■■■■■ loginByKakao memberId param: " + member);
		
		Member loginMember = memberService.getMemberByKakaoLogin(member);
		log.debug("■■■■■ loginByKakao loginMember: " + loginMember);
		
		session.setAttribute("loginMember", loginMember);
		
		return "redirect:/home";
	}
	
	//카카오 로그인 폼으로
	@GetMapping("/loginByKakao")
	public String getMemberListByKakaoId(Model model,
									@RequestParam(value = "code", required = true)String code,
									@RequestParam(value = "error", required = false)String error) {
		log.debug("■■■■■ loginByKakao code param: " + code);
		log.debug("■■■■■ loginByKakao error param: " + error);
		
		String url = "http://localhost/obo/loginByKakao";
		
		List<Map<String, Object>> list = null;
		String kakaoId = null;
		
		//error 코드가 있으면 로그인 x
		if(error == null) {
			//토큰 받기
			String accessToken = memberService.getKakaoToken(code, url);
			
			//카카오 아이디 받기
			kakaoId = memberService.getKakaoId(accessToken);
			
			//카카오에 연동된 OBO member목록 가져오기
			list = memberService.getMemberListByKakaoId(kakaoId);
		} else {
			return "redirect:/home";
		}
		
		log.debug("■■■■■■■■■■■■ 확인확인하과어랑렁나리너 ㄹ: " + list);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		}
		
		
		model.addAttribute("kakaoId" , kakaoId);
		return "main/getMemberListByKakaoId";
	}
	
	//카카오 연동
	@GetMapping("/member/getKakaoLink")
	public String getKakaoLink(HttpSession session,
								@RequestParam(value = "code", required = true)String code,
								@RequestParam(value = "error", required = false)String error) {
		log.debug("■■■■■ getKakaoLink code param: " + code);
		log.debug("■■■■■ getKakaoLink error param: " + error);
		
		String url = "http://localhost/obo/member/getKakaoLink";
		//error 코드가 있으면 연동 x
		if(error == null) {
			//토큰 받기
			String accessToken = memberService.getKakaoToken(code, url);
			
			//카카오 아이디 받기
			String kakaoId = memberService.getKakaoId(accessToken);
			
			//카카오 아이디 저장하기
			memberService.modifyMemberByKakao(((Member)session.getAttribute("loginMember")).getMemberId(), kakaoId);
		}
		
		return "redirect:/member/getMemberOne";
	}
	
	//member Pw 수정 창으로 이동
	@GetMapping("/member/modifyMemberPw")
	public String modifyMemberPw() {
		return "main/modifyMemberPw";
	}
	
	//member 정보 업데이트
	@PostMapping("/member/modifyMemberOne")
	public String modifyMemberOne(MemberAddress memberAddress) {
		log.debug("■■■■■ modifyMemberOne param" + memberAddress);
		
		memberService.modifyMemberOne(memberAddress);
		
		return "redirect:/member/getMemberOne";
	}
	
	//member 정보 수정 페이지로 이동
	@GetMapping("/member/modifyMemberOne")
	public String modifyMemberOne(HttpSession session, Model model) {
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		
		model.addAttribute("memberOne", memberService.getMemeberOne(memberId));
		return "main/modifyMemberOne";
	}
	
	//member 정보 상세보기(내 정보)
	@GetMapping("/member/getMemberOne")
	public String getMemberOne(HttpSession session, Model model) {
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		log.debug("■■■■■ memberOne 멤버아이디 : " + memberId);
		
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
