package com.gd.obo.restapi;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.CareService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CareRestapi {
	@Autowired CareService careService;
	
	@GetMapping("/calCarePlanDay")
	public List<Map<String, Object>> calCarePlanDay(HttpSession session,
													@RequestParam(value = "animalId") int animalId,
													@RequestParam(value = "careInfoId") int careInfoId){
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		log.debug("●●●●▶animalId-> "+animalId);
		log.debug("●●●●▶careInfoId-> "+careInfoId);
		
		return careService.getCarePlanDay(shelterId, animalId, careInfoId);
	}
	
	@GetMapping("/careSortingList")
	public List<Map<String, Object>> careSortingList(@RequestParam(value = "animalCategoryId", required = true) int animalCategoryId){
		log.debug("●●●●▶animalCategoryId-> "+animalCategoryId);
		return careService.getCareInfoByCarePlan(animalCategoryId);
	}
	
	/*
	@GetMapping("/careContentList")
	public List<Map<String, Object>> careContentList(@RequestParam(value = "animalCategoryId") int animalCategoryId,
														@RequestParam(value = "careSorting") String careSorting){
		log.debug("●●●●▶animalCategoryId-> "+animalCategoryId);
		log.debug("●●●●▶careSorting-> "+careSorting);
		return careService.getCareInfoByCarePlan(animalCategoryId, careSorting);
	}*/
	
}
