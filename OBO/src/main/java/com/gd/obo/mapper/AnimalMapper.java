package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Animal;

@Mapper
public interface AnimalMapper {
	
	// insertAnimal -> 동물 추가
	int insertAnimal(Map<String, Object> map);
	
	// selectAnimalOne -> 동물 상세보기
	Map<String, Object> selectAnimalOne(int animalId);
	
	// selectAnimalList -> 직원이 자신의 보호소에 있는 동물들을 리스트로 볼 수 있게 만든 리스트
	List<Map<String,Object>> selectAnimalList(Map<String, Object> map);
	
	// selectAnimalTotal 
	int selectAnimalTotal(Map<String, Object> map);
	
	//selectCategoryList
	List<Map<String, Object>> selectAnimalCategoryList();
}
