package com.gd.obo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.BoardFile;

@Mapper
public interface BoardFileMapper {
	int insertBoardFile(BoardFile boardFile);
	int deleteBoardFile(int boardFileId);
}
