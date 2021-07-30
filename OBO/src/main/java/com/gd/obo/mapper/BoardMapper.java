package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Board;
import com.gd.obo.vo.BoardFile;

@Mapper
public interface BoardMapper {
	Map<String, Object> selectBoardOne(int boardId);
	List<Map<String, Object>> selectBoardList(Map<String, Object> map);
	int selectTotal(Map<String,Object> totalMap);
	int insertBoard(Board board);
	List<Map<String, Object>> selectBoardCategoryList();
	int deleteBoard(int boardId);
	int deleteBoardFileByBoard(int boardId);
	List<BoardFile> selectBoardFileByBoard(int boardId);
	int updateBoard(Board board);
	int insertBoardLike(Map<String,Object> map);
	int selectBoardLikeByMember(Map<String,Object> map);
}
