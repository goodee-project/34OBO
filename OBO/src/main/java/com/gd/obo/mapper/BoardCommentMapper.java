package com.gd.obo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.BoardComment;

@Mapper
public interface BoardCommentMapper {
	List<BoardComment> selectBoardComment(int boardId);
	int insertBoardComment(BoardComment boardComment);
	int deleteBoardComment(int boardCommentId);
	int deleteBoardCommentByBoard(int boardId);
	
}
