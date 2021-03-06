// 작성자 : 이윤정

package com.gd.obo.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.CareMapper;
import com.gd.obo.vo.CarePlan;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class CareService {
	@Autowired CareMapper careMapper;
	
	// staff - care info 리스트 보기
	public List<Map<String, Object>> getCareInfoList(String searchWord, String species, String careSorting, int currentPage, int rowPerPage){
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchWord", searchWord);
		map.put("species", species);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ getCareInfoList map-> "+map);
		
		List<Map<String, Object>> list = careMapper.selectCareInfoList(map);
		log.debug("●●●●▶ getCareInfoList list-> "+list);
		
		return list;
	}
	
	// staff - care plan 날짜 자동 계산
	public List<Map<String, Object>> getCarePlanDay(int shelterId, int animalId, int careInfoId){
		return careMapper.selectCarePlanDay(shelterId, animalId, careInfoId);
	}
	
	// staff - care info -> sorting 리스트 불러오기
	public List<Map<String, Object>> getCareInfoByCarePlan(int animalCategoryId) {
		return careMapper.selectCareInfoByCarePlan(animalCategoryId);
	}
	
	// staff - care plan dday list 불러오기
	public List<Map<String, Object>> getCarePlanDdayList(int shelterId){
		int limitDate = 14;
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("limitDate", limitDate);
		log.debug("●●●●▶ getCarePlanDdayList map-> "+map);
		
		List<Map<String, Object>> list = careMapper.selectCarePlanList(map);
		log.debug("●●●●▶ getCarePlanDdayList list-> "+list);
		
		return list;
	}
	
	// staff - care plan list 불러오기
	public List<Map<String, Object>> getCarePlanList(int shelterId, String searchWord, String selectOption, int currentPage, int rowPerPage){
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("selectOption", selectOption);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ getCarePlanList map-> "+map);
		
		List<Map<String, Object>> list = careMapper.selectCarePlanList(map);
		log.debug("●●●●▶ getCarePlanList-> "+list);
		
		return list;
	}
	
	// staff - care plan 달력에서 보여줄 list
	public List<Map<String, Object>> getCarePlanInCal (int shelterId, int year, int month){
		String setDate = "";
		setDate = year+"-"+month;
		
		if(month<10) {
			setDate = year+"-0"+month;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("setDate", setDate);
		log.debug("●●●●▶ getCarePlanInCal map-> "+map);
		return careMapper.selectCarePlanInCal(map);
	}
	
	// staff - care record list 불러오기
	public List<Map<String, Object>> getCareRecordList (int shelterId, String searchWord, String selectOption, int currentPage, int rowPerPage){
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("selectOption", selectOption);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ getCareRecordList map-> "+map);
		
		List<Map<String, Object>> list = careMapper.selectCareRecordList(map);
		log.debug("●●●●▶ getCareRecordList list-> "+list);
		
		return list;
	}
	
	// staff - 입양간 동물의 작성된 케어 plan 보기
	public List<Map<String, Object>> getCarePlanAnimalOne (int animalId){
		List<Map<String, Object>> carePlanList = careMapper.selectCarePlanAnimalOne(animalId);
		log.debug("●●●●▶ carePlanList-> "+carePlanList);
		return carePlanList;
	}
	
	// staff - 입양간 동물의 미작성 케어 plan 보기
	public List<Map<String, Object>> getCarePlanAnimalOneNon (int animalId){
		List<Map<String, Object>> carePlanListNon = careMapper.selectCarePlanAnimalOneNon(animalId);
		log.debug("●●●●▶ carePlanListNon-> "+carePlanListNon);
		return carePlanListNon;
	}
	
	// staff - 케어 기록 작성 페이지에서 14일 이내 추가해야 할 동물들
	public List<Map<String, Object>> getCarePlanOneByList(int shelterId){
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		log.debug("●●●●▶ getCarePlanOneByList map-> "+map);
		return careMapper.selectCarePlanOneByList(map);
	}
	
	// staff - 케어 기록 작성 페이지에서 ↑ 위의 항목 선택 후 얻는 정보
	public Map<String, Object> getCarePlanOne(int shelterId, int carePlanId){
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("carePlanId", carePlanId);
		log.debug("●●●●▶ map-> "+map);
		return careMapper.selectCarePlanOne(map);
	}
	
	// staff - 달력에서 care plan 전체 확인
	public Map<String, Object> getCarePlanOneWithRecord(int carePlanId){
		Map<String, Object> map = new HashMap<>();
		map.put("carePlanId", carePlanId);
		log.debug("●●●●▶ map-> "+map);
		return careMapper.selectCarePlanOneWithRecord(map);
	}
	
	// staff - care plan 추가
	public int addCarePlan(int animalId, String memberId, String staffId, String[] careInfoIdArr, String[] careDate) {
		// 형변환용
		int[] careInfoId = new int[careInfoIdArr.length];
		
		// totalCnt - 성공횟수
		int totalCnt = 0;
		
		CarePlan carePlan = new CarePlan();
		carePlan.setAnimalId(animalId);
		carePlan.setMemberId(memberId);
		carePlan.setStaffId(staffId);
		for(int i=0; i<careInfoIdArr.length; i++) {
			//String -> int 형으로 바꿔야함
			careInfoId[i] = Integer.parseInt(careInfoIdArr[i]);
			carePlan.setCareInfoId(careInfoId[i]);
			carePlan.setCareDate(careDate[i]);
			
			totalCnt = careMapper.insertCarePlan(carePlan);
		}
		
		return totalCnt;
	}
	
	// staff - care record 추가
	public int addCareRecord(int carePlanId, String staffId, String features) {
		Map<String, Object> map = new HashMap<>();
		map.put("carePlanId", carePlanId);
		map.put("staffId", staffId);
		map.put("features", features);
		log.debug("●●●●▶ map-> "+map);
		return careMapper.insertCareRecord(map);
	}
	
	//main memberId로 케어플랜 가져오기
	public List<Map<String, Object>> getCarePlanListByMemberId(int year, int month, String memberId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("year", year);
		paramMap.put("month", month);
		paramMap.put("memberId", memberId);
		
		
		log.debug("■■■■■■ getCarePlanListByMemberId paramMap : "+ paramMap);
		return careMapper.selectCarePlanListByMemberId(paramMap);
	}
	
	//main memberId로 케어플랜 리스트 가져오기
	public Map<String, Object> getCareListByMemberId(String memberId, int currentPage, int rowPerPage){
		
		log.debug("■■■■■■■ getCareListByMemberId memberId param :" + memberId);
		log.debug("■■■■■■■ getCareListByMemberId currentPage param :" + currentPage);
		log.debug("■■■■■■■ getCareListByMemberId rowPerPage param :" + rowPerPage);
		
		int beginRow = (currentPage-1)*rowPerPage;
		
		//리스트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("memberId", memberId);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		
		List<Map<String, Object>> list = careMapper.selectCarePlanListByMemberId(paramMap);
		log.debug("■■■■■■■ getCareListByMemberId list :" + list);
		
		//마지막 페이지
		int total = careMapper.selectCarePlanListTotalByMemberId(memberId);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("■■■■■■■ getCareListByMemberId lastPage :" + lastPage);
		
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("list", list);
		returnMap.put("lastPage", lastPage);
				
		return returnMap;
	}
	
	public StringBuilder getHoliday(int year, int month){
		
		log.debug("■■■■■■■ year-> "+year);	
		log.debug("■■■■■■■ month-> "+month);
		
		// 공휴일 API 가져오기 - 3월은 03월로 넣어줘야 한다.
		String monthStr = "";
		if(month<10) {
			monthStr = "0"+month;
		} else {
			monthStr = ""+month;
		}
		
		StringBuilder sb = new StringBuilder();
		
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo"); /*URL*/
		try {
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=rwG0lK12hHgXoKRTMig2H/GFqq8kEuZkx9/sKQhTJGbLZiBXQjhHa6j24H51978fEcF7zRL/RGngV33o0Ba2sA==");
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
			
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} /*Service Key*/
		
		
	
		log.debug("●●●●▶ 공휴일-> "+sb);
		

		return sb;
	}
}
