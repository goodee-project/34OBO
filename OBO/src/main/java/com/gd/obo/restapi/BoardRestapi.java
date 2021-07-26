package com.gd.obo.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.BoardFileService;
import com.gd.obo.service.BoardService;
import com.gd.obo.vo.BoardForm;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class BoardRestapi {
	@Autowired BoardService boardService;
	@Autowired BoardFileService boardFileService;
	
	
	//내정보 보기
	@PostMapping("/member/getBoardHistory")
	public Map<String, Object> getBoardHistory(@RequestParam(value="memberId", required = true)String memberId,
													@RequestParam(value="currentPage", defaultValue = "1")int currentPage){
		log.debug("■■■■■ memberId param: "+ memberId);
		log.debug("■■■■■ currentPage param: "+ currentPage);
		
		return boardService.getBoardList(currentPage, 10, null, null, memberId);				
	}
	
	
	@PostMapping("/removeBoard")
	public int removeBoard(@RequestParam(value = "boardId", required = true) int boardId) {
		log.debug("@@@@@ boardId: "+boardId);
		int row = boardService.removeBoard(boardId);
		log.debug("@@@@@ row: "+row);
		return row;
	}
	@PostMapping("/removeBoardFile")
	public int removeBoardFile(BoardForm boardForm) {
		log.debug("@@@@@ boardForm: "+boardForm);
		int row = boardService.removeBoard(boardForm.getBoard().getBoardId());
		log.debug("@@@@@ row: "+row);
		return row;
	}
}
