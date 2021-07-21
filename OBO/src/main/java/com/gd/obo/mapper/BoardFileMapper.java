package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.BoardFile;

@Mapper
public interface BoardFileMapper {
	int insertBoardFile(BoardFile boardFile);
	int deleteBoardFile(int boardFileId);
}
