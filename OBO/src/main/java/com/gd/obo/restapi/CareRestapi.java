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
	
	// staff - care plan 계산
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
	
	// staff - careinfo 불러오기
	@GetMapping("/careSortingList")
	public List<Map<String, Object>> careSortingList(@RequestParam(value = "animalCategoryId", required = true) int animalCategoryId){
		log.debug("●●●●▶animalCategoryId-> "+animalCategoryId);
		return careService.getCareInfoByCarePlan(animalCategoryId);
	}
	
	// staff - 작성된 care plan
	@GetMapping("/getCarePlanAnimalOne")
	public List<Map<String, Object>> getCarePlanAnimalOne(@RequestParam(value = "animalId") int animalId){
		log.debug("●●●●▶animalId-> "+animalId);
		return careService.getCarePlanAnimalOne(animalId);
	}
	
	// staff - 미작성 care plan
	@GetMapping("/getCarePlanAnimalOneNon")
	public List<Map<String, Object>> getCarePlanAnimalOneNon(@RequestParam(value = "animalId") int animalId){
		log.debug("●●●●▶animalId-> "+animalId);
		return careService.getCarePlanAnimalOneNon(animalId);
	}

	// staff - care record 작성 페이지에서 onchange 이벤트 발생시
	@GetMapping("/getCarePlanOne")
	public Map<String, Object> getCarePlanOne(HttpSession session,
													@RequestParam(value = "carePlanId") int carePlanId){
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		log.debug("●●●●▶carePlanId-> "+carePlanId);
		return careService.getCarePlanOne(shelterId, carePlanId);
	}
	
}
