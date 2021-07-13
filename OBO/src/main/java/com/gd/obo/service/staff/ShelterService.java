// 작성자 : 이윤정

package com.gd.obo.service.staff;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.staff.ShelterMapper;
import com.gd.obo.vo.Shelter;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class ShelterService {
	@Autowired ShelterMapper shelterMapper;
	
	// staff 회원가입 -> 보호소 선택
	public List<Shelter> getShelterList() {
		return shelterMapper.selectShelterList();
	}
}
