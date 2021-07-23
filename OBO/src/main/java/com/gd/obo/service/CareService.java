// 작성자 : 이윤정

package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.CareMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class CareService {
	@Autowired CareMapper careMapper;
	
	// staff - care info 리스트 보기
	public List<Map<String, Object>> getCareInfoList(String searchWord, String species, String careSorting){
		return careMapper.selectCareInfoList(searchWord, species, careSorting);
	}
	
	// staff - care plan 날짜 자동 계산
	public List<Map<String, Object>> getCarePlanDay(int shelterId, int animalId, int careInfoId){
		return careMapper.selectCarePlanDay(shelterId, animalId, careInfoId);
	}
	
	// staff - care info -> sorting 리스트 불러오기
	public List<Map<String, Object>> getCareInfoByCarePlan(int animalCategoryId) {
		return careMapper.selectCareInfoByCarePlan(animalCategoryId);
	}
	
	/*
	// staff - care info -> content 리스트 불러오기
	public List<Map<String, Object>> getCareInfoByCarePlan(int animalCategoryId, String careSorting) {
		Map<String, Object> map = new HashMap<>();
		map.put("animalCategoryId", animalCategoryId);
		map.put("careSorting", careSorting);
		log.debug("●●●●▶content 리스트-> "+map);
		
		return careMapper.selectCareInfoByCarePlan(map);
	}*/
	
	// staff - care plan dday list 불러오기
	public List<Map<String, Object>> getCarePlanDdayList(int shelterId){
		int limitDate = 14;
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("limitDate", limitDate);
		log.debug("●●●●▶map-> "+map);
		return careMapper.selectCarePlanList(map);
	}
	
	// staff - care plan list 불러오기
	public List<Map<String, Object>> getCarePlanList(int shelterId){
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		log.debug("●●●●▶map-> "+map);
		return careMapper.selectCarePlanList(map);
	}
	
	// staff - care plan record list 불러오기
	public List<Map<String, Object>> getCarePlanRecordList (int shelterId){
		return careMapper.selectCarePlanRecordList(shelterId);
	}
	
	// staff - care plan 추가
	public int addCarePlan() {
		return 0;
	}
}
