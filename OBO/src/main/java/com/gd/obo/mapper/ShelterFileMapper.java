package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.ShelterFile;

@Mapper
public interface ShelterFileMapper {
	int deleteShelterFileOne(int shelterFileId);
	int insertShelterFile(ShelterFile shelterFile);
}
