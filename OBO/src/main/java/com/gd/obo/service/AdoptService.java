// 작성자 : 이윤정

package com.gd.obo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.AdoptMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class AdoptService {
	@Autowired AdoptMapper adoptMapper;
	
	// staff - 입양 신청 리스트
	public List<Map<String, Object>> getAdoptApplyList(int shelterId, String searchWord, String selectOption, int currentPage, int rowPerPage){
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("selectOption", selectOption);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ getAdoptApplyList map-> "+map);
		
		List<Map<String, Object>> list = adoptMapper.selectAdoptApplyList(map);
		log.debug("●●●●▶ getAdoptApplyList list-> "+list);		
		
		return list;
	}
	
	// staff - 승인 완료 리스트 -> 검색 변수 포함
	public List<Map<String, Object>> getAdoptApprovalList(int shelterId, String searchWord, String selectOption, int currentPage, int rowPerPage){
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("selectOption", selectOption);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ getAdoptApplyList map-> "+map);
		
		List<Map<String, Object>> list = adoptMapper.selectAdoptApprovalList(map);
		log.debug("●●●●▶ getAdoptApplyList list-> "+list);
		
		return list;
	}
	
	// staff - 입양 승인 후 care plan 작성해야 할 list - 보호소의 list만 가져온다
	public List<Map<String, Object>> getAdoptApprovalList(int shelterId){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		log.debug("●●●●▶careplan 작성 동물list map-> "+map);
		
		return adoptMapper.selectAdoptList(map);
	}
	
	// staff - 승인 거절 리스트
	public List<Map<String, Object>> getAdoptRejectList(int shelterId, String searchWord, int currentPage, int rowPerPage){
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ getAdoptRejectList map-> "+map);
		
		List<Map<String, Object>> list = adoptMapper.selectAdoptRejectList(map);
		log.debug("●●●●▶ getAdoptRejectList list-> "+list);
		
		return list;
	}
	
	// staff - 입양 승인 후 care plan 선택한 입양 정보 불러오기
	public List<Map<String, Object>> getAdoptList(int shelterId, int animalId){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("animalId", animalId);
		log.debug("●●●●▶careplan 작성할 동물 정보-> "+map);
		
		return adoptMapper.selectAdoptList(map);
	}
	
	// staff - 입양 신청 서류
	public List<Map<String, Object>> getAdoptDocumentOne(int documentId) {
		List<Map<String, Object>> list = adoptMapper.selectAdoptDocumentOne(documentId);
		log.debug("●●●●▶ 대기 신청 서류-> "+list);
		return list;
	}
	
	// staff - 입양 승인
	public int addAdopt(int adoptApplyId, String staffId) {
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("adoptApplyId", adoptApplyId);
		map.put("staffId", staffId);
		log.debug("●●●●▶adoptApprovalByStaff map-> "+map);
		
		return adoptMapper.insertAdopt(map);
	}
	
	// staff - 입양 거절
	public int modifyAdoptReject(int adoptApplyId) {
		return adoptMapper.updateAdoptReject(adoptApplyId);
	}
	
	// 회원 입양 폼
	public int addAdoptForm(String memberId, int animalId, String q1, String q3, String q8, String q14, String q16, String q17, String q18, String q19, String q20, String q21, String q23, String q24, String q25, String q27, String q29, String q34, String q35) {
		adoptMapper.insertAdoptDocument();
		int row = 0;
		int[] questionId = {1, 3, 8, 14, 16, 17, 18, 19, 20, 21, 23, 24, 25, 27, 29, 34, 35};
		String[] answer = {q1, q3, q8, q14, q16, q17, q18, q19, q20, q21, q23, q24, q25, q27, q29, q34, q35};
		log.debug("===== questionId:"+questionId);
		Map<String, Object> paramMap = new HashMap<>();
		for(int i=0; i<=questionId.length-1; i++) {
			paramMap.put("questionId",questionId[i]);
			paramMap.put("answer",answer[i]);
			row = adoptMapper.insertAdoptForm(paramMap);
		}
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("animalId", animalId);
		int row2 = adoptMapper.insertAdoptByMember(map);
		log.debug("===== map:"+map);
		log.debug("===== row:"+row);
		log.debug("===== row2:"+row2);
		return row;
	}
	
	//회원별 입양목록
	public List<Map<String, Object>> getAdoptListByMemberId(String memberId){
		log.debug("■■■■■■■■ getAdoptListByMemberId memberId :" + memberId);
		return adoptMapper.selectAdoptListByMemberId(memberId);
	}
	
	//회원별 동물 입양신청목록
	public Map<String, Object> getAdoptApplyListByMemberId(int currentPage, int rowPerPage, String memberId){
		log.debug("■■■■■■■ selectAdoptApplyListByMemberId currentPage param : " + currentPage);
		log.debug("■■■■■■■ selectAdoptApplyListByMemberId rowPerPage param : " + rowPerPage);
		log.debug("■■■■■■■ selectAdoptApplyListByMemberId memberId param : " + memberId);
		
		Map<String, Object> paramMap = new HashMap<>();
		int beginRow = (currentPage - 1)*rowPerPage;
		
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("memberId", memberId);
		
		List<Map<String, Object>> list = adoptMapper.selectAdoptApplyListByMemberId(paramMap);
		long total = (long)((Map<String, Object>)list.get(0)).get("total");
		
		log.debug("■■■■■■■ selectAdoptApplyListByMemberId total : " + total);
		
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("■■■■■■■ selectAdoptApplyListByMemberId lastPage : " + lastPage);
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("lastPage", lastPage);
		returnMap.put("list", list);
		
		return returnMap;
	}
 }
