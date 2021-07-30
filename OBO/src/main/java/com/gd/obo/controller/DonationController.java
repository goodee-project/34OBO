// 작성자 : 이윤정 
// 수정자: 손영현(2021-07-17) ; main 후원페이지

package com.gd.obo.controller;

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
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.ItemCategory;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DonationController {
	@Autowired DonationService donationService;
	@Autowired ShelterService shelterService;
	
	//전체 후원페이지
	@GetMapping("/getDonation")
	public String getDonation() {
		return "main/getDonation";
	}
	
	//물품후원 폼으로
	@GetMapping("/member/addDonationItem")
	public String addDonationItem(HttpSession session, Model model) {
		
		model.addAttribute("itemCategoryList", donationService.getItemCategoryList());
		model.addAttribute("shelterList", shelterService.getShelterListByDonation());
		model.addAttribute("memberId", ((Member)session.getAttribute("loginMember")).getMemberId());
		return "main/addDonationItem";
	}
	
	//정기후원 끊기
	@GetMapping("/member/endPeriodicallyDonation")
	public String endPeriodicallyDonation(@RequestParam(value = "periodicallyDonationId", required = true)int periodicallyDonationId) {
		donationService.modifyPeriodicallyDonationListByKakaoPayStop(periodicallyDonationId);
		return "redirect:/member/getMemberDonation";
	}
	
	//내정보 후원내역보기 -> 아직 수정필요
	@GetMapping("/member/getMemberDonation")
	public String getMemberDonation() {
		/*
		//회원의 총 후원금액
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		int totalDonation = donationService.getTotalMoneyByMemberId(memberId);
		log.debug("■■■■■ getMemberDonation totalDonation : "+ totalDonation);
		
		model.addAttribute("totalDonation", totalDonation);
		*/
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
	@GetMapping("/staff/getDonationInStaff")
	public String getDonationInStaff() {
		return "staff/getDonationInStaff";
	}
	
	// staff 물품후원내역
	@GetMapping("/staff/getDonationItemN")
	public String getDonationItemN(Model model, HttpSession session,
									@RequestParam(value="searchWord", required = false) String searchWord,
									@RequestParam(value="searchSelect", required = false) String searchSelect,
									@RequestParam(value="itemCategoryName", required = false) String itemCategoryName,
									@RequestParam(value="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue = "10") int rowPerPage){
		//searchWord 공백 -> null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		//searchSelect 미선택 -> null 처리
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect = null;
			log.debug("●●●●▶ null 처리 후 searchSelect: "+searchSelect);
		}
		
		//itemCategoryName 미선택 -> null 처리
		if(itemCategoryName != null && itemCategoryName.equals("")) {
			itemCategoryName = null;
			log.debug("●●●●▶ null 처리 후itemCategoryName: "+itemCategoryName);
		}
		
		//세션에서 shelterId 가져오기
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
				
		//디버깅
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord: "+searchWord);
		log.debug("●●●●▶searchSelect: "+searchSelect);
		log.debug("●●●●▶itemCategoryName: "+itemCategoryName);
		log.debug("●●●●▶currentPage: "+currentPage);
		log.debug("●●●●▶rowPerPage: "+rowPerPage);
		
		//service 실행
		Map<String, Object> map = donationService.getDonationItemList(shelterId, searchWord, searchSelect, itemCategoryName, currentPage, rowPerPage);
		
		model.addAttribute("donationItemList", map.get("donationItemList"));
		model.addAttribute("itemCategoryList", map.get("itemCategoryList"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalRow", map.get("totalRow"));
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		model.addAttribute("itemCategoryName", itemCategoryName);
		model.addAttribute("currentPage", currentPage);
		
		return "staff/getDonationItemN";
	}
	
	// staff 일반후원내역
	@GetMapping("/staff/getDonationMoneyN")
	public String getDonationMoneyN(Model model, HttpSession session,
									@RequestParam(value="searchWord", required = false) String searchWord,
									@RequestParam(value="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue = "10") int rowPerPage){
		
		//searchWord 공백 -> null로 수정
		if(searchWord != null &&searchWord.equals("")) {
			searchWord = null;
		}
			
		//디버깅
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord: "+searchWord);
		log.debug("●●●●▶currentPage: "+currentPage);
		log.debug("●●●●▶rowPerPage: "+rowPerPage);
		
		List<Map<String, Object>> moneyNList = donationService.getDonationMoneyNList(shelterId, searchWord, currentPage, rowPerPage);

		//lastPage 구하기
		int totalRow = 0;
		if(moneyNList.size() != 0) {
			totalRow = Integer.parseInt(moneyNList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow: "+totalRow);
		log.debug("●●●●▶ lastPage: "+lastPage);
		
		model.addAttribute("moneyNList", moneyNList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "staff/getDonationMoneyN";
	}
	
	// staff 정기후원 페이지
	@GetMapping("/staff/getDonationMoneyP")
	public String getDonationMoneyP(Model model, HttpSession session,
									@RequestParam(value="searchWord", required = false) String searchWord,
									@RequestParam(value="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue = "10") int rowPerPage) {
		//searchWord 공백 -> null로 수정
		if(searchWord != null &&searchWord.equals("")) {
			searchWord = null;
		}
			
		//디버깅
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord: "+searchWord);
		log.debug("●●●●▶currentPage: "+currentPage);
		log.debug("●●●●▶rowPerPage: "+rowPerPage);
		
		List<Map<String, Object>> moneyPList = donationService.getDonationMoneyPList(shelterId, searchWord, currentPage, rowPerPage);
		
		//lastPage 구하기
		int totalRow = 0;
		if(moneyPList.size() != 0) {
			totalRow = Integer.parseInt(moneyPList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow: "+totalRow);
		log.debug("●●●●▶ lastPage: "+lastPage);
		
		model.addAttribute("moneyPList", moneyPList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "staff/getDonationMoneyP";
	}
	
	// staff 후원 - 통계->홈 페이지 이동
	@GetMapping("/staff/getDonationStats")
	public String getDonationStats(Model model, HttpSession session) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		List<Map<String, Object>> donationItemLast = donationService.getDonationItemLast(shelterId);
		model.addAttribute("donationItemLast", donationItemLast);
		
		return "staff/getDonationStats";
	}
	
	// staff 후원 - 통계->물품 페이지 이동
	@GetMapping("/staff/getDonationStatsItem")
	public String getDonationStatsItem(Model model, HttpSession session) {
		return "staff/getDonationStatsItem";
	}
	
	// staff 후원 - 통계->금액 페이지 이동
	@GetMapping("/staff/getDonationStatsMoney")
	public String getDonationStatsMoney(Model model, HttpSession session) {
		return "staff/getDonationStatsMoney";
	}
	
}
