package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.AnimalFileMapper;
import com.gd.obo.mapper.AnimalMapper;
import com.gd.obo.vo.AnimalFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AnimalService {
	@Autowired
	AnimalMapper animalMapper;
	@Autowired
	AnimalFileMapper animalFileMapper;
	
	/*
	// 작성자 : 남민정
	// animal 수정
	public int updateAnimal(Map<String, Object> map) {
		
		return ;
	}
	*/
	
	
	

	// 작성자 : 남민정 
	// animal 추가
	public int addAnimal(Map<String, Object> map) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> insertAnimal map: " + map);
		
		return animalMapper.insertAnimal(map);
	}
		
	
	
	
	// 작성자 : 남민정
	// animal 상세 정보
	public Map<String, Object> getAnimalOne(int animalId) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne animalId: " + animalId);
		
		// 동물 상세보기
		Map<String, Object> animalMap = animalMapper.selectAnimalOne(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne animalMap: " + animalMap);
		
		// 동물 파일 목록
		List<AnimalFile> animalFileList = animalMapper.selectAnimalFileByAnimal(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne animalFileList: " + animalFileList);
			
		// controller에서 사용할 수 있는 맵
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne map: " + map);
		
		map.put("animalMap", animalMap);
		
		return map;
	}
	
	
	
	// 작성자 : 남민정
	// animal 리스트 (보호소마다 다름)
	public Map<String, Object> getAnimalList(int shelterId, String searchWord, 
											int currentPage, int rowPerPage) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList shelterId: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList searchWord: " + searchWord);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList currentPage: " + currentPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList rowPerPage: " + rowPerPage);
		
		// beginRow를 생성
		int beginRow = ((currentPage-1)*rowPerPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList beginRow: " + beginRow);
		
		// map을 불러와서 파라미터 데이터를 넣어줌.
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList map: " + map);
		
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("rowPerPage", rowPerPage);
		map.put("beginRow", beginRow);
		
		// selectAnimalTotal
		int selectAnimalTotal = animalMapper.selectAnimalTotal(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList selectAnimalTotal: " + selectAnimalTotal);
		
		// lastPage 생성
		int lastPage = (int)(Math.ceil((double)selectAnimalTotal / rowPerPage)); // lastPage만드는 식
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList lastPage: " + lastPage);
		
		// animalList
		List<Map<String, Object>> animalList = animalMapper.selectAnimalList(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList animalList: " + animalList);
		
		// controller에서 사용할 수 있는 맵
		Map<String, Object> returnMap = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList returnMap: " + returnMap);
		
		returnMap.put("animalList", animalList);
		returnMap.put("selectAnimalTotal", selectAnimalTotal);
		returnMap.put("lastPage", lastPage);
		returnMap.put("beginRow", beginRow);
		
		return returnMap;
		
	}
	
	// 사용자 : 이윤정 -> staff care info
	public List<Map<String,Object>> getAnimalCategoryList() {
		return animalMapper.selectAnimalCategoryList();
	}
}
