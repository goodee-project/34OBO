package com.gd.obo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AnimalService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller

public class AnimalController {
	@Autowired
	AnimalService animalService;
	
	// 작성자 : 남민정
	@GetMapping("/staff/addAnimal")
	public String addAnimal() {
		
		return "staff/addAnimal";
	}
	
	@PostMapping("/staff/addAnimal") // 코드 수정 하기
	public String addAnimal(Model model, @RequestParam(value = "animalId", required = false) Integer animalId,
										@RequestParam(value = "animalCategoryId", required = false) Integer animalCategoryId,
										@RequestParam(value = "shelterId", required = false) Integer shelterId,
										@RequestParam(value = "animalName", required = false) String animalName,
										@RequestParam(value = "animalAge", required = false) Integer animalAge,
										@RequestParam(value = "animalSex", required = false) String animalSex,
										@RequestParam(value = "animalWeight", required = false) Integer animalWeight,
										@RequestParam(value = "animalKind", required = false) String animalKind,
										@RequestParam(value = "animalFindPlace", required = false) String animalFindPlace,
										@RequestParam(value = "animalNote", required = false) String animalNote,
										@RequestParam(value = "animalState", required = false) String animalState) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal animalId: " + animalId);
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
		
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> addAnimal map: " + map);
		
		map.put("animalId", animalId);
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
	public String getAnimalList(Model model, @RequestParam(value = "shelterId" , defaultValue = "1") int shelterId,
											@RequestParam(value = "searchWord", required =  false) String searchWord,
											@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage ) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList shelterId: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList searchWord: " + searchWord);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList currentPage: " + currentPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList rowPerPage: " + rowPerPage);

		// name(searchWord)
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		Map<String, Object> map = animalService.getAnimalList(shelterId, searchWord, currentPage, rowPerPage);
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
}
