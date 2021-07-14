package com.gd.obo.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AnimalService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/staff")
public class AnimalController {
	@Autowired
	AnimalService animalService;
	
	
	// 작성자 : 남민정
	@GetMapping("getAnimalOne")
	public String getAnimalOne(Model model, @RequestParam(value = "animalId", required = false) int animalId) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalOne animalId: " + animalId);
		
		Map<String, Object> map = animalService.getAnimalOne(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalOne map: " + map);
		
		model.addAttribute("animalMap", map.get("animalMap")); // animalId가 들어가기 때문에 따로 쓰지 않음.
		
		return "staff/getAnimalOne";
	}
	
	
	
	
	// 작성자 : 남민정
	@GetMapping("getAnimalList")
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
}
