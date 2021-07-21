//작성자 : 남궁혜영
//수정자 : 손영현
package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.QualificationService;
import com.gd.obo.vo.QualificationApplicationForm;
import com.gd.obo.vo.QualificationType;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Controller
@Slf4j
public class QualificationController {
	@Autowired QualificationService qualificationService;
	
	
	//main 봉사자격신청
	@PostMapping("/membe/addQualificationVolunteerApplication")
	public String addQualificationVolunteerApplication(QualificationApplicationForm qualificationApplicationForm) {
		log.debug("■■■■■■ qualificationApplicationForm param: " + qualificationApplicationForm);
		
		qualificationService.addQualificationVolunteerApplication(qualificationApplicationForm);
		
		return "redirect:/member/addQualificationVolunteerApplication";
	}
	
	//main 내정보 - 봉사자격신청
	@GetMapping("/member/addQualificationVolunteerApplication")
	public String addQualificationVolunteerApplication(Model model, HttpSession session) {
		
		List<Map<String, Object>> qVList = this.qualificationService.getQualificationVolunterrList();
		List<QualificationType> qTList = qualificationService.getQualificationTypeList();
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		
		//자격증명
		log.debug("■■■■■ qVList : " + qVList);
		//자격 증명종류 리스트
		log.debug("■■■■■ qTList : " + qTList);
		
		model.addAttribute("memberId", memberId);
		model.addAttribute("qVList", qVList);
		model.addAttribute("qTList", qTList);
		return "main/addQualificationVolunteerApplication";
	}
	
	//자격승인 내역
	@GetMapping("/manager/getQualificationApprovalList")
	public String getQaList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage,
											@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
											@RequestParam(value="searchWord", required = false) String searchWord) {
		if(searchWord != null && searchWord.equals("")) {
			searchWord=null;
		}	
		Map<String, Object> map = qualificationService.getQualificationApprovalList(currentPage, rowPerPage, searchWord);
		log.debug("======자격 승인 리스트 : "+map.get("list"));
		model.addAttribute("qcaList", map.get("list"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("searchWord", searchWord);
		return "/manager/getQualificationApprovalList";
	}
	
	//자격신청 내역
	@GetMapping("/manager/getQualificationApplicationList")
	public String getQvaList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage,
											@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
											@RequestParam(value="searchWord", required = false) String searchWord) {
		Map<String, Object> map = qualificationService.getQualificationApplicationList(currentPage, rowPerPage, searchWord);
		log.debug("======자격 신청 리스트 : "+map.get("list"));
		log.debug("현재페이지 : " + currentPage);
		model.addAttribute("qvaList", map.get("list"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("searchWord", searchWord);
		return "/manager/getQualificationApplicationList";
	}
	
	//자격신청 승인
	@GetMapping("/manager/approveApplication")
	public String addApproveApplication(@RequestParam(value="managerId", required=true) String managerId, @RequestParam(value="applicationId", required=true) int applicationId) {
		qualificationService.addApproveApplication(managerId, applicationId);
		return "redirect:/manager/getQualificationApplicationList";
	}
	
	//자격신청 거절
	@GetMapping("/manager/rejectApplication")
	public String addRejectApplication(@RequestParam(value="managerId", required=true) String managerId, @RequestParam(value="applicationId", required=true) int applicationId) {
		qualificationService.addRejectApplication(managerId, applicationId);
		return "redirect:/manager/getQualificationApplicationList";
	}
}
