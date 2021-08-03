// 작성자: 김선유
// 수정자: 손영현
package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.BoardService;
import com.gd.obo.vo.Board;
import com.gd.obo.vo.BoardForm;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired BoardService boardService;
	@Autowired AnimalService animalService;
	
	//내정보 -> 작성글 보기
	@GetMapping("/member/getMemberBoard")
	public String getBoardHistory(Model model, HttpSession session) {
		
		model.addAttribute("memberId", ((Member)session.getAttribute("loginMember")).getMemberId());
		return "main/getMemberBoard";
	}
	
	@PostMapping("/modifyBoard")
	public String modifyBoard(BoardForm boardForm) {
		log.debug("@@@@@ boardForm: "+boardForm);
		boardService.modifyBoard(boardForm);
		return "redirect:/getBoardOne?boardId="+boardForm.getBoard().getBoardId();
	}
	
	@GetMapping("/member/modifyBoard")
	public String modifyBoard(Model model,
								@RequestParam(value="boardId", required = true) int boardId) {
		log.debug("@@@@@ boardId :"+boardId);
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		List<Map<String, Object>> boardCategoryList = boardService.getBoardCategoryList();
		Map<String, Object> map = boardService.getBoardOne(boardId);
		model.addAttribute("animalCategoryList",animalCategoryList);
		model.addAttribute("boardCategoryList",boardCategoryList);
		model.addAttribute("map", map);
		model.addAttribute("boardMap", map.get("boardMap"));
		model.addAttribute("boardFileList",map.get("boardFileList"));
		log.debug("@@@@@ animalCategoryList"+animalCategoryList);
		log.debug("@@@@@ boardCategoryList"+boardCategoryList);
		return "main/modifyBoard";
	}
	
	// board 추가 액션
	@PostMapping("/addBoard")
	public String addBoard(BoardForm boardForm, HttpSession session) {
		String memberId = ((Member)(session.getAttribute("loginMember"))).getMemberId();
		boardForm.getBoard().setMemberId(memberId);
		log.debug("@@@@@ boardForm: "+boardForm);
		boardService.addBoard(boardForm);
		return "redirect:/member/getBoardOne?boardId="+boardForm.getBoard().getBoardId();
	}
	
	// board 추가 폼
	@GetMapping("/member/addBoard")
	public String addBoard(Model model, HttpSession session) {
		List<Map<String, Object>> animalCategoryList = animalService.getAnimalCategoryList();
		List<Map<String, Object>> boardCategoryList = boardService.getBoardCategoryList();
		model.addAttribute("memberId", ((Member)session.getAttribute("loginMember")).getMemberId());
		model.addAttribute("animalCategoryList",animalCategoryList);
		model.addAttribute("boardCategoryList",boardCategoryList);
		log.debug("@@@@@ animalCategoryList"+animalCategoryList);
		log.debug("@@@@@ boardCategoryList"+boardCategoryList);
		return "main/addBoard";
	}
	
	// board 상세보기
	@GetMapping("/member/getBoardOne")
	public String getBoardOne(Model model,
								@RequestParam(name="boardId", required=true)int boardId) {
		Map<String, Object> map = boardService.getBoardOne(boardId);
		log.debug("@@@@@ map: "+map);		
		model.addAttribute("map", map);
		model.addAttribute("boardMap",map.get("boardMap"));
		model.addAttribute("boardCommentList",map.get("boardCommentList"));
		model.addAttribute("boardFileList",map.get("boardFileList"));
		return "main/getBoardOne";
	}	
	
	@PostMapping("/removeBoard")
	public int removeBoard(@RequestParam(value = "boardId", required = true) int boardId) {
		log.debug("@@@@@ boardId: "+boardId);
		int row = boardService.removeBoard(boardId);
		log.debug("@@@@@ row: "+row);
		return row;
	}
	
	// board 리스트
	@GetMapping("/getBoardList")
	public String getBoardList(Model model,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,			
			@RequestParam(name="searchWord", required=false) String searchWord,
			@RequestParam(name="searchSelect", required=false) String searchSelect,
			@RequestParam(name="memberId", required=false) String memberId,
			@RequestParam(name="boardCategoryId", required=false, defaultValue = "0") int boardCategoryId) {
		log.debug("searchWord: "+searchWord);
		log.debug("searchSelect: "+searchSelect);
		log.debug("boardCategoryId: "+boardCategoryId);
		
		if(searchWord != null && searchWord.equals("")) {
			searchWord=null;
		}
		log.debug("species: "+searchSelect);
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect=null;
		}
		
		
		Map<String, Object> map = boardService.getBoardList(currentPage, rowPerPage, searchWord, searchSelect, memberId, boardCategoryId);
		model.addAttribute("boardList", map.get("boardList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchSelect",searchSelect);
		model.addAttribute("memberId",memberId);
		log.debug("@@@@@ map: "+map);
		
		return "main/getBoardList";
	}
}
