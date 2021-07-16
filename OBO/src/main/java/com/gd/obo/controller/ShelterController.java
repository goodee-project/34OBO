// 작성자 : 김선유
// 수정자 : 이윤정
// 수정자 : 남궁혜영(2021-07-16)

package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.ShelterService;
import com.gd.obo.service.StaffService;
import com.gd.obo.vo.Address;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@Transactional
public class ShelterController {
	@Autowired ShelterService shelterService;
	@Autowired StaffService staffService;
	
	// shelter 리스트
	@GetMapping("/getShelterList")
	public String getShelterlist(Model model,
									@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
									@RequestParam(value="shelterName", required = false) String shelterName) {
		log.debug("@@@@@ shelterName: "+shelterName);
		if(shelterName != null && shelterName.equals("")) {
			shelterName=null;
		}		
		Map<String, Object> map = shelterService.getShelterList(currentPage, rowPerPage, shelterName);
		model.addAttribute("shelterList",map.get("shelterList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("shelterName", shelterName);
		log.debug("@@@@@ map: "+map);
		
		return "main/getShelterList";
	}
	
	// 관리자용 shelter 리스트
	// 
	@GetMapping("/manager/getManagerShelterList")
	public String getManagerShelterList(Model model,
									@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
									@RequestParam(value="shelterName", required = false) String shelterName) {
		log.debug("===== shelterName: "+shelterName);
		if(shelterName != null && shelterName.equals("")) {
			shelterName=null;
		}		
		Map<String, Object> map = shelterService.getShelterList(currentPage, rowPerPage, shelterName);
		model.addAttribute("shelterList",map.get("shelterList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("shelterName", shelterName);
		log.debug("===== map: "+map);
		
		return "manager/getManagerShelterList";
	}
	
	// shelter 상세보기
	@GetMapping("/getShelterOne")
	public String getShelterOne(Model model,
									@RequestParam(value="shelterId",required= true) int shelterId) {
		Map<String, Object> shelterMap = shelterService.getShelterOne(shelterId);
		log.debug("@@@@@ shelterMap: "+shelterMap);
		model.addAttribute("shelterMap", shelterMap);
		return "main/getShelterOne";
	}
	
	// staff 보호소
	@GetMapping("/staff/getShelter")
	public String getShelter() {
		return "staff/getShelter";
	}
	
	// staff 보호소 소개
	@GetMapping("/staff/shelterIntro")
	public String shelterIntro() {
		return "staff/shelterIntro";
	}
	
	// staff 보호소 내용 수정
	@GetMapping("/staff/modifyShelter")
	public String modifyShelter() {
		return "staff/modifyShelter";
	}
	
	// 보호소 등록
	@GetMapping("/manager/addShelter")
	public String addShelter() {
		return "manager/addShelter";
	}
	// 보호소 등록, 마스터계정 등록 액션
	@PostMapping("/manager/addShelter")
	public String addShelter(Shelter shelter, Address address, Staff staff) {
		int row = shelterService.addShelter(shelter, address);
		staff.setStaffPhone(shelter.getShelterPhone());
		int staffRow = staffService.addMasterStaff(staff);
		log.debug("===== 직원 값 : "+staff);
		log.debug("===== 직원 등록 row : "+staffRow);
		log.debug("===== 보호소 등록 row : "+row);
		return "redirect:/manager/getManagerShelterList";
	}
}

