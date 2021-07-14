//작성자 : 남궁혜영
package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.QualificationMapper;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Slf4j
public class QualificationService {
	@Autowired QualificationMapper qualificationMapper;
	//자격 승인 내역
	public List<Map<String, Object>> getQualificationApprovalList(){
		List<Map<String, Object>> list = qualificationMapper.selectQualificationApprovalList();
		log.debug("======자격 승인 리스트 : "+list);
		return list;
	}
	
	//자격 신청 내역
	public List<Map<String, Object>> getQualificationApplicationList(){
		List<Map<String, Object>> list = qualificationMapper.selectQualificationApplicationList();
		log.debug("======자격 신청 리스트 : "+list);
		return list;
	}
	
	//자격 신청 승인
	public int addApproveApplication(String managerId, int applicationId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("managerId", managerId);
		paramMap.put("applicationId", applicationId);
		int row = qualificationMapper.InsertApproveQualificationApplication(paramMap);
		log.debug("======자격 신청 승인 row : "+row);
		log.debug("======자격 신청 승인 param : "+paramMap);
		return row;
	}
	
	//자격 신청 거절
	public int addRejectApplication(String managerId, int applicationId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("managerId", managerId);
		paramMap.put("applicationId", applicationId);
		int row = qualificationMapper.InsertRejectQualificationApplication(paramMap);
		log.debug("======자격 신청 거절 row : "+row);
		log.debug("======자격 신청 거절 param : "+paramMap);
		return row;
	}
}
