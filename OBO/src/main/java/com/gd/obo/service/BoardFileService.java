package com.gd.obo.service;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.BoardFileMapper;
import com.gd.obo.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardFileService {
	@Autowired BoardFileMapper boardFileMapper;
	
	public int addBoardFile(MultipartFile multipartFile, int boardId) {
		
		// 물리적 파일 저장
		File temp = new File("");
		
		// 프로젝트 경로
		String path = temp.getAbsolutePath();
		
		// 확장자
		int p = multipartFile.getOriginalFilename().lastIndexOf(".");
		String ext = multipartFile.getOriginalFilename().substring(p);
		
		// 파일 이름
		String prename = UUID.randomUUID().toString().replace("-", "");
		
		// 파일 저장 위치
		File file = new File(path+"\\src\\main\\webapp\\static\\img\\board\\"+prename+ext);
		
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			throw new RuntimeException();
		}
		
		// db 저장
		BoardFile boardFile = new BoardFile();
		boardFile.setBoardId(boardId);
		boardFile.setBoardFileName(prename+ext);
		boardFile.setBoardFileOriginalName(multipartFile.getOriginalFilename());
		boardFile.setBoardFileSize(multipartFile.getSize());
		boardFile.setBoardFileExt(multipartFile.getContentType());
		log.debug("@@@@@ boardFile: "+boardFile);
		
		int row = boardFileMapper.insertBoardFile(boardFile);
		log.debug("@@@@@ row: "+row);
		return row;
	}
	
	public int removeBoardFile(BoardFile boardFile) {
		
		// 물리 파일 삭제
		File temp = new File("");
		String path = temp.getAbsolutePath();
		File file = new File(path+"\\src\\main\\webapp\\static\\img\\board\\"+boardFile.getBoardFileName());
		
		if(file.exists()) {
			log.debug("@@@@@ file address: "+file);
			file.delete();
		}
		
		// DB 삭제
		int row = boardFileMapper.deleteBoardFile(boardFile.getBoardFileId());
		log.debug("@@@@@ row: "+row);
		return row;
	}
}
