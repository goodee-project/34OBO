//작성자 : 남궁혜영
package com.gd.obo.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.VolunteerMapper;
import com.gd.obo.vo.PeriodVolunteerCheck;
import com.gd.obo.vo.PeriodVolunteerRecruit;
import com.gd.obo.vo.VolunteerCheck;
import com.gd.obo.vo.VolunteerRecruit;

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
	
	//회원 봉사 지원 시 자격 확인
	public String getMemberQualification(String memberId, int recruitId, String categoryName) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("recruitId", recruitId);
		paramMap.put("categoryName", categoryName);
		log.debug("=====중복검사 입력 값: "+paramMap);
		return volunteerMapper.selectMemberQualification(paramMap);
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
	//회원 내정보 전체 봉사 시간
	public int getTotalVolunteerTimeByMember(String memberId) {
		int time = volunteerMapper.selectTotalVolunteerTimeByMember(memberId);
		log.debug("=====봉사 시간: "+time);
		return time;
	}
	
	//회원 내정보 전체 봉사 리스트
	public Map<String,Object> getFullVolunteerListByMember(int currentPage, int rowPerPage, String memberId) {
		// 페이징
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("memberId", memberId);
		
		List<Map<String, Object>> list = volunteerMapper.selectFullVolunteerListByMember(paramMap);
		log.debug("=====list: "+list);
		
		long total = 0;
		if(list.size()==0) {
			total = 0;
		} else {
			total = (long)((Map)list.get(0)).get("cnt");
		}
		
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("=====전체봉사 total: "+total);
		log.debug("=====전체봉사 lastPage:"+lastPage);

		Map<String, Object> map = new HashMap<>();
		map.put("lastPage", lastPage);
		map.put("list", list);
		return map;
	}
	
	//회원 내정보 일반 봉사 신청 리스트
	public Map<String,Object> getVolunteerApplyListByMember(int currentPage, int rowPerPage, String memberId) {
		// 페이징
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("memberId", memberId);
		
		List<Map<String, Object>> list = volunteerMapper.selectVolunteerApplyListByMember(paramMap);
		log.debug("=====list: "+list);
		
		long total = 0;
		if(list.size()==0) {
			total = 0;
		} else {
			total = (long)((Map)list.get(0)).get("cnt");
		}
		
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("=====일반봉사 total: "+total);
		log.debug("=====일반봉사 lastPage:"+lastPage);

		Map<String, Object> map = new HashMap<>();
		map.put("lastPage", lastPage);
		map.put("list", list);
		return map;
	}
	
	//회원 내정보 정기 봉사 전체 리스트
	public Map<String,Object> getVolunteerPListByMember(int currentPage, int rowPerPage, String memberId) {
		// 페이징
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("memberId", memberId);
		
		List<Map<String, Object>> list = volunteerMapper.selectVolunteerPListByMember(paramMap);
		log.debug("=====list: "+list);
		long total = 0;
		if(list.size()==0) {
			total = 0;
		} else {
			total = (long)((Map)list.get(0)).get("cnt");
		}
		
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("=====정기봉사 total: "+total);
		log.debug("=====정기봉사 lastPage:"+lastPage);

		Map<String, Object> map = new HashMap<>();
		map.put("lastPage", lastPage);
		map.put("list", list);
		return map;
	}
	
	//회원 내정보 일반 봉사 취소
	public int removeVolunteerByMember(String memberId, int applyId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("applyId", applyId);
		int row = volunteerMapper.deleteVolunteerApplyByMember(paramMap);
		log.debug("=====일반봉사 취소: "+row);
		return row;
	}
	
	//회원 내정보 정기 봉사 취소
	public int removeVolunteerPByMember(String memberId, int applyId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("applyId", applyId);
		int row = volunteerMapper.deleteVolunteerPByMember(paramMap);
		log.debug("=====정기봉사 취소: "+row);
		return row;
	}
	
	//회원 내정보 봉사 예정 목록
	public List<Map<String, Object>> getVolunteerCalByMember(String memberId){
		List<Map<String, Object>> nList = volunteerMapper.selectVolunteerCalByMember(memberId);
		log.debug("===== 일반 봉사 예정 리스트 : "+nList);

		return nList;
	}
	//회원 내정보 봉사 예정 목록
	public List<Map<String, Object>> getVolunteerPCalByMember(String memberId){
		List<Map<String, Object>> pList = volunteerMapper.selectVolunteerPCalByMember(memberId);
		log.debug("===== 정기 봉사 예정 리스트 : "+pList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("pList", pList);

		return pList;
	}
	
	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ staff @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	// 일반봉사 모집공고
	public List<Map<String, Object>> getVolunteerRecruitListInStaff(int shelterId, String searchWord, String searchSelect, String categoryName, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("categoryName", categoryName);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 일반봉사 모집공고-> "+map);
		
		List<Map<String, Object>> list = volunteerMapper.selectVolunteerRecruitListInStaff(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	// 일반봉사 신청목록
	public List<Map<String, Object>> getVolunteerApplyListInStaff(int shelterId, String searchWord, String searchSelect, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 일반봉사 신청목록-> "+map);
		
		List<Map<String, Object>> list = volunteerMapper.selectVolunteerApplyListInStaff(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	// 일반봉사 확인목록
	public List<Map<String, Object>> getVolunteerCheckListInStaff(int shelterId, String searchWord, String searchSelect, String categoryName, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("categoryName", categoryName);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 일반봉사 확인목록-> "+map);
		
		List<Map<String, Object>> list = volunteerMapper.selectVolunteerCheckListInStaff(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	
	// 정기봉사 모집공고
	public List<Map<String, Object>> getPeriodVolunteerRecruitListInStaff(int shelterId, String searchWord, String searchSelect, String categoryName, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("categoryName", categoryName);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 정기봉사 모집공고-> "+map);
		
		List<Map<String, Object>> list = volunteerMapper.selectPeriodVolunteerRecruitListInStaff(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	// 정기봉사 신청목록
	public List<Map<String, Object>> getPeriodVolunteerApplyListInStaff(int shelterId, String searchWord, String searchSelect, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 정기봉사 신청목록-> "+map);
		
		List<Map<String, Object>> list = volunteerMapper.selectPeriodVolunteerApplyListInStaff(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	// 정기봉사 확인목록
	public List<Map<String, Object>> getPeriodVolunteerCheckListInStaff(int shelterId, String searchWord, String searchSelect, String categoryName, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("categoryName", categoryName);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 정기봉사 확인목록-> "+map);
		
		List<Map<String, Object>> list = volunteerMapper.selectPeriodVolunteerCheckListInStaff(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	// 봉사 카테고리 목록
	public List<Map<String, Object>> getVolunteerCategoryList(){
		return volunteerMapper.selectVolunteerCategoryList();
	}
	
	// 일반봉사 모집공고 상세보기
	public List<Map<String, Object>> getVolunteerRecruitOne(int volunteerRecruitId){
		return volunteerMapper.selectVolunteerRecruitOne(volunteerRecruitId);
	}
	
	// 정기봉사 모집공고 상세보기
	public List<Map<String, Object>> getPeriodVolunteerRecruitOne(int periodVolunteerRecruitId){
		return volunteerMapper.selectPeriodVolunteerRecruitOne(periodVolunteerRecruitId);
	}
	
	// 일반봉사 모집공고 등록
	public int addVolunteerRecruit(VolunteerRecruit recruit) {
		return volunteerMapper.insertVolunteerRecruit(recruit);
	}
	
	// 정기봉사 모집공고 등록
	public int addPeriodVolunteerRecruit(PeriodVolunteerRecruit recruit) {
		return volunteerMapper.insertPeriodVolunteerRecruit(recruit);
	}
	
	// 일반봉사 확인완료
	public int addVolunteerCheck(VolunteerCheck check) {
		return volunteerMapper.insertVolunteerCheck(check);
	}
	
	// 정기봉사 확인완료
	public int addPeriodVolunteerCheck(PeriodVolunteerCheck check) {
		return volunteerMapper.insertPeriodVolunteerCheck(check);
	}
}
