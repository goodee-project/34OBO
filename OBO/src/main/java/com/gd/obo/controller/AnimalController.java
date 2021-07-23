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
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller

public class AnimalController {
	@Autowired AnimalService animalService;
	@Autowired ShelterService shelterService;
	
	// 작성자 : 남민정
	@GetMapping("/staff/addAnimal")
	public String addAnimal(Model model) {
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalCategoryList: " + animalCategoryList);
		
		model.addAttribute("animalCategoryList", animalCategoryList);
		
		return "staff/addAnimal";
	}
	
	@PostMapping("/staff/addAnimal") // 코드 수정 하기  animalIntroduce
	public String addAnimal(Model model, 
										@RequestParam(value = "animalCategoryId", required = false) Integer animalCategoryId,
										@RequestParam(value = "shelterId", required = false) Integer shelterId,
										@RequestParam(value = "animalName", required = false) String animalName,
										@RequestParam(value = "animalAge", required = false) Integer animalAge,
										@RequestParam(value = "animalSex", required = false) String animalSex,
										@RequestParam(value = "animalWeight", required = false) Integer animalWeight,
										@RequestParam(value = "animalKind", required = false) String animalKind,
										@RequestParam(value = "animalFindPlace", required = false) String animalFindPlace,
										@RequestParam(value = "animalNote", required = false) String animalNote,
										@RequestParam(value = "animalState", required = false) String animalState,
										@RequestParam(value = "animalIntroduce", required = false) String animalIntroduce) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalCategoryId: " + animalCategoryId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal shelterId: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalName: " + animalName);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalAge: " + animalAge);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalSex: " + animalSex);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalWeight: " + animalWeight);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalKind: " + animalKind);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalFindPlace: " + animalFindPlace);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalNote: " + animalNote);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalState: " + animalState);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalIntroduce: " + animalIntroduce);
		
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal map: " + map);
		
		map.put("animalCategoryId", animalCategoryId);
		map.put("shelterId", shelterId);
		map.put("animalName", animalName);
		map.put("animalAge", animalAge);
		map.put("animalSex", animalSex);
		map.put("animalWeight", animalWeight);
		map.put("animalKind", animalKind);
		map.put("animalFindPlace", animalFindPlace);
		map.put("animalNote", animalNote);
		map.put("animalState", animalState);
		map.put("animalIntroduce", animalIntroduce);
		
		int addAnimal = animalService.addAnimal(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal addAnimal: " + addAnimal);
		
		model.addAttribute("map", map);
		model.addAttribute("addAnimal", addAnimal);
		
		return "redirect:/staff/getAnimalList";
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
	
	@GetMapping("/getAnimalList")
	public String getAnimalListM(Model model, @RequestParam(value = "shelterId", defaultValue = "0") int shelterId,
											@RequestParam(value = "searchWord", required =  false) String searchWord,
											@RequestParam(value = "species", required =  false) String species,
											@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage ) {
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		if(species != null && species.equals("")) {
			species = null;
		}
		Map<String, Object> map = animalService.getAnimalList(shelterId, searchWord, species, currentPage, rowPerPage);
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
}
