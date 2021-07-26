package com.gd.obo.service;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.AnimalFileMapper;
import com.gd.obo.vo.AnimalFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AnimalFileService {
	@Autowired
	AnimalFileMapper animalFileMapper;
	
	public int addAnimalFile(MultipartFile multipartFile, int animalId) {
		
		// 물리적 파일 저장
		File temp = new File("");
		
		// 프로젝트 경로
		String path = temp.getAbsolutePath();
		
		// 파일 이름
		String prename = UUID.randomUUID().toString().replace("-", "");
		
		// 파일 저장 위치
		File file = new File(path+"\\src\\main\\webapp\\static\\img\\animal\\"+prename);
		
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			throw new RuntimeException();
		}
		
		// DB 저장
		AnimalFile animalFile = new AnimalFile();
		animalFile.setAnimalId(animalId);
		animalFile.setAnimalFileName(prename);
		animalFile.setAnimalFileSize(multipartFile.getSize());
		animalFile.setAnimalFileExt(multipartFile.getContentType());
		log.debug("%>%>%>%>%>%>%>%>%> AnimalFileService-> addAnimalFile animalFile: " + animalFile);
		
		// return
		int row = animalFileMapper.insertAnimalFile(animalFile);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalFileService-> addAnimalFile row: " + row);
		
		return row;
	}
}
