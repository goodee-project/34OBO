package com.gd.obo.service;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.ShelterFileMapper;
import com.gd.obo.vo.ShelterFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ShelterFileService {
	@Autowired
	ShelterFileMapper shelterFileMapper;
	
	public int addShelterFile(MultipartFile multipartFile, int shelterId) {
		// 물리적 파일 저장
		File temp = new File("");
		
		// 프로젝트 경로
		String path = temp.getAbsolutePath();
		
		// 파일 이름
		String prename = UUID.randomUUID().toString().replace("-", "");
		
		// 파일 저장 위치
		File file = new File(path+"\\src\\main\\webapp\\static\\img\\shelter\\"+prename);
		
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			throw new RuntimeException();
		}
		
		// DB 저장
		ShelterFile shelterFile = new ShelterFile();
		log.debug("%>%>%>%>%>%>%>%>%> ShelterFileService-> addShelterFile shelterFile: " + shelterFile);
		
		shelterFile.setShelterId(shelterId);
		shelterFile.setShelterFileName(prename);
		shelterFile.setShelterFileSize(multipartFile.getSize());
		shelterFile.setShelterFileExt(multipartFile.getContentType());
		
		
		// return
		int row = shelterFileMapper.insertShelterFile(shelterFile);
		log.debug("%>%>%>%>%>%>%>%>%> ShelterFileService-> addShelterFile row: " + row);
		
		return row;
	}
}
