package com.gd.obo.restapi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.VolunteerService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class VolunteerRestapi {
	@Autowired VolunteerService volunteerService;

	//일반봉사 중복 신청 확인 
	@GetMapping("/member/getMemberIdForCheckApplying")
	public String getMemberIdForCheckApplying(@RequestParam(value="memberId", required = true) String memberId,
											@RequestParam(value="recruitId", required = true) int recruitId) {
		String ckMemberId = volunteerService.getMemberIdForCheckApplying(memberId, recruitId);
		log.debug("===== 중복확인!"+ckMemberId);
		return ckMemberId;
	}
	/*
	//정기봉사 중복 신청 확인
	@GetMapping("/member/getMemberIdForCheckApplyingP")
	public String getMemberIdForCheckApplyingP(@RequestParam(value="memberId", required = true) String memberId,
											@RequestParam(value="recruitId", required = true) int recruitId) {
		String ckMemberId = volunteerService.getMemberIdForCheckApplying(memberId, recruitId);
		log.debug("===== 중복확인!"+ckMemberId);
		return ckMemberId;
	}
	*/
}
