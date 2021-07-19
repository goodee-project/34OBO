// 작성자: 김선유
package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.BoardCommentMapper;
import com.gd.obo.mapper.BoardMapper;
import com.gd.obo.vo.Board;
import com.gd.obo.vo.BoardComment;
import com.gd.obo.vo.BoardFile;
import com.gd.obo.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class BoardService {
	@Autowired BoardMapper boardMapper;
	@Autowired BoardCommentMapper boardCommentMapper;
	
	// board 삭제
	public int removeBoard(int boardId) {
		// 게시판 삭제
		int boardRow = boardMapper.deleteBoard(boardId);
		if(boardRow == 0) {
			return 0;
		}
		log.debug("@@@@@ boardRow :"+boardRow);
		
		// 댓글 삭제
		int boardCommentRow = boardCommentMapper.deleteBoardCommentByBoard(boardId);
		log.debug("@@@@@ boardCommentRow: "+boardCommentRow);
		
		// 파일 삭제
		int boardFileRow = boardMapper.deleteBoardFileByBoard(boardId);
		log.debug("@@@@@ boardFileRow: "+boardFileRow);
		
		return boardRow;
	}
	
	// board category 리스트
	public List<Map<String, Object>> getBoardCategoryList() {
		return boardMapper.selectBoardCategoryList();
	}
	
	// board 추가
	public int addBoard(Board board) {
		return boardMapper.insertBoard(board);
	}
	
	// board 상세보기
	public Map<String, Object> getBoardOne(int boardId) {
		
		Map<String, Object> boardMap = boardMapper.selectBoardOne(boardId);
		log.debug("@@@@@ boardMap"+boardMap);
		
		// 댓글 리스트
		List<BoardComment> boardCommentList = boardCommentMapper.selectBoardComment(boardId);
		log.debug("@@@@@ boardCommentList: "+boardCommentList);
		
		// boardfile
		List<BoardFile> boardFileList = boardMapper.selectBoardFileByBoard(boardId);
		log.debug("@@@@@ boardFileList: "+boardFileList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardMap", boardMap);
		map.put("boardCommentList", boardCommentList);
		map.put("boardFileList", boardFileList);		
		log.debug("@@@@@ map: "+map);
		
		return map;		
	}
	
	// board 리스트
	public Map<String, Object> getBoardList(int currentPage, int rowPerPage, String boardTitle, String species, String memberId){
		// shelter 개수
				Map<String, Object> totalMap = new HashMap<>();	
				totalMap.put("boardTitle", boardTitle);
				totalMap.put("species", species);
				totalMap.put("memberId", memberId);
				
				int boardTotal = boardMapper.selectTotal(totalMap);
				int lastPage = (int)Math.ceil((double)boardTotal/rowPerPage);
				log.debug("@@@@@boardTotal: "+boardTotal);
				log.debug("@@@@@lastPage:"+lastPage);
				
				// 페이징
				Page page = new Page();
				int beginRow = (currentPage-1)*rowPerPage;
				page.setBeginRow(beginRow);
				page.setRowPerPage(rowPerPage);
				log.debug("@@@@@Page: "+page);
				
				//리스트
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("paramMap", paramMap);
				paramMap.put("currentPage", currentPage);
				paramMap.put("rowPerPage", rowPerPage);
				paramMap.put("beginRow", beginRow);
				paramMap.put("boardTitle", boardTitle);
				paramMap.put("species", species);
				paramMap.put("memberId", memberId);
				log.debug("@@@@@ paramMap: "+paramMap);
				
				List<Map<String, Object>> boardList = boardMapper.selectBoardList(paramMap);
				
				Map<String, Object> returnMap = new HashMap<>();
				
				returnMap.put("boardList", boardList);
				returnMap.put("lastPage", lastPage);
				log.debug("@@@@@ returnMap: "+returnMap);
				
				return returnMap;
	}
}
