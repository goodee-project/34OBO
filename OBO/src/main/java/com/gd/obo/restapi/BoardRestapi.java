package com.gd.obo.restapi;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.BoardCommentService;
import com.gd.obo.service.BoardFileService;
import com.gd.obo.service.BoardService;
import com.gd.obo.vo.BoardForm;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class BoardRestapi {
	@Autowired BoardService boardService;
	@Autowired BoardFileService boardFileService;
	@Autowired BoardCommentService boardCommentService;
	
	@PostMapping("/member/getBoardLikeByMemberId")
	public Map<String, Object> getBoardLikeByMemberId(HttpSession session,
										@RequestParam(value="currentPage", defaultValue = "1")int currentPage){
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		log.debug("■■■■■ currentPage getBoardLikeByMemberId param: "+ currentPage);
		return boardService.getBoardLikeByMemberId(memberId, currentPage, 10);
	}
	
	@GetMapping("/getBoardLikeByMember")
	public int getBoardLikeByMember(HttpSession session, @RequestParam(value="boardId", required=true) int boardId) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		log.debug("===== animalId:"+boardId);
		int ck = boardService.getBoardLikeByMember(memberId, boardId);
		return ck;
	}
	
	// 좋아요 클릭!
	@GetMapping("/addBoardLike")
	public int addBoardLike(HttpSession session, @RequestParam(value="boardId", required=true) int boardId) {
		log.debug("★★★☆○○○○★☆○☆★○ boardId: "+boardId);
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		
		int row = boardService.addBoardLike(boardId, memberId);
		log.debug("★★★☆○○○○★☆○☆★○ 좋아요 클릭!!!!!(실패0) "+row);
		
		return row;
	}
	
	// 좋아요 취소
	@GetMapping("/removeBoardLike")
	public int removeBoardLike(HttpSession session, @RequestParam(value="boardId", required=true) int boardId) {
		log.debug("★★★☆○○○○★☆○☆★○ boardId: "+boardId);
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		
		int row = boardService.removeBoardLike(boardId, memberId);
		log.debug("★★★☆○○○○★☆○☆★○ 좋아요 취소!!!!(실패0) "+row);
		
		return row;
	}
	
	// 좋아요 현황
	@GetMapping("/getBoardLikeNow")
	public int getBoardLikeNow(HttpSession session, @RequestParam(value="boardId", required=true) int boardId) {
		log.debug("★★★☆○○○○★☆○☆★○ boardId: "+boardId);
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		
		int row = boardService.getBoardLikeNow(memberId, boardId);
		log.debug("★★★☆○○○○★☆○☆★○ 좋아요했으면 1!! 안했으면 0-> "+row);
		return row;
	}
	
	// 좋아요 토탈
	@GetMapping("/getBoardLikeTotal")
	public int getBoardLikeTotal(int boardId) {
		log.debug("★★★☆○○○○★☆○☆★○ boardId: "+boardId);
		
		int row = boardService.getBoardLikeTotal(boardId);
		log.debug("★★★☆○○○○★☆○☆★○ 총 좋아요 수!!!-> "+row);
		return row;
	}
	
	// 댓글 삭제
	@PostMapping("/member/removeBoardComment")
	public int removeBoardComment(@RequestParam(value="boardCommentId",required=true) int boardCommentId) {
		log.debug("@@@@@ boardCommentId: "+boardCommentId);
		int row = boardCommentService.deleteBoardComment(boardCommentId);
		log.debug("@@@@@ row: "+row);
		return row;
	}
	
	//내정보 보기
	@PostMapping("/member/getBoardHistory")
	public Map<String, Object> getBoardHistory(@RequestParam(value="memberId", required = true)String memberId,
													@RequestParam(value="currentPage", defaultValue = "1")int currentPage){
		log.debug("■■■■■ memberId param: "+ memberId);
		log.debug("■■■■■ currentPage param: "+ currentPage);
		
		return boardService.getBoardList(currentPage, 10, memberId, "member", 0);				
	}
	
	
	@PostMapping("/member/removeBoard")
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
