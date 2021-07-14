// 작성자: 김선유
package com.gd.obo.controller.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.restapi.main.ShelterService;
import com.gd.obo.vo.Shelter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ShelterController {
	@Autowired ShelterService shelterService;
	
	// shelter 리스트
	@GetMapping("/getShelterList")
	public String getShelterlist(Model model) {
		List<Shelter> shelterList = shelterService.getShelterList();
		log.debug("@@@@@ shelterList: "+shelterList);
		return "getShelterList";
		
	}
	
	// shelter 상세보기
	@GetMapping("/getShelterOne")
	public String getShelterOne(Model model,
									@RequestParam(value="shelterId",required= true) int shelterId) {
		Map<String, Object> map = shelterService.getShelterOne(shelterId);
		log.debug("@@@@@ map: "+map);
		model.addAttribute("shelterMap", map.get("shelterMap"));
		return "getShelterOne";
	}
}

