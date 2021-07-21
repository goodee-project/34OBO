package com.gd.obo.restapi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.VolunteerService;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class VolunteerRestapi {
	@Autowired VolunteerService volunteerService;

	//일반봉사 중복 신청 확인 
	@GetMapping("/member/getMemberIdForCheckApplying")
	public String getMemberIdForCheckApplying(HttpSession session, @RequestParam(value="recruitId", required = true) int recruitId) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		String ckMemberId = volunteerService.getMemberIdForCheckApplying(memberId, recruitId);
		log.debug("===== memberId!"+memberId);
		log.debug("===== 중복확인!"+ckMemberId);
		return ckMemberId;
	}
	
	//정기봉사 중복 신청 확인
	@GetMapping("/member/getMemberIdForCheckApplyingP")
	public String getMemberIdForCheckApplyingP(HttpSession session, @RequestParam(value="recruitId", required = true) int recruitId) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		String ckMemberId = volunteerService.getMemberIdForCheckApplyingP(memberId, recruitId) ;
		log.debug("===== memberId!"+memberId);
		log.debug("===== 중복확인!"+ckMemberId);
		return ckMemberId;
	}
}
