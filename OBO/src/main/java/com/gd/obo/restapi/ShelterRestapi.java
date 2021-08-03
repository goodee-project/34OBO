package com.gd.obo.restapi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.ShelterFileService;
import com.gd.obo.service.ShelterService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class ShelterRestapi {
	@Autowired
	ShelterFileService shelterFileService;
	
	@GetMapping("/removeShelterFileOne")
	public int remove(@RequestParam(value="shelterFileId", required = true)int shelterFileId,
							@RequestParam(value="shelterFileName", required = true)String shelterFileName) {
		log.debug("■■■■■■■■ 보호소 파일 이름" + shelterFileName);
		return shelterFileService.removeShelterFileOne(shelterFileId, shelterFileName);
	}
}
