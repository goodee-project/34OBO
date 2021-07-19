package com.gd.obo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.BoardCommentService;
import com.gd.obo.vo.BoardComment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardCommentController {
	@Autowired BoardCommentService boardCommentService;
	
	@PostMapping("/addBoardComment")
	public String addBoardComment(BoardComment boardComment) {
		log.debug("@@@@@ boardComment: "+boardComment);
		
		int row = boardCommentService.insertBoardComment(boardComment);
		log.debug("@@@@@ row: "+row);
		
		return "redirect:/getBoardOne?boardId="+boardComment.getBoardId();
	}
	@GetMapping("/removeComment")
	public String removeBoardComment(@RequestParam(value = "boardCommentId", required = true) int boardCommentId,
									@RequestParam(value="boardId", required = true) int boardId) {
		log.debug("@@@@@ boardCommentId: "+boardCommentId);
		log.debug("@@@@@ boardId: "+boardId);
		
		int row = boardCommentService.deleteBoardComment(boardId);
		log.debug("@@@@@ row: "+row);
		
		return "redirect:/getBoardOne?boardId="+boardId;
	}
}
