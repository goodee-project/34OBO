package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.ShelterAddress;

@Mapper
public interface ShelterMapper {
	List<ShelterAddress> selectShelterList(Map<String, Object> map);
	int selectTotal(Map<String, Object> totalMap);
	Map<String, Object> selectShelterOne(int shelterId);
	List<Shelter> selectShelterName(String searchWord);
	int insertShelter(Shelter shelter);
}
