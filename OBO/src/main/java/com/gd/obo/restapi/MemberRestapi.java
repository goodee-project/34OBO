//작성자: 손영현
package com.gd.obo.restapi;

import java.io.InputStream;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
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
	//메일 발송용
	@Autowired
	JavaMailSender javaMailSender;
	
	//비밀번호 변경
	@PostMapping("/member/modifyMemberPw")
	public boolean modifyMemberPw(HttpSession session,
									@RequestParam(value = "originalPw", required = true)String originalPw,
									@RequestParam(value = "changedPw", required = true)String changedPw) {
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		//변경 실패하면 다시 폼으로
		
		//변경 성공하면 로그아웃
		return memberService.modifyMemberPw(memberId, originalPw, changedPw);
	}
	
	//회원가입 인증 메일을 발송!
	@PostMapping("/checkMail")
	public String checkMail(@RequestParam(value = "mail", required = true)String mail) {
		
		log.debug("■■■■■ checkMail param : "+ mail);
		
		Random random = new Random();  //난수 생성을 위한 랜덤 클래스
		String key="";  //인증번호 

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(mail); //스크립트에서 보낸 메일을 받을 사용자 이메일 주소 
		
		//입력 키를 위한 코드
		for(int i =0; i<3;i++) {
			int index=random.nextInt(25)+65; //A~Z까지 랜덤 알파벳 생성
			key+=(char)index;
		}
		
		int numIndex=random.nextInt(9999)+1000; //4자리 랜덤 정수를 생성
		key+=numIndex;
		
		message.setSubject("인증번호 입력을 위한 메일 전송");
		message.setText("인증 번호 : "+key);
		
		javaMailSender.send(message);
		
		log.debug("■■■■■ checkMail key : "+ key);
		
		return key;
	}
	
	//member 정보 수정을 위한 비밀번호 검사
	@PostMapping("/getMemberByPwCheck")
	public boolean getMemberByPwCheck(HttpSession session,
										@RequestParam(value = "memberPw", required = true)String memberPw) {
		log.debug("■■■■■ getMemberByPwCheck param: " + memberPw);
		
		//회원 가입 결과
		boolean result = false; //검사 결과 성공 true, 실패 false
		
		//회원 조회를 위해 Member에 담음
		Member member = new Member();
		member.setMemberId(((Member)session.getAttribute("loginMember")).getMemberId());
		member.setMemberPw(memberPw);
		
		if(memberService.getMemberByLogin(member) !=null) {//로그인 성공
			result = true;
		}
			
		return result;
	}
	
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
