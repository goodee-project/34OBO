// 작성자: 김선유
package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.BoardService;
import com.gd.obo.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired BoardService boardService;
	@Autowired AnimalService animalService;
	
	// board 추가 액션
	@PostMapping("/addBoard")
	public String addBoard(Board board) {
		log.debug("@@@@@ board: "+board);
		boardService.addBoard(board);
		return "redirect:/getBoardList";
	}
	
	// board 추가 폼
	@GetMapping("/addBoard")
	public String addBoard(Model model) {
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		List<Map<String, Object>> boardCategoryList = boardService.getBoardCategoryList();
		model.addAttribute("animalCategoryList",animalCategoryList);
		model.addAttribute("boardCategoryList",boardCategoryList);
		log.debug("@@@@@ animalCategoryList"+animalCategoryList);
		log.debug("@@@@@ boardCategoryList"+boardCategoryList);
		return "main/addBoard";
	}
	
	// board 상세보기
	@GetMapping("/getBoardOne")
	public String getBoardOne(Model model,
								@RequestParam(name="boardId", required=true)int boardId) {
		Map<String, Object> boardMap = boardService.getBoardOne(boardId);
		log.debug("@@@@@ boardMap: "+boardMap);
		model.addAttribute("boardMap", boardMap);
		return "main/getBoardOne";
	}
	
	
	// board 리스트
	@GetMapping("/getBoardList")
	public String getBoardList(Model model,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,			
			@RequestParam(name="boardTitle", required=false) String boardTitle,
			@RequestParam(name="species", required=false) String species,
			@RequestParam(name="memberId", required=false) String memberId) {
		log.debug("boardTitle: "+boardTitle);
		if(boardTitle != null && boardTitle.equals("")) {
			boardTitle=null;
		}
		log.debug("price: "+species);
		if(species != null && species.equals("")) {
			species=null;
		}
		log.debug("memberId: "+memberId);
		if(memberId != null && memberId.equals("")) {
			memberId=null;
		}
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		Map<String, Object> map = boardService.getBoardList(currentPage, rowPerPage, boardTitle, species, memberId);
		model.addAttribute("boardList", map.get("boardList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("boardTitle",boardTitle);
		model.addAttribute("species",species);
		model.addAttribute("memberId",memberId);
		model.addAttribute("animalCategoryList",animalCategoryList);
		log.debug("@@@@@ map: "+map);
		
		return "main/getBoardList";
	}
}
