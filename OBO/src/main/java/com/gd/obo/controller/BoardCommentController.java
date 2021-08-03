package com.gd.obo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.BoardCommentService;
import com.gd.obo.vo.BoardComment;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardCommentController {
	@Autowired BoardCommentService boardCommentService;
	
	@PostMapping("/member/addBoardComment")
	public String addBoardComment(BoardComment boardComment, HttpSession session) {
		log.debug("@@@@@ boardComment: "+boardComment);
		
		String memberId = ((Member)session.getAttribute("loginMember")).getMemberId();
		boardComment.setMemberId(memberId);
		
		int row = boardCommentService.insertBoardComment(boardComment);
		log.debug("@@@@@ row: "+row);
		
		return "redirect:/member/getBoardOne?boardId="+boardComment.getBoardId();
	}
}
