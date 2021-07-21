//작성자 : 남궁혜영
package com.gd.obo.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
		
		Map<String, Object> totMap = new HashMap<>();
		totMap.put("searchWord", searchWord);
		totMap.put("categoryName", categoryName);
		int recruitTotal =  volunteerMapper.selectVolunteerNTotal(totMap);
		int lastPage = (int)Math.ceil((double)recruitTotal/rowPerPage);
		log.debug("=====recruitTotal: "+recruitTotal);
		log.debug("=====lastPage:"+lastPage);
		
		// 페이징
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
		
		//날짜 형식 변경
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		//날짜 비교를 위한 코드
		Calendar cal = Calendar.getInstance();
		String currentDate = sdf.format(cal.getTime());
		
		log.debug("===== 현재날짜 : "+currentDate);
		
		Map<String, Object> map = new HashMap<>();
		map.put("recruitTotal", recruitTotal);
		map.put("lastPage", lastPage);
		map.put("recruitList", recruitList);
		map.put("categoryNameList", categoryNameList);
		map.put("currentDate", currentDate);
		return map;
	}
	//회원 일반봉사모집 지원
	public int addVolunteerNApply(String memberId, int recruitId){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("recruitId", recruitId);
		log.debug("=====입력 값: "+paramMap);
		
		int row = volunteerMapper.insertVolunteerApplyByMember(paramMap);
		log.debug("=====봉사 신청 row: "+row);
		
		return row;
	}
	
	//회원 일방봉사 지원 시 중복 확인
	public String getMemberIdForCheckApplying(String memberId, int recruitId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("recruitId", recruitId);
		log.debug("=====중복검사 입력 값: "+paramMap);
		return volunteerMapper.selectMemberIdForCheckApplying(paramMap);
	}
	
	//회원 정기봉사모집 목록
		public Map<String,Object> getVolunteerP(int currentPage, int rowPerPage, String searchWord, String categoryName) {
			Map<String, Object> totMap = new HashMap<>();
			totMap.put("searchWord", searchWord);
			totMap.put("categoryName", categoryName);
			int recruitTotal =  volunteerMapper.selectVolunteerPTotal(totMap);
			
			int lastPage = (int)Math.ceil((double)recruitTotal/rowPerPage);
			log.debug("=====recruitTotal: "+recruitTotal);
			log.debug("=====lastPage:"+lastPage);
			
			// 페이징
			int beginRow = (currentPage-1)*rowPerPage;
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("rowPerPage", rowPerPage);
			paramMap.put("searchWord", searchWord);
			paramMap.put("beginRow", beginRow);
			paramMap.put("categoryName", categoryName);
			
			List<Map<String, Object>> recruitList = volunteerMapper.selectVolunteerPList(paramMap);
			List<String> categoryNameList = volunteerMapper.selectVolunteerCategory();
			log.debug("=====recruitList: "+recruitList);
			log.debug("=====categoryNameList: "+categoryNameList);
			
			//날짜 형식 변경
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
			//날짜 비교를 위한 코드
			Calendar cal = Calendar.getInstance();
			String currentDate = sdf.format(cal.getTime());
			
			log.debug("===== 현재날짜 : "+currentDate);
			
			Map<String, Object> map = new HashMap<>();
			map.put("recruitTotal", recruitTotal);
			map.put("lastPage", lastPage);
			map.put("recruitList", recruitList);
			map.put("categoryNameList", categoryNameList);
			map.put("currentDate", currentDate);
			return map;
		}
	//회원 정기봉사 지원 시 중복 확인
	public String getMemberIdForCheckApplyingP(String memberId, int recruitId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("recruitId", recruitId);
		log.debug("=====중복검사 입력 값: "+paramMap);
		return volunteerMapper.selectMemberIdForCheckApplyingP(paramMap);
	}
	
	//회원 정기 봉사모집 지원
	public int addVolunteerPApply(String memberId, int recruitId, String determination){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("recruitId", recruitId);
		paramMap.put("determination", determination);
		log.debug("=====입력 값: "+paramMap);
		
		int row = volunteerMapper.insertPeriocallyVolunteerApplyByMember(paramMap);
		log.debug("=====정기 봉사 신청 row: "+row);
		
		return row;
	}
}
