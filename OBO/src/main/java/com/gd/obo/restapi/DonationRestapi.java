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
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class DonationRestapi {
	@Autowired
	DonationService donationService;
	
	//내정보 -> 내 후원금액
	@GetMapping("/member/getTotalDonation")
	public int getTotalDonation(HttpSession session) {
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		int totalDonation = donationService.getTotalMoneyByMemberId(memberId);
		log.debug("■■■■■ getMemberDonation totalDonation : "+ totalDonation);
		
		return totalDonation;
	}
	
	//내정보 -> 물품후원내역 -> 상세보기
	@PostMapping("/member/getDonationItemOne")
	public Map<String, Object> getDonationItemOne(@RequestParam(value = "donationItemListId", required = true)int donationItemListId){
		log.debug("■■■■■ getDonationItemOne param : " + donationItemListId);
		
		return donationService.getDonationItemOne(donationItemListId);
	}
	
	
	//내정보 -> 물품후원내역
	@PostMapping("/member/getDonationItemByMemberId")
	public Map<String, Object> getDonationItemByMemberId(HttpSession session,
															@RequestParam(value = "currentPage", defaultValue = "1")int currentPage){
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		Map<String, Object> map = donationService.getDonationItemByMemberId(currentPage, 5, memberId);
		
		return map;
	}
	
	//물품후원 저장
	@PostMapping("/member/addDonationItem")
	public boolean addDonationItem(DonationItemList donationItemList) {
		boolean result = false;
		log.debug("■■■■■ addDonationItem param : " + donationItemList);
		
		result = donationService.addDonationItemList(donationItemList);
		
		return result;
	}
	
	
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
