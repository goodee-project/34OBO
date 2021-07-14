// 작성자: 김선유
package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.ShelterService;
import com.gd.obo.vo.Shelter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ShelterController {
	@Autowired ShelterService shelterService;
	
	// shelter 리스트
	@GetMapping("/getShelterList")
	public String getShelterlist(Model model,
									@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
									@RequestParam(value="shelterName", required = false) String shelterName) {
		log.debug("@@@@@ shelterName: "+shelterName);
		if(shelterName != null && shelterName.equals("")) {
			shelterName=null;
		}		
		Map<String, Object> map = shelterService.getShelterList(currentPage, rowPerPage, shelterName);
		model.addAttribute("shelterList",map.get("shelterList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("shelterName", shelterName);
		log.debug("@@@@@ map: "+map);
		
		return "main/getShelterList";
	}
	
	// shelter 상세보기
	@GetMapping("/getShelterOne")
	public String getShelterOne(Model model,
									@RequestParam(value="shelterId",required= true) int shelterId) {
		Map<String, Object> shelterMap = shelterService.getShelterOne(shelterId);
		log.debug("@@@@@ shelterMap: "+shelterMap);
		model.addAttribute("shelterMap", shelterMap);
		return "main/getShelterOne";
	}
}

