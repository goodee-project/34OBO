// 작성자: 김선유
package com.gd.obo.restapi.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.main.ShelterMapper;
import com.gd.obo.vo.main.Shelter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ShelterService {
	@Autowired ShelterMapper shelterMapper;
	
	// shelter 상세보기
	public Map<String, Object> getShelterOne(int shelterId) {
		// 상세보기
		Map<String, Object> shelterMap = shelterMapper.selectShelterOne(shelterId);
		log.debug("@@@@@shelterMap: "+shelterMap);
		
		return shelterMap;
		}
	
	
	// shelter 리스트
	public List<Shelter> getShelterList() {
		
		List<Shelter> shelterList = shelterMapper.selectShelterList();
		
		
		return shelterList;
	}
	
}
