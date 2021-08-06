// 작성자: 김선유
// 수정자: 손영현
package com.gd.obo.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.BoardCommentMapper;
import com.gd.obo.mapper.BoardFileMapper;
import com.gd.obo.mapper.BoardMapper;
import com.gd.obo.vo.Board;
import com.gd.obo.vo.BoardComment;
import com.gd.obo.vo.BoardFile;
import com.gd.obo.vo.BoardForm;
import com.gd.obo.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class BoardService {
	@Autowired BoardMapper boardMapper;
	@Autowired BoardCommentMapper boardCommentMapper;
	@Autowired BoardFileMapper boardFileMapper;
	
	//멤버별 계시판 좋아요 보기
	public Map<String, Object> getBoardLikeByMemberId(String memberId, int currentPage, int rowPerPage){
		log.debug("■■■■■■■ getBoardLikeByMemberId memberId param :" + memberId);
		log.debug("■■■■■■■ getBoardLikeByMemberId currentPage param :" + currentPage);
		log.debug("■■■■■■■ getBoardLikeByMemberId rowPerPage param :" + rowPerPage);
		
		int beginRow = (currentPage-1)*rowPerPage;
		
		//리스트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("memberId", memberId);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		
		List<Map<String ,Object>> likeList = boardMapper.selectBoardLikeByMemberId(paramMap);
		log.debug("■■■■■■■ getBoardLikeByMemberId likeList :" + likeList);
		
		
		//마지막 페이지
		int total = boardMapper.selectBoardLikeTotalByMemberId(memberId);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("■■■■■■■ getBoardLikeByMemberId lastPage :" + lastPage);
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("likeList", likeList);
		returnMap.put("lastPage", lastPage);
		return returnMap;
	}
	
	// 게시판 좋아요
	public int addBoardLike(int boardId, String memberId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("boardId", boardId);
		int row = boardMapper.insertBoardLike(map);
		log.debug("@@@@@ row: "+row);
		log.debug("@@@@@ boardId: "+boardId);
		return row;
	}
	
	// 좋아요 중복 확인
	public int getBoardLikeByMember(String memberId, int boardId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("boardId", boardId);
		int ck = boardMapper.selectBoardLikeByMember(map);
		log.debug("@@@@@ boardId: "+boardId);
		log.debug("@@@@@ ck: "+ck);
		return ck;
	}
	
	// board 수정
	public int modifyBoard(BoardForm boardForm) {
		Board board = boardForm.getBoard();
		boardMapper.updateBoard(board);		
		Map<String, Object> map = new HashMap<String, Object>();
		List<BoardFile> boardFileList = boardMapper.selectBoardFileByBoard(board.getBoardId());
		log.debug("@@@@@ boardFileList: "+boardFileList);
		map.put("boardId",board.getBoardId());
		map.put("boardFile", boardForm.getBoardFile());
		map.put("boardFileList", boardFileList);
		log.debug("@@@@@ map: "+map);

		List<MultipartFile> list = boardForm.getBoardFile();
		if(list != null) {
			for(MultipartFile f : list) {
				BoardFile boardFile = new BoardFile();
				boardFile.setBoardId(board.getBoardId()); // auto increment로 입력된 값
				
				String originalFileName = f.getOriginalFilename();
				int p = originalFileName.lastIndexOf("."); //test.txt면 4;
				String ext = originalFileName.substring(p).toLowerCase(); // .txt

				String prename = UUID.randomUUID().toString().replace("-","");
				
				String filename = prename+ext;
				boardFile.setBoardFileName(filename); // 이슈 >> 중복으로 인해 덮어쓰기 가능
				boardFile.setBoardId(board.getBoardId());
				boardFile.setBoardFileOriginalName(f.getOriginalFilename());
				boardFile.setBoardFileSize(f.getSize());
				boardFile.setBoardFileExt(f.getContentType());
				log.debug("boardfile :"+boardFile);
				
				boardFileMapper.insertBoardFile(boardFile);
				
				try {
					File temp = new File(""); // 프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath(); // 프로젝트필드
					f.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\board\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}
		}
		return board.getBoardId();
	}
	
	// board 삭제
	public int removeBoard(int boardId) {
		// 댓글 삭제
		int boardCommentRow = boardCommentMapper.deleteBoardCommentByBoard(boardId);
		log.debug("@@@@@ boardCommentRow: "+boardCommentRow);
		
		// 파일 삭제
		int boardFileRow = boardMapper.deleteBoardFileByBoard(boardId);
		log.debug("@@@@@ boardFileRow: "+boardFileRow);
		
		// 좋아요 삭제
		int boardLikeRow = boardMapper.deleteBoardLikeByBoard(boardId);
		log.debug("★★★☆○○○○★☆○☆★○ boardFileRow: "+boardFileRow);
		
		// 게시판 삭제
		int boardRow = boardMapper.deleteBoard(boardId);
		if(boardRow == 0) {
			return 0;
		}
		
		log.debug("@@@@@ boardRow :"+boardRow);
		
		return boardRow;
	}
	
	// board category 리스트
	public List<Map<String, Object>> getBoardCategoryList() {
		return boardMapper.selectBoardCategoryList();
	}
	
	// board 추가
	public void addBoard(BoardForm boardForm) {		
		Board board = boardForm.getBoard();
		log.debug("board: "+board.getBoardId());
		boardMapper.insertBoard(board); 
		// 입력시 만들어진 key값을 리턴받아야 한다. -> 리턴받을 수가 없다. -> 매개변수board의 boardId값을 변경해준다.
		log.debug("boardId"+board.getBoardId());
		
		// 2)
		List<MultipartFile> list = boardForm.getBoardFile();
		if(list != null) {
			for(MultipartFile f : list) {
				BoardFile boardFile = new BoardFile();
				boardFile.setBoardId(board.getBoardId()); // auto increment로 입력된 값
				
				String originalFileName = f.getOriginalFilename();
				int p = originalFileName.lastIndexOf("."); //test.txt면 4;
				String ext = originalFileName.substring(p).toLowerCase(); // .txt

				String prename = UUID.randomUUID().toString().replace("-","");
				
				String filename = prename+ext;
				boardFile.setBoardFileName(filename); // 이슈 >> 중복으로 인해 덮어쓰기 가능
				boardFile.setBoardId(board.getBoardId());
				boardFile.setBoardFileOriginalName(f.getOriginalFilename());
				boardFile.setBoardFileSize(f.getSize());
				boardFile.setBoardFileExt(f.getContentType());
				log.debug("boardfile :"+boardFile);
				
				boardFileMapper.insertBoardFile(boardFile);
				
				try {
					File temp = new File(""); // 프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath(); // 프로젝트필드
					f.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\board\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}			
		}
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
	public Map<String, Object> getBoardList(int currentPage, int rowPerPage, String searchWord, String searchSelect, int boardCategoryId){
	
		Map<String, Object> totalMap = new HashMap<>();	
		totalMap.put("searchWord", searchWord);
		totalMap.put("searchSelect", searchSelect);
		totalMap.put("boardCategoryId", boardCategoryId);
		
		int boardTotal = boardMapper.selectTotal(totalMap);
		int lastPage = (int)Math.ceil((double)boardTotal/rowPerPage);
		log.debug("@@@@@boardTotal: "+boardTotal);
		log.debug("@@@@@lastPage:"+lastPage);
		
		// 페이징
		int beginRow = (currentPage-1)*rowPerPage;
		
		//리스트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("paramMap", paramMap);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("searchWord", searchWord);
		paramMap.put("searchSelect", searchSelect);
		paramMap.put("boardCategoryId", boardCategoryId);
		log.debug("@@@@@ paramMap: "+paramMap);
		
		List<Map<String, Object>> boardList = boardMapper.selectBoardList(paramMap);
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("boardList", boardList);
		returnMap.put("lastPage", lastPage);
		log.debug("@@@@@ returnMap: "+returnMap);
		
		return returnMap;
	}
	
	// 게시글 좋아요 토탈
	public int getBoardLikeTotal(int boardId) {
		return boardMapper.selectBoardLikeTotal(boardId);
	}
	
	// 게시글 좋아요 했는지 안 했는지?
	public int getBoardLikeNow(String memberId, int boardId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("boardId", boardId);
		log.debug("@@@@@ map: "+map);
		
		return boardMapper.selectBoardLikeNow(map);
	}
	
	// 게시판 좋아요 취소
	public int removeBoardLike(int boardId, String memberId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("boardId", boardId);
		log.debug("@@@@@ map: "+map);
		
		return boardMapper.deleteBoardLike(map);
	}
}
