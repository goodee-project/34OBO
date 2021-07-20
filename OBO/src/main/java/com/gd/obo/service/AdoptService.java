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
	
	// 입양 신청 리스트
	public List<Map<String, Object>> getAdoptApplyList(int shelterId, String searchWord){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		log.debug("●●●●▶adoptApply map-> "+map);
		
		return adoptMapper.selectAdoptApplyList(map);
	}
	
	// 승인 완료 리스트
	public List<Map<String, Object>> getAdoptApprovalList(int shelterId, String searchWord, String selectOption){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("selectOption", selectOption);
		log.debug("●●●●▶adoptApproval map-> "+map);
		
		return adoptMapper.selectAdoptApprovalList(map);
	}
	
	// 승인 거절 리스트
	public List<Map<String, Object>> getAdoptRejectList(int shelterId, String searchWord){
		// map 변환
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		log.debug("●●●●▶adoptReject map-> "+map);
		
		return adoptMapper.selectAdoptRejectList(map);
	}
}
