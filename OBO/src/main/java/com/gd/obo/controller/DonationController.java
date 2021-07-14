// 작성자 : 이윤정

package com.gd.obo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gd.obo.service.DonationService;
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DonationController {
	@Autowired DonationService donationService;
	
	
	// staff 후원 페이지
	@GetMapping("/staff/getDonation")
	public String getDonation() {
		return "staff/getDonation";
	}
	
	// staff 물품후원내역
	@GetMapping("/staff/getDonationItemN")
	public String getDonationItemN(Model model, HttpSession session){
		//세션에서 shelterId 가져오기
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		//페이징 추가
		
		List<DonationItemList> itemList = donationService.getDonationItemList(shelterId);
		Map<String, Object> map = new HashMap<>();
		return "staff/getDonationItemN";
	}
	
	// staff 일반후원내역
	@GetMapping("/staff/getDonationMoneyN")
	public String getDonationMoneyList(Model model, HttpSession session){
		//세션에서 shelterId 가져오기
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		//페이징 추가
		
		List<DonationMoneyList> itemList = donationService.getDonationMoneyList(shelterId);
		Map<String, Object> map = new HashMap<>();
		return "staff/getDonationMoneyN";
	}
	
	// staff 정기후원 페이지
	@GetMapping("/staff/getDonationMoneyP")
	public String getDonationMoneyP() {
		return "staff/getDonationMoneyP";
	}
	
}
