// 작성자 : 김선유
// 수정자 : 이윤정
// 수정자 : 남궁혜영(2021-07-16)
// 수정자 : 남궁혜영(2021-07-18)

package com.gd.obo.controller;

import java.util.Calendar;
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

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.ShelterService;
import com.gd.obo.service.StaffService;
import com.gd.obo.vo.Address;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.ShelterForm;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@Transactional
public class ShelterController {
	@Autowired ShelterService shelterService;
	@Autowired StaffService staffService;
	@Autowired AnimalService animalService;
	
	
	
	// shelter 리스트
	@GetMapping("/getShelterList")
	public String getShelterlist(Model model,
									@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
									@RequestParam(value="shelterName", required = false) String shelterName,
									@RequestParam(value="searchAddress", required = false) String searchAddress) {
		log.debug("@@@@@ shelterName: "+shelterName);
		if(shelterName != null && shelterName.equals("")) {
			shelterName=null;
		}	
		if(searchAddress != null && searchAddress.equals("")) {
			searchAddress=null;
		}
		Map<String, Object> map = shelterService.getShelterList(currentPage, rowPerPage, shelterName, searchAddress);
		model.addAttribute("shelterList",map.get("shelterList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("searchAddress", searchAddress);
		model.addAttribute("shelterName", shelterName);
		log.debug("@@@@@ map: "+map);
		
		return "main/getShelterList";
	}
	
	// 관리자용 shelter 리스트
	// 주소 검색 추가.
	@GetMapping("/manager/getManagerShelterList")
	public String getManagerShelterList(Model model,
									@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
									@RequestParam(value="shelterName", required = false) String shelterName,
									@RequestParam(value="searchAddress", required = false) String searchAddress) {
		log.debug("===== shelterName: "+shelterName);
		if(shelterName != null && shelterName.equals("")) {
			shelterName=null;
		}
		if(searchAddress != null && searchAddress.equals("")) {
			searchAddress=null;
		}
		Map<String, Object> map = shelterService.getShelterList(currentPage, rowPerPage, shelterName, searchAddress);
		model.addAttribute("shelterList",map.get("shelterList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("searchAddress", searchAddress);
		model.addAttribute("shelterName", shelterName);
		log.debug("===== map: "+map);
		
		return "manager/getManagerShelterList";
	}
	
	// shelter 상세보기
	@GetMapping("/getShelterOne")
	public String getShelterOne(Model model,
									@RequestParam(value="shelterId",required= true) int shelterId) {
		Map<String, Object> map = shelterService.getShelterOne(shelterId);
		log.debug("@@@@@ map: "+map);
		
		
		String x = (String)map.get("x");
		String y = (String)map.get("y");
		
		if(x != null) {
			model.addAttribute("x", x);
			model.addAttribute("y", y);
		}
		
		//보호중인 동물수, 이번달 안락사&입양 동물수 
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1; //이번달
		log.debug("■■■■■■ getHome month 이번달 : "+month);
		
		Map<String, Object> animalMap = animalService.getAnimalStateCountByMonth(month, shelterId);
		
		//이미지 리스트
		List<String> imgList = shelterService.getShelterFileListByShelterId(shelterId);
		if(!imgList.isEmpty()) {
			model.addAttribute("imgList", imgList);
		}
		
		model.addAttribute("protect", animalMap.get("protect"));
		model.addAttribute("adopt", animalMap.get("adopt"));
		model.addAttribute("euthanasia", animalMap.get("euthanasia"));
		
		//shelter에서 보호중인 동물 리스트
		model.addAttribute("animalList", animalService.getAnimalListM(shelterId, null, null, 1, 4).get("animalList"));
		model.addAttribute("shelterMap", map.get("shelterMap"));
		return "main/getShelterOne";
	}
	
	// staff 보호소
	@GetMapping("/staff/getShelterInStaff")
	public String getShelterInStaff() {
		return "staff/getShelterInStaff";
	}
	
	// staff 보호소 소개
	@GetMapping("/staff/shelterIntro")
	public String shelterIntro() {
		return "staff/shelterIntro";
	}
	
	// staff 보호소 내용 수정
	// 폼
	@GetMapping("/staff/modifyShelter")
	public String modifyShelter(Model model, HttpSession session) {
		log.debug("%>%>%>%>%>%>%>%>%> ShelterController-> modifyShelter session: " + session);
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("%>%>%>%>%>%>%>%>%> ShelterController-> modifyShelter shelterId: " + shelterId);
		
		Map<String, Object> map = shelterService.getShelterOne(shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> ShelterController-> modifyShelter map: " + map);
		
		model.addAttribute("shelterId", shelterId);
		model.addAttribute("map", map);
		model.addAttribute("shelterMap", map.get("shelterMap"));
		model.addAttribute("shelterFileList", map.get("shelterFileList"));
		
		return "staff/modifyShelter";
	}
	
	// 액션
	@PostMapping("/staff/modifyShelter")
	public String modifyShelter(ShelterForm shelterForm, HttpSession session) {
		log.debug("%>%>%>%>%>%>%>%>%> ShelterController-> modifyShelter shelterForm: " + shelterForm);
		
		shelterService.modifyShelter(shelterForm);
		// 쉘터 아이디 넣기
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		
		return "redirect:/staff/shelterIntro?shelterId="+shelterForm.getShelter().getShelterId();
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

