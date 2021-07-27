//작성자: 손영현
package com.gd.obo.restapi;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.DonationService;
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.ItemCategory;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class DonationRestapi {
	@Autowired
	DonationService donationService;
	
	//이번년도의 달별 후원 받은 돈 - 쉘터별, 멤버벨 가능...
	@GetMapping("/getFullDonationTotalByMonth")
	public List<Map<String, Object>> getFullDonationTotalByMonth(@RequestParam(value="year", required = true)int year,
															@RequestParam(value="shelterId", required = false, defaultValue = "0")int shelterId,
															@RequestParam(value = "memberId", required = false)String memberId){
		log.debug("■■■■■ getFullDonationTotalByMonth year : "+ year);
		log.debug("■■■■■ getFullDonationTotalByMonth shelterId : "+ shelterId);
		log.debug("■■■■■ getFullDonationTotalByMonth memberId : "+ memberId);
		
		return donationService.getFullDonationTotalByMonth(year, shelterId, memberId);
	}
	
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
	
	// staff -> 통계 - 이번달 후원액
	@GetMapping("/getDonationMoneyThisMonth")
	public Map<String, Object> getDonationMoneyThisMonth(HttpSession session){
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		
		Map<String, Object> map = donationService.getDonationMoneyThisMonth(shelterId);
		log.debug("●●●●▶이번달 후원액 정보-> "+map);
		
		return donationService.getDonationMoneyThisMonth(shelterId);
	}
	
	// staff - 통계 - 기간별 후원액
	@GetMapping("/getDonationMoneyByPeriod")
	public List<Map<String, Object>> getDonationMoneyByPeriod(HttpSession session,
															@RequestParam(value = "startDate") String startDate,
															@RequestParam(value = "endDate") String endDate){
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		log.debug("●●●●▶startDate-> "+startDate);
		log.debug("●●●●▶endDate-> "+endDate);
		
		return donationService.getDonationMoneyByPeriod(shelterId, startDate, endDate);
	}
	
	// staff - 통계 - 기간별 후원물품
	@GetMapping("/getDonationItemByPeriod")
	public List<Map<String, Object>> getDonationItemByPeriod(HttpSession session,
															@RequestParam(value = "startDate") String startDate,
															@RequestParam(value = "endDate") String endDate,
															@RequestParam(value = "itemCategoryName", required = false) String itemCategoryName){
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		log.debug("●●●●▶startDate-> "+startDate);
		log.debug("●●●●▶endDate-> "+endDate);
		log.debug("●●●●▶itemCategoryName-> "+itemCategoryName);
		
		// itemCategoryName non일 경우 전체카테고리 선택 -> null 처리한다.
		if(itemCategoryName != null && itemCategoryName.equals("non")) {
			itemCategoryName = null;
		}
		
		return donationService.getDonationItemByPeriod(shelterId, startDate, endDate, itemCategoryName);
	}
	
	// staff - ajax로 아이템 카테고리 가져오기
	@GetMapping("/getItemCategoryList")
	public List<ItemCategory> getItemCategoryList(){
		return donationService.getItemCategoryList();
	}

}
