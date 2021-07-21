package com.gd.obo.restapi;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.AdoptService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class AdoptRestapi {
	@Autowired AdoptService adoptService;
	
	// staff - plan 작성 시 입양 정보 불러오기
	@GetMapping("/getAdoptApprovalList")
	public List<Map<String, Object>> getAdoptApprovalList(HttpSession session,
														@RequestParam(value = "animalId", required = true) int animalId){
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		log.debug("●●●●▶선택한 animalId-> "+animalId);
		List<Map<String, Object>> check = adoptService.getAdoptList(shelterId, animalId);
		log.debug("●●●●▶checkcheck-> "+check);
		
		return adoptService.getAdoptList(shelterId, animalId);
	}
	
	// staff - 입양 승인
	@PostMapping("/addAdopt")
	public int addAdopt(HttpSession session, int adoptApplyId) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶staffId-> "+staffId);
		log.debug("●●●●▶adoptApplyId-> "+adoptApplyId);
		
		return adoptService.addAdopt(adoptApplyId, staffId);
	}
	
	// staff - 입양 거절
	@PostMapping("/modifyReject")
	public int modifyReject(int adoptApplyId) {
		log.debug("●●●●▶adoptApplyId-> "+adoptApplyId);
		return adoptService.modifyAdoptReject(adoptApplyId);
	}
}
