package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.ShelterAddress;
import com.gd.obo.vo.ShelterFile;

@Mapper
public interface ShelterMapper {
	List<ShelterFile> selectShelterFileByShelter(int shelterId);
	int updateShelter(Shelter shelter);
	List<Shelter> selectShelterListByDonation();
	List<ShelterAddress> selectShelterList(Map<String, Object> map);
	int selectTotal(Map<String, Object> totalMap);
	Map<String, Object> selectShelterOne(int shelterId);
	List<Shelter> selectShelterName(String searchWord);
	int insertShelter(Shelter shelter);
	List<ShelterFile> selectShelterFileListByShelterId(int shelterId);
}
