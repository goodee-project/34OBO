package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.AnimalMapper;
import com.gd.obo.vo.Animal;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AnimalService {
	@Autowired
	AnimalMapper animalMapper;
	
	// animal 리스트 (보호소마다 다름)
	public Map<String, Object> getAnimalList(int shelterId, String searchWord, 
											int currentPage, int rowPerPage) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + searchWord);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + currentPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + rowPerPage);
		
		// beginRow를 생성
		int beginRow = ((currentPage-1)*rowPerPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + beginRow);
		
		// map을 불러와서 파라미터 데이터를 넣어줌.
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + map);
		
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("rowPerPage", rowPerPage);
		map.put("beginRow", beginRow);
		
		// selectAnimalTotal
		int selectAnimalTotal = animalMapper.selectAnimalTotal(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + selectAnimalTotal);
		
		// lastPage 생성
		int lastPage = (int)(Math.ceil((double)selectAnimalTotal / rowPerPage)); // lastPage만드는 식
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + lastPage);
		
		// animalList
		List<Map<String, Object>> animalList = animalMapper.selectAnimalList(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + animalList);
		
		// controller에서 사용할 수 있는 맵
		Map<String, Object> returnMap = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList param: " + returnMap);
		
		returnMap.put("animalList", animalList);
		returnMap.put("selectAnimalTotal", selectAnimalTotal);
		returnMap.put("lastPage", lastPage);
		returnMap.put("beginRow", beginRow);
		
		return returnMap;
		
	}
	public List<Map<String, Object>> getAnimalCategoryList() {
		return animalMapper.selectAnimalCategoryList();
	}
}
