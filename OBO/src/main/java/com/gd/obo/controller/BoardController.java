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
import com.gd.obo.vo.BoardForm;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	@Autowired BoardService boardService;
	@Autowired AnimalService animalService;
	
	@GetMapping("/addBoardLike")
	public String addBoardLike(HttpSession session, @RequestParam(value = "boardId", required = true) int boardId) {
		String memberId = ((Member)(session.getAttribute("loginMember"))).getMemberId();
		boardService.addBoardLike(boardId, memberId);
		return "redirect:/getBoardOne?boardId="+boardId;
	}
	
	//내정보 -> 작성글 보기
	@GetMapping("/member/getBoardHistory")
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
	
	@GetMapping("/modifyBoard")
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
	public String addBoard(BoardForm boardForm) {
		log.debug("@@@@@ boardForm: "+boardForm);
		boardService.addBoard(boardForm);
		return "redirect:/getBoardOne?boardId="+boardForm.getBoard().getBoardId();
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
	@GetMapping("/getBoardOne")
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
		log.debug("species: "+species);
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
