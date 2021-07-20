// 작성자 : 이윤정

package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.CareService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CareController {
	@Autowired CareService careService;
	@Autowired AnimalService animalService;
	
	// staff - 케어 info 보기 페이지 이동
	@GetMapping("/staff/getCareInfoInStaff")
	public String getCareInfoInStaff (Model model, @RequestParam(value = "searchWord", required = false) String searchWord,
													@RequestParam(value = "species", required = false) String species,
													@RequestParam(value = "careSorting", required = false) String careSorting) {
		log.debug("●●●●▶ searchWord-> "+searchWord);
		log.debug("●●●●▶ species-> "+species);
		log.debug("●●●●▶ careSorting-> "+careSorting);
		
		// searchWord null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		// species, careSorting 미 선택시 null 처리
		if(species != null && species.equals("")) {
			species = null;
		}
		
		if(careSorting != null && careSorting.equals("")) {
			careSorting = null;
		}
		
		List<Map<String, Object>> careInfoList = careService.getCareInfoList(searchWord, species, careSorting);
		log.debug("●●●●▶ careInfoList-> "+careInfoList);
		
		// 동물카테고리 리스트
		List<Map<String,Object>> animalCategoryList = animalService.getAnimalCategoryList();
		
		// care sorting 리스트
		String[] careSortingList = {"예방접종", "정기검진", "중성화"};
		
		model.addAttribute("careInfoList", careInfoList);
		model.addAttribute("animalCategoryList", animalCategoryList);
		model.addAttribute("careSortingList", careSortingList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("species", species);
		model.addAttribute("careSorting", careSorting);
		
		return "staff/getCareInfoInStaff";
	}
	
	// staff - 케어info 검색 or 정렬
	@PostMapping("/staff/getCareInfoInStaff")
	public String getCareInfoInStaff(@RequestParam(value = "searchWord", required = false) String searchWord) {
		log.debug("●●●●▶ careinfo 검색어-> "+searchWord);
		//List<Map<String, Object>> careInfoList = careService.getCareInfoList(searchWord);
		
		return "redirect:/staff/getCareInfoInStaff";
	}
	
	// staff - 케어 plan 작성 페이지 이동
	@GetMapping("/staff/addCarePlanInStaff")
	public String addCarePlanInStaff (Model model) {
		
		return "staff/addCarePlanInStaff";
	}
	
	// staff - 케어 plan 목록 페이지 이동
	@GetMapping("/staff/getCarePlanInStaff")
	public String getCarePlanInStaff (Model model) {
		
		return "staff/getCarePlanInStaff";
	}
	
	// staff - 케어 plan 달력 보기 페이지 이동
	@GetMapping("/staff/getCarePlanCalInStaff")
	public String getCarePlanCalInStaff (Model model) {
		
		return "staff/getCarePlanCalInStaff";
	}
	
	// staff - 케어 record 작성 페이지 이동
	@GetMapping("/staff/addCareRecordInStaff")
	public String addCareRecordInStaff (Model model) {
		
		return "staff/addCareRecordInStaff";
	}
	
	// staff - 케어 record 목록 페이지 이동
	@GetMapping("/staff/getCareRecordInStaff")
	public String getCareRecordInStaff (Model model) {
		
		return "staff/getCareRecordInStaff";
	}
	
		
}
