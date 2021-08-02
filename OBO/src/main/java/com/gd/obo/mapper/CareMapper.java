package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.CarePlan;

@Mapper
public interface CareMapper {
	List<Map<String, Object>> selectCareInfoList(Map<String, Object> map);
	List<Map<String, Object>> selectCareInfoByCarePlan(int animalCategoryId);
	List<Map<String, Object>> selectCarePlanDay(int shelterId, int animalId, int careInfoId);
	List<Map<String, Object>> selectCarePlanList(Map<String, Object> map);
	List<Map<String, Object>> selectCarePlanInCal(Map<String, Object> map);
	List<Map<String, Object>> selectCareRecordList(Map<String, Object> map);
	List<Map<String, Object>> selectCarePlanAnimalOne(int animalId);
	List<Map<String, Object>> selectCarePlanAnimalOneNon(int animalId);
	List<Map<String, Object>> selectCarePlanOneByList(Map<String, Object> map);
	Map<String, Object> selectCarePlanOne(Map<String, Object> map);
	Map<String, Object> selectCarePlanOneWithRecord(Map<String, Object> map);
	int insertCarePlan(CarePlan carePlan);
	int insertCareRecord(Map<String, Object> map);
	List<Map<String, Object>> selectCarePlanListByMemberId(Map<String, Object> map);
	int selectCarePlanListTotalByMemberId(String memberId);
}
