package com.gd.obo.mapper.main;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.main.Shelter;

@Mapper
public interface ShelterMapper {
	List<Shelter> selectShelterList();
	int selectTotal(Map<String, Object> totalMap);
	Map<String, Object> selectShelterOne(int shelterId);
}
