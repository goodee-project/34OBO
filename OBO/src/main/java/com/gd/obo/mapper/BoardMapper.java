package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {
	List<Map<String, Object>> selectBoardList(Map<String, Object> map);
	int selectTotal(Map<String,Object> totalMap);
}
