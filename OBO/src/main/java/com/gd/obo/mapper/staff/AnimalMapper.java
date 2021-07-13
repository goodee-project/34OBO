package com.gd.obo.mapper.staff;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Animal;

@Mapper
public interface AnimalMapper {
	// selectAnimalList -> 직원이 자신의 보호소에 있는 동물들을 리스트로 볼 수 있게 만든 리스트
	List<Map<String,Object>> selectAnimalList(Map<String, Object> map);
	
	// selectAnimalTotal 
	int selectAnimalTotal(Map<String, Object> map);
}
