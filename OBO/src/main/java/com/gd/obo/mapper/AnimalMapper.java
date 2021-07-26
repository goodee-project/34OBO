package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Animal;
import com.gd.obo.vo.AnimalFile;

@Mapper
public interface AnimalMapper {
	
	// selectAnimalFileByAnimal -> 파일리스트
	List<AnimalFile> selectAnimalFileByAnimal(int animalId);
	
	// updateAnimal -> 동물 수정
	int updateAnimal(Map<String, Object> map);
	
	// insertAnimal -> 동물 추가
	int insertAnimal(Animal animal);
	
	// selectAnimalOne -> 동물 상세보기
	Map<String, Object> selectAnimalOne(int animalId);
	
	// selectAnimalList -> 직원이 자신의 보호소에 있는 동물들을 리스트로 볼 수 있게 만든 리스트
	List<Map<String,Object>> selectAnimalList(Map<String, Object> map);
	
	// selectAnimalTotal 
	int selectAnimalTotal(Map<String, Object> map);
	
	//selectCategoryList
	List<Map<String, Object>> selectAnimalCategoryList();
}
