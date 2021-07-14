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
	
	@GetMapping("getAnimalList")
	public String getAnimalList(Model model, @RequestParam(value = "shelterId" , defaultValue = "1") int shelterId,
											@RequestParam(value = "searchWord", required =  false) String searchWord,
											@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage ) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList param: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList param: " + searchWord);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList param: " + currentPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList param: " + rowPerPage);

		// name(searchWord)
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		Map<String, Object> map = animalService.getAnimalList(shelterId, searchWord, currentPage, rowPerPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalController-> getAnimalList param: " + map);
		model.addAttribute("animalList", map.get("animalList"));
		model.addAttribute("shelterId", shelterId);
		model.addAttribute("animalName", searchWord);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("rowPerPage", rowPerPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		
		return "staff/getAnimalList";
	}
}
