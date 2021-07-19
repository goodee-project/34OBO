//작성자: 손영현
package com.gd.obo.restapi;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.DonationService;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class DonationRestapi {
	@Autowired
	DonationService donationService;
	//내정보 -> 후원내역
	@PostMapping("/member/getFullDonation")
	public Map<String, Object> getFullDonation(HttpSession session,
												@RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		Map<String, Object> map = donationService.getFullMoneyDonationListByMemberId(currentPage, 5, memberId);
		
		return map;
	}
	
	
	
	//내정보 -> 정기후원
	@PostMapping("/member/getPeriodicallyDonationByMemberId")
	public Map<String, Object> getPDonationByMID(HttpSession session,
												@RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		Map<String, Object> map = donationService.getPeriodicallyDonationByMemberId(currentPage, 5, memberId);
		
		return map;
	}

}
