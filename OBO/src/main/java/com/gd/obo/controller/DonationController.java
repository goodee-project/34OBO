// 작성자 : 이윤정 
// 수정자: 손영현(2021-07-17) ; main 후원페이지

package com.gd.obo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.DonationService;
import com.gd.obo.service.ShelterService;
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DonationController {
	@Autowired DonationService donationService;
	@Autowired ShelterService shelterService;
	
	//정기후원 끊기
	@GetMapping("/member/endPeriodicallyDonation")
	public String endPeriodicallyDonation(@RequestParam(value = "periodicallyDonationId", required = true)int periodicallyDonationId) {
		donationService.modifyPeriodicallyDonationListByKakaoPayStop(periodicallyDonationId);
		return "redirect:/member/getMemberDonation";
	}
	
	//내정보 후원내역보기 -> 아직 정기후원목록만 만들었습니다... 수정필요!
	@GetMapping("/member/getMemberDonation")
	public String getMemberDonation(HttpSession session, Model model) {
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		
		model.addAttribute("list", donationService.getPeriodicallyDonationByMemberId(memberId));
		return "main/getMemberDonation";
	}
	
	//main 정기후원 첫번째(등록용) 결제성공
	@GetMapping("/member/successPeriodicallyDonation")
	public String successPeriodicallyDonation(Model model,
												@RequestParam(value="pg_token", required = true)String pg_token) {
		log.debug("■■■■■■■ 결제를 위한 토큰 token : " + pg_token);
		//결제승인
		Map<String, Object> map = donationService.confirmKakoPay(pg_token, "TCSUBSCRIP");
		//데이터 베이스에 결과 남기기
		donationService.addPeriodicallyDonation();
		
		//결제정보 창으로 넘겨줌
		model.addAttribute("map" ,map);
		return "main/successDonation";
	}
	
	//main 정기후원 첫번째(등록용) 결제준비
	@PostMapping("/member/addPeriodicallyDonation")
	public String addPeriodicallyDonation(DonationMoneyList donationMoneyList,
												@RequestParam(value="device")String device) {
		log.debug("■■■■■■■ addDonation param :" + donationMoneyList);
		log.debug("■■■■■■■ device param :" + device);
		//결제 준비
		Map<String, Object> map = donationService.readyKakaoPay(donationMoneyList, "http://localhost/obo/member/successPeriodicallyDonation", "정기후원", "TCSUBSCRIP");
		
		//웹이였을 경우의 url , 앱이나 모바일 웹은 다르다.
		if(device.equals("pc")) {//pc일 경우
			return "redirect:" + map.get("next_redirect_pc_url");
		} else {//모바일일 경우
			return "redirect:" + map.get("next_redirect_mobile_url");
		}
		
	}
	
	
	//main 정기후원 폼으로
	@GetMapping("/member/addPeriodicallyDonation")
	public String addPeriodicallyDonation(HttpSession session, Model model) {
		
		model.addAttribute("shelterList", shelterService.getShelterListByDonation());
		model.addAttribute("memberId", ((Member)session.getAttribute("loginMember")).getMemberId());
		return "main/addPeriodicallyDonation";
	}
	
	//main 일반 후원 결제 성공
	@GetMapping("/member/successDonation")
	public String successDonation(Model model,
									@RequestParam(value="pg_token", required = true)String pg_token) {
		log.debug("■■■■■■■ 결제를 위한 토큰 token : " + pg_token);
		//결제승인
		Map<String, Object> map = donationService.confirmKakoPay(pg_token, "TC0ONETIME");
		//데이터 베이스에 결과 남기기
		donationService.addDonationMoneyList();
		
		//결제정보 창으로 넘겨줌
		model.addAttribute("map" ,map);
		return "main/successDonation";
	}
	
	
	//main 일반 후원 결제 준비
	@PostMapping("/member/addDonation")
	public String addDonation(DonationMoneyList donationMoneyList,
								@RequestParam(value="device")String device) {
		log.debug("■■■■■■■ addDonation param :" + donationMoneyList);
		log.debug("■■■■■■■ device param :" + device);
		//결제 준비
		Map<String, Object> map = donationService.readyKakaoPay(donationMoneyList, "http://localhost/obo/member/successDonation", "일반후원", "TC0ONETIME");
		
		//웹이였을 경우의 url , 앱이나 모바일 웹은 다르다.
		if(device.equals("pc")) {//pc일 경우
			return "redirect:" + map.get("next_redirect_pc_url");
		} else {//모바일일 경우
			return "redirect:" + map.get("next_redirect_mobile_url");
		}
		
	}
	
	//main 일반 후원 폼으로
	@GetMapping("/member/addDonation")
	public String addDonation(HttpSession session, Model model) {
		
		model.addAttribute("shelterList", shelterService.getShelterListByDonation());
		model.addAttribute("memberId", ((Member)session.getAttribute("loginMember")).getMemberId());
		return "main/addDonation";
	}
	
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
