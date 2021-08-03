package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.AnimalFile;

@Mapper
public interface AnimalFileMapper {
	int insertAnimalFile(AnimalFile animalFile);
	int updateAnimalFile(AnimalFile animalFile);
}
