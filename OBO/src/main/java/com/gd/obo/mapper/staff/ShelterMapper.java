package com.gd.obo.mapper.staff;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Shelter;

@Mapper
public interface ShelterMapper {
	List<Shelter> selectShelterList();
}
