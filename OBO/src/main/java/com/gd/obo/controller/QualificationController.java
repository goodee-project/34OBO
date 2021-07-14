//작성자 : 남궁혜영
package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.QualificationService;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Controller
@Slf4j
public class QualificationController {
	@Autowired QualificationService qualificationService;
	
	//자격승인 내역
	@GetMapping("/manager/getQualificationApprovalList")
	public String getQaList(Model model) {
		List<Map<String, Object>> qcaList = qualificationService.getQualificationApprovalList();
		log.debug("======자격 승인 리스트 : "+qcaList);
		model.addAttribute("qcaList", qcaList);
		return "/manager/getQualificationApprovalList";
	}
	
	//자격신청 내역
	@GetMapping("/manager/getQualificationApplicationList")
	public String getQvaList(Model model) {
		List<Map<String, Object>> qvaList = qualificationService.getQualificationApplicationList();
		log.debug("======자격 신청 리스트 : "+qvaList);
		model.addAttribute("qvaList", qvaList);
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
