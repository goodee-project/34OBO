// 작성자 : 이윤정

package com.gd.obo.service;

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

	// staff 추가
	public int addStaff(Staff staff) {
		return staffMapper.insertStaff(staff);
	}
	
	// staff 정보 수정
	public int modifyStaff(Staff staff) {
		return staffMapper.updateStaff(staff);
	}
	
	
	// staff level 수정 -> 마스터 계정이 사이드 계정 접근 권한 준다.
	
}