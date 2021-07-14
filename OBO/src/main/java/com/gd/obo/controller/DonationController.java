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
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DonationController {
	@Autowired DonationService donationService;
	
	@GetMapping("/staff/getDonationItemList")
	public String getDonationItemList(Model model, HttpSession session){
		//세션에서 shelterId 가져오기
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		//페이징 추가
		
		List<DonationItemList> itemList = donationService.getDonationItemList(shelterId);
		Map<String, Object> map = new HashMap<>();
		return "getDonationItemList";
	}
	
}
