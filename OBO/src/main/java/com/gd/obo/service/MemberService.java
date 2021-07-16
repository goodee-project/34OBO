//작성자: 손영현
package com.gd.obo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.AddressMapper;
import com.gd.obo.mapper.MemberMapper;
import com.gd.obo.vo.Address;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.MemberAddress;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
@Transactional
public class MemberService {
	@Autowired
	MemberMapper memberMapper;
	@Autowired
	AddressMapper addressMapper;
	
	//member Pw변경
	public boolean modifyMemberPw(String memberId, String originalPw, String changedPw) {
		log.debug("■■■■■ modifyMemberPw mamberId param : " + memberId);
		log.debug("■■■■■ modifyMemberPw originalPw param : " + originalPw);
		log.debug("■■■■■ modifyMemberPw changedPw param : " + changedPw);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("originalPw", originalPw);
		map.put("changedPw", changedPw);
		
		boolean result = false; //성공 true, 실패 false
		
		if(memberMapper.updateMemberPw(map) != 0) {
			result = true;
		}
		
		return result;
	}
	
	//member 정보 업데이트
	public void modifyMemberOne(MemberAddress memberAddress) {
		log.debug("■■■■■ modifyMemberOne param : " + memberAddress);
		
		addressMapper.updateAddress(memberAddress.getAddress());
		memberMapper.updateMemberOne(memberAddress.getMember());
	}
	
	//회원 상세정보페이지
	public Map<String,Object> getMemeberOne(String memberId) {
		log.debug("■■■■■ getMemeberOne memeberId param: "+memberId);
		
		Map<String, Object> map = memberMapper.selectMemeberOne(memberId);
		log.debug("■■■■■ 상세정보 페이지 : " + map);
		
		return map;
	}
	
	//회원가입을 위한 memberId 중복검사
	public String getMemberIdByAddMember(String memberId) {
		log.debug("■■■■■ getMemberIdByAddMember param : " + memberId);
		
		return memberMapper.selectMemberIdByAddMember(memberId);
	}
	
	//member 회원가입
	public int addMember(MemberAddress memberAddress) {
		log.debug("■■■■■ addMember param : " + memberAddress);
		
		//address 입력
		Address address = memberAddress.getAddress();
		int addressRow = addressMapper.insertAddress(address);
		
		log.debug("■■■■■ addressId 받았는지 확인: " + address);
		
		//member 입력
		Member member = memberAddress.getMember();
		//멤버의 addressId에 받아온 addressId 추가
		member.setAddressId(address.getAddressId());
		
		log.debug("■■■■■ addressId 받았는지 확인: " + member);
		
		int memberRow = memberMapper.insertMember(member);
		
		return addressRow + memberRow;
	}
	
	//member 로그인 - 작성자: 손영현
	public Member getMemberByLogin(Member member) {
		log.debug("■■■■■ getMemberByLogin param: " + member);
		
		return memberMapper.selectMemberByLogin(member);
	}

}
