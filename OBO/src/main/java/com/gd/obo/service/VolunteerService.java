//작성자 : 남궁혜영
package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.VolunteerMapper;
import com.gd.obo.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class VolunteerService {
	@Autowired VolunteerMapper volunteerMapper;
	
	//회원 일반봉사모집 목록
	public Map<String,Object> getVolunteerN(int currentPage, int rowPerPage, String searchWord, String categoryName) {
		
		int recruitTotal =  volunteerMapper.selectVolunteerNTotal(searchWord);
		int lastPage = (int)Math.ceil((double)recruitTotal/rowPerPage);
		log.debug("=====recruitTotal: "+recruitTotal);
		log.debug("=====lastPage:"+lastPage);
		
		// 페이징
		Page page = new Page();
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		paramMap.put("beginRow", beginRow);
		paramMap.put("categoryName", categoryName);
		
		List<Map<String, Object>> recruitList = volunteerMapper.selectVolunteerNList(paramMap);
		List<String> categoryNameList = volunteerMapper.selectVolunteerCategory();
		log.debug("=====recruitList: "+recruitList);
		log.debug("=====categoryNameList: "+categoryNameList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("recruitTotal", recruitTotal);
		map.put("lastPage", lastPage);
		map.put("recruitList", recruitList);
		map.put("categoryNameList", categoryNameList);
		return map;
	}
}
