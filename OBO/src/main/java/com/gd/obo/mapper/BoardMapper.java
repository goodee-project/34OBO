package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Board;

@Mapper
public interface BoardMapper {
	Map<String, Object> selectBoardOne(int boardId);
	List<Map<String, Object>> selectBoardList(Map<String, Object> map);
	int selectTotal(Map<String,Object> totalMap);
	int insertBoard(Board board);
	int insertBoardFile(Map<String, Object> map);
	List<Map<String, Object>> selectBoardCategoryList();
}
