// 작성자 : 이윤정

package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AdoptService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AdoptController {
	@Autowired AdoptService adoptService;
	
	// staff - 입양&케어 페이지 이동
	@GetMapping("/staff/getAdoptAndCareInStaff")
	public String getAdoptAndCareInStaff () {
		return "staff/getAdoptAndCareInStaff";
	}
	
	// staff - 입양 신청 목록 이동
	@GetMapping("/staff/getAdoptApplyInStaff")
	public String getAdoptApplyInStaff (HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		log.debug("●●●●▶searchWord-> "+searchWord);
		
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		List<Map<String, Object>> adoptApplyList = adoptService.getAdoptApplyList(shelterId, searchWord);
		log.debug("●●●●▶ adoptApplyList-> "+adoptApplyList);
		
		model.addAttribute("adoptApplyList", adoptApplyList);
		model.addAttribute("searchWord", searchWord);
		
		return "staff/getAdoptApplyInStaff";
	}
	
	// staff - 입양 승인 목록 이동
	@GetMapping("/staff/getAdoptApprovalInStaff")
	public String getAdoptApplyApprovalInStaff (HttpSession session, Model model,
												@RequestParam(value = "searchWord", required = false) String searchWord,
												@RequestParam(value = "selectOption", required = false) String selectOption) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶selectOption-> "+selectOption);
		
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		List<Map<String, Object>> adoptApprovalList = adoptService.getAdoptApprovalList(shelterId, searchWord, selectOption);
		log.debug("●●●●▶ adoptApprovalList-> "+adoptApprovalList);
		
		model.addAttribute("adoptApprovalList", adoptApprovalList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectOption", selectOption);
		
		return "staff/getAdoptApprovalInStaff";
	}
	
	// staff - 입양 거절 목록 이동
	@GetMapping("/staff/getAdoptRejectInStaff")
	public String getAdoptRejectInStaff (HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		log.debug("●●●●▶searchWord-> "+searchWord);
		
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		List<Map<String, Object>> adoptRejectList = adoptService.getAdoptRejectList(shelterId, searchWord);
		model.addAttribute("adoptRejectList", adoptRejectList);
		model.addAttribute("searchWord", searchWord);
		
		return "staff/getAdoptRejectInStaff";
	}
}
