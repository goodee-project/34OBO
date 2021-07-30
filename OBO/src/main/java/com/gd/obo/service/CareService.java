// 작성자 : 이윤정

package com.gd.obo.service;

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
}
