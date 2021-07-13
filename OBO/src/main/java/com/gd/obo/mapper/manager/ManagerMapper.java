package com.gd.obo.mapper.manager;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManagerMapper {
	List<String> selectManagerByLogin(Map<String, Object> map);
}
