// 작성자 : 이윤정
// 수정자 : 남궁혜영(2021-07-16)

package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.StaffMapper;
import com.gd.obo.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class StaffService {
	@Autowired StaffMapper staffMapper;
	
	// staff 로그인 정보
	public Staff login(Staff staff) {
		log.debug("●●●●▶loginStaff param: " + staff);
		return staffMapper.selectStaffByLogin(staff);
	}
	
	// staff 로그인 유효성 검사
	public int checkStaffLogin(Staff staff) {
		return staffMapper.selectStaffLoginCk(staff);
	}
	
	// staff account
	public Map<String, Object> getStaffAccount(String staffId, int shelterId){
		log.debug("●●●●▶staffId: " + staffId);
		log.debug("●●●●▶shelterId: " + shelterId);
		
		//상세보기 정보, 승인 대기 staff 정보 가져오기
		Staff staffOne = staffMapper.selectStaffOne(staffId);
		List<Staff> staffLevel0 = staffMapper.selectStaffLevel0(shelterId);
		log.debug("●●●●▶staffOne: " + staffOne);
		log.debug("●●●●▶staffLevel0: " + staffLevel0);
		
		Map<String, Object> map = new HashMap<>();
		map.put("staffOne", staffOne);
		map.put("staffLevel0", staffLevel0);
		
		return map;
	}
	
	// staff 상세보기
	public Staff getStaffOne(String staffId) {
		return staffMapper.selectStaffOne(staffId);
	}

	// staff 추가
	public int addStaff(Staff staff) {
		log.debug("===== add staff:"+staff);
		return staffMapper.insertStaff(staff);
	}
	
	// 마스터 staff 추가
	public int addMasterStaff(Staff staff) {
		log.debug("===== add staff:"+staff);
		return staffMapper.insertMasterStaff(staff);
	}
	
	// staff account 확인 -> Id 중복확인 + 계정 수정시 pw일치확인
	public int getStaffAccountCheck(String staffId, String staffPw) {
		return staffMapper.selectStaffIdCheck(staffId, staffPw);
	}
	
	// staff 정보 수정
	public int modifyStaff(Staff staff) {
		return staffMapper.updateStaff(staff);
	}
	
	// staff 간단한 정보 보기 -> 마스터 계정만 가능
	public List<Map<String, Object>> getStaffListByMaster(int shelterId) {
		return staffMapper.selectStaffListByMaster(shelterId);
	}
	
	// staff level 수정 -> 마스터 계정이 사이드 계정 접근 권한 준다.
	public int modifyStaffState(Integer staffLevel, Integer staffActive, String staffId) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("staffLevel", staffLevel);
		map.put("staffActive", staffActive);
		map.put("staffId", staffId);
		
		log.debug("●●●●▶변경할 정보-> "+map);
		
		return staffMapper.updateStaffState(map);
	}
}
