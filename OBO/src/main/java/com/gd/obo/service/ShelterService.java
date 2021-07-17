// 작성자: 김선유
// 수정자 : 남궁혜영(2021-07-16)
// 수정자 : 이윤정(2021-07-16) ; staff 회원가입시 -> 보호소 검색용
package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.AddressMapper;
import com.gd.obo.mapper.ShelterMapper;
import com.gd.obo.vo.Address;
import com.gd.obo.vo.Page;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.ShelterAddress;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ShelterService {
	@Autowired ShelterMapper shelterMapper;
	@Autowired AddressMapper addressMapper;
	
	// shelter 상세보기
	public Map<String, Object> getShelterOne(int shelterId) {
		// 상세보기
		Map<String, Object> shelterMap = shelterMapper.selectShelterOne(shelterId);
		log.debug("@@@@@shelterMap: "+shelterMap);
		
		return shelterMap;
	}
	
	// shelter 리스트,  staff 회원가입 -> 보호소 선택
	public Map<String, Object> getShelterList(int currentPage, int rowPerPage, String shelterName) {
		
		// shelter 개수
		Map<String, Object> totalMap = new HashMap<>();
		totalMap.put("shelterName", shelterName);
		
		int shelterTotal = shelterMapper.selectTotal(totalMap);
		int lastPage = (int)Math.ceil((double)shelterTotal/rowPerPage);
		log.debug("@@@@@shelterTotal: "+shelterTotal);
		log.debug("@@@@@lastPage:"+lastPage);
		
		// 페이징
		Page page = new Page();
		int beginRow = (currentPage-1)*rowPerPage;
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		log.debug("@@@@@Page: "+page);
		
		//리스트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("paramMap", paramMap);
		paramMap.put("currentPage", currentPage);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("shelterName", shelterName);
		log.debug("@@@@@ paramMap: "+paramMap);
		
		List<ShelterAddress> shelterList = shelterMapper.selectShelterList(paramMap);
		log.debug("shelterList"+shelterList);
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("shelterList", shelterList);
		returnMap.put("lastPage", lastPage);
		log.debug("@@@@@ returnMap: "+returnMap);
		
		return returnMap;
	}
	
	// staff 회원가입시 -> 보호소 검색용
	public List<Shelter> getShelterName(String searchWord){
		return shelterMapper.selectShelterName(searchWord);
	}
	
	//보호소 등록, 마스터계정 등록 코드 추가 해야 함.
	public int addShelter(Shelter shelter, Address address) {
		addressMapper.insertAddress(address);
		shelter.setAddressId(address.getAddressId());
		int row = shelterMapper.insertShelter(shelter);
		log.debug("===== 보호소 등록 row 값 : "+row);
		return row;
	}
	
}
