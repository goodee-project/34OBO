package com.gd.obo.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.QualificationService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class QualificationRestapi {
	@Autowired
	QualificationService qualificationService;
	
	@GetMapping("/member/getVolunteerByQualificationTypeId")
	public List<Map<String, Object>> getVolunteerByQualificationTypeId(@RequestParam(value = "qualificationTypeId", required = true)int qualificationTypeId){
		log.debug("■■■■■■ qualificationTypeId : " + qualificationTypeId);
		
		return qualificationService.getVolunteerByQualificationTypeId(qualificationTypeId);
	}

}
