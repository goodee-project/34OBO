//작성자 : 남궁혜영
package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.mapper.QualificationMapper;
import com.gd.obo.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Slf4j
public class QualificationService {
	@Autowired QualificationMapper qualificationMapper;
	//자격 승인 내역
	public Map<String, Object> getQualificationApprovalList(int currentPage, int rowPerPage, String searchWord){
		
		Page page = new Page();
		int beginRow = (currentPage-1)*rowPerPage;
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		int total = qualificationMapper.selectQualificationApprovalListTotal(page);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("===== total 값 : "+total);
		log.debug("===== lastPage 값 : "+lastPage);
		log.debug("===== page 값 : "+page);
		
		List<Map<String, Object>> list = qualificationMapper.selectQualificationApprovalList(page);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("page", page);
		log.debug("======자격 승인 리스트 : "+list);
		return map;
	}
	
	//자격 신청 내역
	public Map<String, Object> getQualificationApplicationList(int currentPage, int rowPerPage, String searchWord){
		
		Page page = new Page();
		int beginRow = (currentPage-1)*rowPerPage;
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		int total = qualificationMapper.selectQualificationApplicationListTotal(page);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("===== total 값 : "+total);
		log.debug("===== lastPage 값 : "+lastPage);
		log.debug("===== page 값 : "+page);
		
		List<Map<String, Object>> list = qualificationMapper.selectQualificationApplicationList(page);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("page", page);
		log.debug("======자격 신청 리스트 : "+list);
		return map;
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
