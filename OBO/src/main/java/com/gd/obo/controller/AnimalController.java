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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.ShelterService;
import com.gd.obo.vo.AnimalForm;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller

public class AnimalController {
	@Autowired AnimalService animalService;
	@Autowired ShelterService shelterService;
	
	
	// 폼
	@GetMapping("/staff/modifyAnimal")
	public String modifyAnimal(Model model, @RequestParam(value = "animalId", required = true) int animalId) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> modifyAnimal animalId: " + animalId);
		
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> modifyAnimal animalCategoryList: " + animalCategoryList);
		
		Map<String, Object> map = animalService.getAnimalOne(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> modifyAnimal map: " + map);
		
		model.addAttribute("animalCategoryList", animalCategoryList);
		model.addAttribute("map", map);
		model.addAttribute("animalMap", map.get("animalMap"));
		model.addAttribute("animalFileList", map.get("animalFileList"));
		
		return "staff/modifyAnimal";
	}
	
	// 액션
	@PostMapping("/staff/modifyAnimal")
	public String modifyAnimal(AnimalForm animalForm) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> modifyAnimal animalForm: " + animalForm);
		
		animalService.modifyAnimal(animalForm);
		
		return "redirect:/staff/getAnimalOne?animalId="+animalForm.getAnimal().getAnimalId();
	}
	
	
	
	// 작성자 : 남민정
	// 폼
	@GetMapping("/staff/addAnimal")
	public String addAnimal(Model model) {
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		
		model.addAttribute("animalCategoryList", animalCategoryList);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalCategoryList: " + animalCategoryList);
		
		return "staff/addAnimal";
	}
	
	// 액션
	@PostMapping("/staff/addAnimal") 
	public String addAnimal(AnimalForm animalForm) { 
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalForm: " + animalForm);
		
		animalService.addAnimal(animalForm);								
		
		return "redirect:/staff/getAnimalOne?animalId="+animalForm.getAnimal().getAnimalId();
	}
	
	
	// 작성자 : 남민정
	@GetMapping("/staff/getAnimalOne")
	public String getAnimalOne(Model model, @RequestParam(value = "animalId", required = false) int animalId) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalOne animalId: " + animalId);
		
		Map<String, Object> map = animalService.getAnimalOne(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalOne map: " + map);
		
		model.addAttribute("animalMap", map.get("animalMap")); // animalId가 들어가기 때문에 따로 쓰지 않음.
		
		return "staff/getAnimalOne";
	}
	
	
	
	
	// 작성자 : 남민정
	@GetMapping("/staff/getAnimalList")
	public String getAnimalList(Model model, HttpSession session,
											@RequestParam(value = "searchWord", required =  false) String searchWord,
											@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage ) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList shelterId: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList searchWord: " + searchWord);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList currentPage: " + currentPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList rowPerPage: " + rowPerPage);

		// name(searchWord)
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		//회원에서 종류 쓰기 위해서 추가함. 직원은 종 검색 기능 없으므로 널 값을 넣어줬음.
		String species = null;
		Map<String, Object> map = animalService.getAnimalList(shelterId, searchWord, species, currentPage, rowPerPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList map: " + map);
		model.addAttribute("animalList", map.get("animalList"));
		model.addAttribute("shelterId", shelterId);
		model.addAttribute("animalName", searchWord);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("rowPerPage", rowPerPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		
		return "staff/getAnimalList";
	}
	
	// staff -> 동물 페이지 이동
	@GetMapping("/staff/getAnimalInStaff")
	public String getAnimalInStaff() {
		return "staff/getAnimalInStaff";
	}
	
	//회원용 동물 리스트
	@GetMapping("/getAnimalList")
	public String getAnimalListM(Model model, @RequestParam(value = "shelterId", defaultValue = "0") int shelterId,
											@RequestParam(value = "searchWord", required =  false) String searchWord,
											@RequestParam(value = "species", required =  false) String species,
											@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "9") int rowPerPage ) {
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		if(species != null && species.equals("")) {
			species = null;
		}
		Map<String, Object> map = animalService.getAnimalListM(shelterId, searchWord, species, currentPage, rowPerPage);
		List<Map<String,Object>> categoryList = animalService.getAnimalCategoryList();
		List<Shelter> shelterList = shelterService.getShelterListByDonation();
		log.debug("===== 동물 리스트 map: " + map);
		log.debug("===== 동물 카테고리 리스트 categoryList: " + categoryList);
		model.addAttribute("animalList", map.get("animalList"));
		model.addAttribute("shelterId", shelterId);
		model.addAttribute("animalName", searchWord);
		model.addAttribute("species", species);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("rowPerPage", rowPerPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("shelterList", shelterList);
		
		return "main/getAnimalList";
		
	}
	
	//회원용 동물 상세보기
	@GetMapping("/getAnimalOne")
	public String getAnimalOneM(Model model, @RequestParam(value = "animalId", required = true) int animalId,
											@RequestParam(value = "searchWord", required =  false) String searchWord,
											@RequestParam(value = "species", required =  false) String species,
											@RequestParam(value = "shelterId", required = false) int shelterId,
											@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "9") int rowPerPage) {
		log.debug("===== 동물 상세보기 animalId: " + animalId);
		
		Map<String, Object> map = animalService.getAnimalOne(animalId);
		log.debug("===== 동물 상세보기: " + map);
		
		model.addAttribute("animalMap", map.get("animalMap"));
		model.addAttribute("expectedDay", map.get("expectedDay"));
		model.addAttribute("shelterId", shelterId);
		
		return "main/getAnimalOne";
	}
	
	//회원 동물 좋아요
	@GetMapping("/addAnimalLike")
	public String addAnimalLike(HttpSession session, @RequestParam(value = "animalId", required = true) int animalId,
												@RequestParam(value = "searchWord", required =  false) String searchWord,
												@RequestParam(value = "species", required =  false) String species,
												@RequestParam(value = "shelterId", required = false) int shelterId,
												@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
												@RequestParam(value = "rowPerPage", defaultValue = "9") int rowPerPage) {
		String memberId = ((Member)(session.getAttribute("loginMember"))).getMemberId();
		animalService.addAnimalLike(memberId, animalId);
		return "redirect:/getAnimalOne?animalId="+animalId+"&currentPage="+currentPage+"&searchWord="+searchWord+"&species="+species+"&shelterId="+shelterId;
	}
}
