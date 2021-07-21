package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CareMapper {
	List<Map<String, Object>> selectCareInfoList(String searchWord, String species, String careSorting);
	List<Map<String, Object>> selectCareInfoByCarePlan(int animalCategoryId);
	List<Map<String, Object>> selectCarePlanDay(int shelterId, int animalId, int careInfoId);
	int insertCarePlan(Map<String, Object> map);
}
