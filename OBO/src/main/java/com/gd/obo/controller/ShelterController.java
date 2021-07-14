// 작성자: 김선유
package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.MainShelterService;
import com.gd.obo.vo.Shelter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ShelterController {
	@Autowired MainShelterService mainShelterService;
	
	// shelter 리스트
	@GetMapping("/getMainShelterList")
	public String getShelterlist(Model model) {
		List<Shelter> mainShelterList = mainShelterService.getShelterList();
		model.addAttribute("mainShelterList",mainShelterList);
		log.debug("@@@@@ mainShelterList: "+mainShelterList);
		
		return "main/getMainShelterList";
	}
	
	// shelter 상세보기
	@GetMapping("/getMainShelterOne")
	public String getShelterOne(Model model,
									@RequestParam(value="shelterId",required= true) int shelterId) {
		Map<String, Object> map = mainShelterService.getShelterOne(shelterId);
		log.debug("@@@@@ map: "+map);
		model.addAttribute("shelterMap", map.get("shelterMap"));
		return "main/getMainShelterOne";
	}
}

