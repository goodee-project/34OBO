// 작성자 : 이윤정

package com.gd.obo.service;

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
	public List<Map<String, Object>> getAdoptApplyList(int shelterId, String searchWord){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		log.debug("●●●●▶adoptApply map-> "+map);
		
		return adoptMapper.selectAdoptApplyList(map);
	}
	
	// staff - 승인 완료 리스트 -> 검색 변수 포함
	public List<Map<String, Object>> getAdoptApprovalList(int shelterId, String searchWord, String selectOption){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("selectOption", selectOption);
		log.debug("●●●●▶adoptApproval map-> "+map);
		
		return adoptMapper.selectAdoptApprovalList(map);
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
	public List<Map<String, Object>> getAdoptRejectList(int shelterId, String searchWord){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		log.debug("●●●●▶adoptReject map-> "+map);
		
		return adoptMapper.selectAdoptRejectList(map);
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
}
