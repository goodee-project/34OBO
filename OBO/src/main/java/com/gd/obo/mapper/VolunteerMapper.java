package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Page;

@Mapper
public interface VolunteerMapper {
	List<Map<String, Object>> selectVolunteerNList(Map<String, Object> map);
	int selectVolunteerNTotal(String searchWord);
	List<String> selectVolunteerCategory();
}
