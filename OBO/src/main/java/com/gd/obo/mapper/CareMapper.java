package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.CarePlan;

@Mapper
public interface CareMapper {
	List<Map<String, Object>> selectCareInfoList(String searchWord, String species, String careSorting);
	List<Map<String, Object>> selectCareInfoByCarePlan(int animalCategoryId);
	List<Map<String, Object>> selectCarePlanDay(int shelterId, int animalId, int careInfoId);
	List<Map<String, Object>> selectCarePlanList(Map<String, Object> map);
	List<Map<String, Object>> selectCarePlanRecordList(int shelterId);
	int insertCarePlan(CarePlan carePlan);
}
