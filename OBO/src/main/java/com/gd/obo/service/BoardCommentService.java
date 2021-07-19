package com.gd.obo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.BoardCommentMapper;
import com.gd.obo.vo.BoardComment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardCommentService {
	@Autowired BoardCommentMapper boardCommentMapper;
	
	public int insertBoardComment(BoardComment boardComment) {
		log.debug("@@@@@ boardComment: "+boardComment);
		int row = boardCommentMapper.insertBoardComment(boardComment);
		
		return row;
	}
	public int deleteBoardComment(int boardId) {
		log.debug("@@@@@ boardId: "+boardId);
		
		int row = boardCommentMapper.deleteBoardComment(boardId);
		
		return row;
	}
}
