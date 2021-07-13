// 작성자 : 이윤정

package com.gd.obo.service.staff;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.staff.StaffMapper;
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
	
	// staff 상세보기
	
	// staff 추가
	
	// staff 리스트
}
