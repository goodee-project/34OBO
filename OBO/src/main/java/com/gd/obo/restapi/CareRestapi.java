package com.gd.obo.restapi;

import java.util.Calendar;
import java.util.HashMap;
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
	
	// staff - care plan calendar
	@GetMapping("/getCalendar")
	public Map<String, Object> getCalendar(int year, int month){
		log.debug("●●●●▶원하는 year-> "+year);
		log.debug("●●●●▶원하는 month-> "+month);
		//원하는 날의 정보
		Map<String, Object> theDay = new HashMap<>();
		Calendar setOne = Calendar.getInstance();
		int setYear = year;	//내가 찾는 연
		int setMonth = month;	//내가 찾는 월

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
		theDay.put("firstDate", firstDate);
		theDay.put("firstBlank", firstBlank);
		theDay.put("endDate", endDate);
		theDay.put("endBlank", endBlank);
		
		log.debug("●●●●▶ setYear-> "+setYear);
		log.debug("●●●●▶ setMonth-> "+setMonth);
		log.debug("●●●●▶ firstDate-> "+firstDate);
		log.debug("●●●●▶ firstBlank-> "+firstBlank);
		log.debug("●●●●▶ endDate-> "+endDate);
		log.debug("●●●●▶ endBlank-> "+endBlank);
		
		return theDay;
	}
	
}
