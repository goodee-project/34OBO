package com.gd.obo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.service.BoardFileService;
import com.gd.obo.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardFileController {
	@Autowired BoardFileService boardFileService;
	
	@GetMapping("/removeBoardFile")
	public String removeBoardFile(BoardFile boardFile) {
		boardFileService.removeBoardFile(boardFile);
		log.debug("@@@@@ boardFile: " +boardFile);
		return "redirect:/getBoardOne?boardId="+boardFile.getBoardId();
	}
	
	
	@PostMapping("/addBoardFile")
	public String addBoardFile(MultipartFile multipartFile,
								@RequestParam(value="boardId", required = true) int boardId) {
		log.debug("@@@@@ boardId: "+boardId);
		log.debug("@@@@@ multipartFile: "+multipartFile);
		boardFileService.addBoardFile(multipartFile, boardId);
		return "redirect:/getBoardOne?boardId="+boardId;
	}
}