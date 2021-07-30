// 작성자 : 이윤정

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

import com.gd.obo.service.AdoptService;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdoptController {
	@Autowired AdoptService adoptService;
	
	//내정보 - 입양&케어 페이지
	@GetMapping("/member/getMemberAdoptAndCare")
	public String getMemberAdoptAndCare(HttpSession session, Model model) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		
		model.addAttribute("adoptList", adoptService.getAdoptListByMemberId(memberId));
		return "main/getMemberAdoptAndCare";
	}
	
	// staff - 입양&케어 페이지 이동
	@GetMapping("/staff/getAdoptAndCareInStaff")
	public String getAdoptAndCareInStaff () {
		return "staff/getAdoptAndCareInStaff";
	}
	
	// staff - 입양 신청 목록 이동
	@GetMapping("/staff/getAdoptApplyInStaff")
	public String getAdoptApplyInStaff (HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "selectOption", required = false) String selectOption,
										@RequestParam(value= "currentPage", defaultValue = "1") int currentPage,
										@RequestParam(value= "rowPerPage", defaultValue = "10") int rowPerPage) {
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶ shelterId-> "+shelterId);
		log.debug("●●●●▶ searchWord-> "+searchWord);
		log.debug("●●●●▶ selectOption-> "+selectOption);
		log.debug("●●●●▶ currentPage-> "+currentPage);
		
		List<Map<String, Object>> adoptApplyList = adoptService.getAdoptApplyList(shelterId, searchWord, selectOption, currentPage, rowPerPage);
		log.debug("●●●●▶ adoptApplyList-> "+adoptApplyList);
		
		//lastPage 구하기
		int totalRow = 0;
		if(adoptApplyList.size() != 0) {
			totalRow = Integer.parseInt(adoptApplyList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow-> "+totalRow);
		log.debug("●●●●▶ lastPage-> "+lastPage);		
		
		model.addAttribute("adoptApplyList", adoptApplyList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("lastPage", lastPage);
		
		return "staff/getAdoptApplyInStaff";
	}
	
	// staff - 입양 승인 목록 이동
	@GetMapping("/staff/getAdoptApprovalInStaff")
	public String getAdoptApplyApprovalInStaff (HttpSession session, Model model,
												@RequestParam(value = "searchWord", required = false) String searchWord,
												@RequestParam(value = "selectOption", required = false) String selectOption,
												@RequestParam(value= "currentPage", defaultValue = "1") int currentPage,
												@RequestParam(value= "rowPerPage", defaultValue = "10") int rowPerPage) {
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶selectOption-> "+selectOption);
		log.debug("●●●●▶currentPage-> "+currentPage);
		
		List<Map<String, Object>> adoptApprovalList = adoptService.getAdoptApprovalList(shelterId, searchWord, selectOption, currentPage, rowPerPage);
		log.debug("●●●●▶ adoptApprovalList-> "+adoptApprovalList);
		
		//lastPage 구하기
		int totalRow = 0;
		if(adoptApprovalList.size() != 0) {
			totalRow = Integer.parseInt(adoptApprovalList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow-> "+totalRow);
		log.debug("●●●●▶ lastPage-> "+lastPage);		
		
		model.addAttribute("adoptApprovalList", adoptApprovalList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectOption", selectOption);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("totalRow", totalRow);
		
		return "staff/getAdoptApprovalInStaff";
	}
	
	// staff - 입양 거절 목록 이동
	@GetMapping("/staff/getAdoptRejectInStaff")
	public String getAdoptRejectInStaff (HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value= "currentPage", defaultValue = "1") int currentPage,
										@RequestParam(value= "rowPerPage", defaultValue = "10") int rowPerPage) {
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶currentPage-> "+currentPage);
		
		List<Map<String, Object>> adoptRejectList = adoptService.getAdoptRejectList(shelterId, searchWord, currentPage, rowPerPage);
		
		//lastPage 구하기
		int totalRow = 0;
		if(adoptRejectList.size() != 0) {
			totalRow = Integer.parseInt(adoptRejectList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow-> "+totalRow);
		log.debug("●●●●▶ lastPage-> "+lastPage);		
		
		model.addAttribute("adoptRejectList", adoptRejectList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("totalRow", totalRow);
		
		return "staff/getAdoptRejectInStaff";
	}
	
	//회원 입양 폼으로
	@GetMapping("/addAdoptForm")
	public String addAdoptForm (Model model, @RequestParam(value="animalId", required=true) int animalId) {
		model.addAttribute("animalId", animalId);
		return "main/addAdoptForm";
	}
	
	//회원 입양 폼으로
	@PostMapping("/addAdoptForm")
	public String addAdoptForm (HttpSession session, @RequestParam(value="animalId", required=true) int animalId,
			@RequestParam(value="q1", required=true) String q1,
			@RequestParam(value="q3", required=true) String q3, @RequestParam(value="q8", required=true) String q8,
			@RequestParam(value="q14", required=true) String q14, @RequestParam(value="q16", required=true) String q16,
			@RequestParam(value="q17", required=true) String q17, @RequestParam(value="q18", required=true) String q18,
			@RequestParam(value="q19", required=true) String q19, @RequestParam(value="q20", required=true) String q20,
			@RequestParam(value="q21", required=true) String q21, @RequestParam(value="q23", required=true) String q23,
			@RequestParam(value="q24", required=true) String q24, @RequestParam(value="q25", required=true) String q25,
			@RequestParam(value="q27", required=true) String q27, @RequestParam(value="q29", required=true) String q29,
			@RequestParam(value="q34", required=true) String q34, @RequestParam(value="q35", required=true) String q35
			) {
		log.debug("====== q1"+q1);
		log.debug("====== animalId"+animalId);
		String memberId = ((Member)(session.getAttribute("loginMember"))).getMemberId();
		adoptService.addAdoptForm(memberId, animalId, q1, q3, q8, q14, q16, q17, q18, q19, q20, q21, q23, q24, q25, q27, q29, q34, q35);
		return "redirect:/getAnimalList";
	}
}
