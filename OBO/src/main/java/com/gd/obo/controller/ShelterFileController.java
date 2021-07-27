package com.gd.obo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.service.ShelterFileService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/staff")
public class ShelterFileController {
	@Autowired
	ShelterFileService shelterFileService;
	
	
	@PostMapping("addShelterFile")
	public String addShelterFile(MultipartFile shelterFile, @RequestParam(value = "shelterId", required = true) int shelterId) {
		log.debug("%>%>%>%>%>%>%>%>%> ShelterFileController-> addShelterFile -> MultipartFile shelterFile: " + shelterFile);
		log.debug("%>%>%>%>%>%>%>%>%> ShelterFileController-> addShelterFile shelterId: " + shelterId);
		
		shelterFileService.addShelterFile(shelterFile, shelterId);
		
		// redirect
		return "redirect:/staff/shelterIntro?shelterId="+shelterId;
	}
}
