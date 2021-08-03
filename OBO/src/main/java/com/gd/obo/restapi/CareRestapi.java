package com.gd.obo.restapi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
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
import com.gd.obo.vo.Member;
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
	
	// staff - care plan calendar : 달력설정 + 일정 + 공휴일API
	@GetMapping("/getCalendarWithHoliday")
	public Map<String, Object> getCalendarWithHoliday(HttpSession session, int year, int month) throws IOException{
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
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
		
		log.debug("●●●●▶ 원하는 년/월의 정보-> "+theDay);
		
		// 가져올 care plan list
		List<Map<String, Object>> carePlanList = careService.getCarePlanInCal(shelterId, year, month);
		log.debug("●●●●▶ 원하는 년/월의 carePlanList-> "+carePlanList);
		
		// 공휴일 API 가져오기 - 3월은 03월로 넣어줘야 한다.
		String monthStr = "";
		if(month<10) {
			monthStr = "0"+month;
		} else {
			monthStr = ""+month;
		}
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=rwG0lK12hHgXoKRTMig2H/GFqq8kEuZkx9/sKQhTJGbLZiBXQjhHa6j24H51978fEcF7zRL/RGngV33o0Ba2sA=="); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + year); /*연*/
		urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + monthStr); /*월*/
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=json"); /*json*/
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
	
		log.debug("●●●●▶ 공휴일-> "+sb);
		
		
		// 한번에 보내주기 위한 map 다시 만들어준다.
		Map<String, Object> map = new HashMap<>();
		map.put("theDay", theDay);
		map.put("carePlanList", carePlanList);
		map.put("holidayList", sb);
		
		return map;
	}
	
	// care plan 전체 다 보기 -> record 있으나 없으나 그냥 다 보기
	@GetMapping("/getCarePlanOneWithRecord")
	public Map<String, Object> getCarePlanOneWithRecord(int carePlanId){
		log.debug("●●●●▶얻은 carePlanId-> "+carePlanId);
		return careService.getCarePlanOneWithRecord(carePlanId);
	}
	
	@GetMapping("/member/getCarePlanListByMemberId")
	public Map<String, Object> getCarePlanListByMemberId(HttpSession session,
													@RequestParam(value = "year", defaultValue = "0")int year,
													@RequestParam(value = "month", defaultValue = "0")int month){
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();

		
		Map<String, Object> map = new HashMap<>();
		map.put("list", careService.getCarePlanListByMemberId(year, month, memberId));
		map.put("holiday", careService.getHoliday(year, month));
		return map;
	}
	
	@GetMapping("/member/getCareListByMemberId")
	public Map<String, Object> getCareListByMemberId(HttpSession session,
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		
		Map<String, Object> map = careService.getCareListByMemberId(memberId, currentPage, 5);
		
		log.debug("■■■■■■■■ map getCareListByMemberId : " + map);
		return map;
	}
	
	@GetMapping("/getHoliday")
	public StringBuilder getHoliday(@RequestParam(value = "year") String year,
									@RequestParam(value = "month") String month) throws IOException {
		log.debug("●●●●▶ year-> "+year);
		log.debug("●●●●▶ month-> "+month);
		
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=rwG0lK12hHgXoKRTMig2H/GFqq8kEuZkx9/sKQhTJGbLZiBXQjhHa6j24H51978fEcF7zRL/RGngV33o0Ba2sA=="); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("solYear","UTF-8") + "=" + year); /*연*/
		urlBuilder.append("&" + URLEncoder.encode("solMonth","UTF-8") + "=" + month); /*월*/
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=json"); /*json*/
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
	
		log.debug("●●●●▶ 공휴일-> "+sb);
		
		return sb;
	}
	
}
