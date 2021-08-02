// 작성자 : 이윤정

package com.gd.obo.controller;

import java.util.Date;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AdoptService;
import com.gd.obo.service.AnimalService;
import com.gd.obo.service.CareService;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CareController {
	@Autowired CareService careService;
	@Autowired AnimalService animalService;
	@Autowired AdoptService adoptService;
	
	// staff - 케어 info 보기 페이지 이동
	@GetMapping("/staff/getCareInfoInStaff")
	public String getCareInfoInStaff (Model model, @RequestParam(value = "searchWord", required = false) String searchWord,
													@RequestParam(value = "species", required = false) String species,
													@RequestParam(value = "careSorting", required = false) String careSorting,
													@RequestParam(value= "currentPage", defaultValue = "1") int currentPage,
													@RequestParam(value= "rowPerPage", defaultValue = "10") int rowPerPage) {
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
		
		// 디버깅
		log.debug("●●●●▶ searchWord-> "+searchWord);
		log.debug("●●●●▶ species-> "+species);
		log.debug("●●●●▶ careSorting-> "+careSorting);
		log.debug("●●●●▶ currentPage-> "+currentPage);
		log.debug("●●●●▶ rowPerPage-> "+rowPerPage);
		
		List<Map<String, Object>> careInfoList = careService.getCareInfoList(searchWord, species, careSorting, currentPage, rowPerPage);
		log.debug("●●●●▶ careInfoList-> "+careInfoList);
		
		//lastPage 구하기
		int totalRow = 0;
		if(careInfoList.size() != 0) {
			totalRow = Integer.parseInt(careInfoList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow: "+totalRow);
		log.debug("●●●●▶ lastPage: "+lastPage);
		
		
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
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "staff/getCareInfoInStaff";
	}
	
	// staff - 케어 plan 작성 페이지 이동
	@GetMapping("/staff/addCarePlanInStaff")
	public String addCarePlanInStaff (Model model, HttpSession session) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶ shelterId: "+shelterId);
		
		List<Map<String, Object>> adoptApprovalList = adoptService.getAdoptApprovalList(shelterId);
		log.debug("●●●●▶ adoptApprovalList-> "+adoptApprovalList);
		
		model.addAttribute("adoptApprovalList", adoptApprovalList);
		
		return "staff/addCarePlanInStaff";
	}
	
	// staff - 케어 plan 작성 action
	@PostMapping("/staff/addCarePlanInStaff")
	public String addCarePlanInStaff (HttpSession session,
										@RequestParam(value = "animalId") int animalId,
										@RequestParam(value = "memberId") String memberId,
										@RequestParam(value = "careInfoId") String[] careInfoId,
										@RequestParam(value = "careDate") String[] careDate) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶staffId-> "+staffId);
		
		// careDate, careInfoId는 String[] 값으로 들어옴 -> 확인 완료
		log.debug("●●●●▶ animalId-> "+animalId);
		log.debug("●●●●▶ memberId-> "+memberId);
		for(int i=0; i<careInfoId.length; i++) {
			log.debug("●●●●▶ careInfoId["+i+"]-> "+careInfoId[i]);
			log.debug("●●●●▶ careDate["+i+"]-> "+careDate[i]);
		}
		
		int totalCnt = careService.addCarePlan(animalId, memberId, staffId, careInfoId, careDate);
		log.debug("●●●●▶ 성공횟수-> "+totalCnt);
		
		return "redirect:/staff/getCarePlanInStaff";
	}
	
	// staff - 케어 plan 목록 페이지 이동
	@GetMapping("/staff/getCarePlanInStaff")
	public String getCarePlanInStaff (Model model, HttpSession session,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "selectOption", required = false) String selectOption,
										@RequestParam(value= "currentPage", defaultValue = "1") int currentPage,
										@RequestParam(value= "rowPerPage", defaultValue = "10") int rowPerPage) {
		
		//공백일 경우 null처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		//디버깅
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶ shelterId: "+shelterId);
		log.debug("●●●●▶ searchWord: "+searchWord);
		log.debug("●●●●▶ currentPage: "+currentPage);
		log.debug("●●●●▶ rowPerPage: "+rowPerPage);

		List<Map<String, Object>> carePlanDdayList = careService.getCarePlanDdayList(shelterId);
		List<Map<String, Object>> carePlanList = careService.getCarePlanList(shelterId, searchWord, selectOption, currentPage, rowPerPage);
		
		//lastPage 구하기
		int totalRow = 0;
		if(carePlanList.size() != 0) {
			totalRow = Integer.parseInt(carePlanList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow: "+totalRow);
		log.debug("●●●●▶ lastPage: "+lastPage);
		
		model.addAttribute("carePlanDdayList", carePlanDdayList);
		model.addAttribute("carePlanList", carePlanList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectOption", selectOption);
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "staff/getCarePlanInStaff";
	}
	
	// staff - 케어 plan 달력 보기 페이지 이동
	@GetMapping("/staff/getCarePlanCalInStaff")
	public String getCarePlanCalInStaff (Model model) {
		// 해당 년/월을 출력하기 위한 날짜 포맷값
		String pattern = "yyyy-MM";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String date = simpleDateFormat.format(new Date());
		
		model.addAttribute("date", date);	//이번년-월
		
		return "staff/getCarePlanCalInStaff";
	}
	
	// staff - 케어 record 작성 페이지 이동
	@GetMapping("/staff/addCareRecordInStaff")
	public String addCareRecordInStaff (Model model, HttpSession session) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		List<Map<String, Object>> carePlanOne = careService.getCarePlanOneByList(shelterId);
		
		model.addAttribute("carePlanOne", carePlanOne);
		
		return "staff/addCareRecordInStaff";
	}
	
	// staff - 케어 record 작성 페이지에서 record 등록
	@PostMapping("/staff/addCareRecordInStaff")
	public String addCareRecordInStaff (HttpSession session, int carePlanId, String features) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶ carePlanId-> "+carePlanId);
		log.debug("●●●●▶ staffId-> "+staffId);
		log.debug("●●●●▶ features-> "+features);
		
		int cnt = careService.addCareRecord(carePlanId, staffId, features);
		log.debug("●●●●▶ cnt 성공횟수-> "+cnt);
		
		return "redirect:/staff/getCareRecordInStaff";
	}
	
	// staff - 케어 plan 모달창에서 record 등록
	@PostMapping("/staff/getCarePlanInStaff")
	public String getCarePlanInStaff (HttpSession session, int carePlanId, String features) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶ carePlanId-> "+carePlanId);
		log.debug("●●●●▶ staffId-> "+staffId);
		log.debug("●●●●▶ features-> "+features);
		
		int cnt = careService.addCareRecord(carePlanId, staffId, features);
		log.debug("●●●●▶ cnt 성공횟수-> "+cnt);
		
		return "redirect:/staff/getCarePlanInStaff";
	}
	
	// staff - 케어 record 목록 페이지 이동
	@GetMapping("/staff/getCareRecordInStaff")
	public String getCareRecordInStaff (Model model, HttpSession session,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "selectOption", required = false) String selectOption,
										@RequestParam(value= "currentPage", defaultValue = "1") int currentPage,
										@RequestParam(value= "rowPerPage", defaultValue = "10") int rowPerPage) {
		//공백일 경우 null처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		//디버깅
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶ shelterId: "+shelterId);
		log.debug("●●●●▶ searchWord: "+searchWord);
		log.debug("●●●●▶ currentPage: "+currentPage);
		log.debug("●●●●▶ rowPerPage: "+rowPerPage);
		
		List<Map<String, Object>> careRecordList = careService.getCareRecordList(shelterId, searchWord, selectOption, currentPage, rowPerPage);
		
		//lastPage 구하기
		int totalRow = 0;
		if(careRecordList.size() != 0) {
			totalRow = Integer.parseInt(careRecordList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow: "+totalRow);
		log.debug("●●●●▶ lastPage: "+lastPage);
		
		model.addAttribute("careRecordList", careRecordList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectOption", selectOption);
		model.addAttribute("totalRow", totalRow);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "staff/getCareRecordInStaff";
	}
	
		
}
