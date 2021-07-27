//작성자: 손영현
package com.gd.obo.controller;

import java.util.Calendar;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.DonationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	@Autowired
	AnimalService animalService;
	@Autowired
	DonationService donationService;
	
	
	@GetMapping({"/home", "/index", "/"})
	public String getHome(Model model) {
		log.debug("■■■■■ 메인 홈페이지로");
		//보호중인 동물들
		Map<String, Object> map = animalService.getAnimalListM(0, null, null, 1, 4);
		log.debug("■■■■■■ getHome 동물 map : "+map);
		
		//한달동안 들어온 후원금
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1; //이번달
		log.debug("■■■■■■ getHome month 이번달 : "+month);
		
		long totalDonation = donationService.getTotalDonationByMonth(month);
		
		
		//보호중인 동물수, 이번달 안락사&입양 동물수 
		Map<String, Object> animalMap = animalService.getAnimalStateCountByMonth(month, 0);
		
		model.addAttribute("protect", animalMap.get("protect"));
		model.addAttribute("adopt", animalMap.get("adopt"));
		model.addAttribute("euthanasia", animalMap.get("euthanasia"));
		model.addAttribute("totalDonation", totalDonation);
		model.addAttribute("animalList", map.get("animalList"));
		return "/main/home";
	}
}