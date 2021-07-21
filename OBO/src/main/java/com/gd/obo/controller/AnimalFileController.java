package com.gd.obo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.service.AnimalFileService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/staff")
public class AnimalFileController {
	@Autowired
	AnimalFileService animalFileService;
	

	@PostMapping("/addAnimalFile")
	public String addAnimalFile(MultipartFile animalFile, 
								@RequestParam(value="animalId", required = true) int animalId) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalFileController-> addAnimalFile -> MultipartFile animalFile: " + animalFile);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalFileController-> addAnimalFile animalId: " + animalId);
		
		animalFileService.addAnimalFile(animalFile, animalId);
		
		// redirect
		return "redirect:/getAnimalOne?animalId="+animalId;
	}
	
}
