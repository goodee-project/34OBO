// 작성자 : 이윤정

package com.gd.obo.controller;

import java.util.Date;
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
	
	// staff - 케어 plan 작성 페이지 이동
	@GetMapping("/staff/addCarePlanInStaff")
	public String addCarePlanInStaff (Model model, HttpSession session) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
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
										@RequestParam(value = "selectOption", required = false) String selectOption) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		//공백일 경우 null처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}

		List<Map<String, Object>> carePlanDdayList = careService.getCarePlanDdayList(shelterId);
		List<Map<String, Object>> carePlanList = careService.getCarePlanList(shelterId, searchWord, selectOption);
		
		model.addAttribute("carePlanDdayList", carePlanDdayList);
		model.addAttribute("carePlanList", carePlanList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectOption", selectOption);
		
		return "staff/getCarePlanInStaff";
	}
	
	// staff - 케어 plan 달력 보기 페이지 이동
	@GetMapping("/staff/getCarePlanCalInStaff")
	public String getCarePlanCalInStaff (Model model, HttpSession session) {
		//오늘의 정보
		Map<String, Object> aboutToday = new HashMap<>();
		Calendar today = Calendar.getInstance();
		int thisYear = today.get(Calendar.YEAR);		//이번년도
		int thisMonth = today.get(Calendar.MONTH);		//이번달
		//today.set(Calendar.DAY_OF_WEEK, 1);	//1일로 설정
		today.set(thisYear, thisMonth, 1);
		int thisFirstBlank = today.get(Calendar.DAY_OF_WEEK)-1;		//1일의 요일 이전까지가 블랭크이다.
		int thisEndDate = today.getActualMaximum(Calendar.DATE);	//date상의 최고 일자
		int thisEndBlank = 0;	//초기 블랭크는 0으로
		
		int total = thisFirstBlank+thisEndDate;
		if(total%7 != 0) {
			thisEndBlank = 7-(total%7);
		}
		
		// 해당 년/월을 출력하기 위한 날짜 포맷값
		String pattern = "yyyy-MM";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String date = simpleDateFormat.format(new Date());
		
		aboutToday.put("thisYear", thisYear);
		aboutToday.put("thisMonth", thisMonth+1);
		aboutToday.put("thisFirstBlank", thisFirstBlank);
		aboutToday.put("thisEndDate", thisEndDate);
		aboutToday.put("thisEndBlank", thisEndBlank);
		aboutToday.put("date", date);
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		int setMonth = thisMonth + 1;
		log.debug("●●●●▶setMonth: "+setMonth);
		
		List<Map<String, Object>> carePlanList = careService.getCarePlanInCal(shelterId, thisYear, setMonth);
		log.debug("●●●●▶carePlanList: "+carePlanList);
		
		model.addAttribute("aboutToday", aboutToday);
		model.addAttribute("carePlanList", carePlanList);
		
		/*
		//원하는 날의 정보
		Map<String, Object> theDay = new HashMap<>();
		Calendar setOne = Calendar.getInstance();
		int setYear = 2021;	//내가 찾는 연
		int setMonth = 1;	//내가 찾는 월

		setOne.set(setYear, setMonth-1, 1);
		int firstDate = setOne.get(Calendar.DAY_OF_WEEK);		//내가 찾는 월의 1일의 요일 -> 1:일, 2:월, 3:화, 4:수, 5:목, 6:금, 7:토
		int firstBlank = setOne.get(Calendar.DAY_OF_WEEK)-1;	//1일의 DAY_OF_WEEK-1 값이 달력의 앞의 블랭크이다.
		int endDate = setOne.getActualMaximum(Calendar.DATE);	//월의 마지막 일
		int endBlank = 0;
		
		// endBlank는 firstBlank + endDate를 7로 나눈 나머지 값을 7에서 빼준다. 만약 나머지 0이라면 추가하는 블랭크 없음.
		if((firstBlank+endDate)%7 != 0) {
			endBlank = 7-((firstBlank+endDate)%7);
		}
		
		theDay.put("setYear", setYear);
		theDay.put("setMonth", setMonth);
		theDay.put("targetMonth", setOne.get(Calendar.MONTH));
		theDay.put("firstDate", firstDate);
		theDay.put("firstBlank", firstBlank);
		theDay.put("endDate", endDate);
		theDay.put("endBlank", endBlank);
		model.addAttribute("theDay", theDay);
		*/
		
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
										@RequestParam(value = "selectOption", required = false) String selectOption) {
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId: "+shelterId);
		
		//공백일 경우 null처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		List<Map<String, Object>> careRecordList = careService.getCareRecordList(shelterId, searchWord, selectOption);
		
		model.addAttribute("careRecordList", careRecordList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectOption", selectOption);
		
		return "staff/getCareRecordInStaff";
	}
	
		
}
