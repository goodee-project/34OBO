package com.gd.obo.restapi;

import java.util.HashMap;
import java.util.Map;

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

	//일반봉사 중복 신청 확인 + 자격 확인
	@GetMapping("/member/getMemberIdForCheckApplying")
	public Map<String, Object> getMemberIdForCheckApplying(HttpSession session, @RequestParam(value="recruitId", required = true) int recruitId,
													@RequestParam(value="categoryName", required = true) String categoryName) {
		String ckQualification = null;
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		String ckMemberId = volunteerService.getMemberIdForCheckApplying(memberId, recruitId);
		if(categoryName.equals("의료") || categoryName.equals("미용") || categoryName.equals("훈련")) {
			ckQualification = volunteerService.getMemberQualification(memberId, recruitId, categoryName);
		} else {
			ckQualification = "ok";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("ckMemberId", ckMemberId);
		map.put("ckQualification", ckQualification);
		log.debug("===== memberId!"+memberId);
		log.debug("===== 중복확인!"+ckMemberId);
		log.debug("===== 자격확인!"+ckQualification);
		return map;
	}
	
	
	//정기봉사 중복 신청 확인
	@GetMapping("/member/getMemberIdForCheckApplyingP")
	public Map<String, Object> getMemberIdForCheckApplyingP(HttpSession session, @RequestParam(value="recruitId", required = true) int recruitId,
																	@RequestParam(value="categoryName", required = true) String categoryName) {
		String ckQualification = null;
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		String ckMemberId = volunteerService.getMemberIdForCheckApplyingP(memberId, recruitId) ;
		if(categoryName.equals("의료") || categoryName.equals("미용") || categoryName.equals("훈련")) {
			ckQualification = volunteerService.getMemberQualification(memberId, recruitId, categoryName);
		} else {
			ckQualification = "ok";
		}
		Map<String, Object> map = new HashMap<>();
		map.put("ckMemberId", ckMemberId);
		map.put("ckQualification", ckQualification);
		log.debug("===== memberId!"+memberId);
		log.debug("===== 중복확인!"+ckMemberId);
		return map;
	}
	
	
}
