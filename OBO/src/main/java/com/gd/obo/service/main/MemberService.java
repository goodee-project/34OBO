//작성자: 손영현
package com.gd.obo.service.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.main.MemberMapper;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
@Transactional
public class MemberService {
	@Autowired
	MemberMapper memberMapper;
	
	//member 로그인 - 작성자: 손영현
	public Member getMemberByLogin(Member member) {
		log.debug("■■■■■ getMemberByLogin param: " + member);
		
		return memberMapper.selectMemberByLogin(member);
	}

}
