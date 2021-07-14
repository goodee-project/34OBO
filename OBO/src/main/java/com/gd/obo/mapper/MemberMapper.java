//작성자 : 손영현
package com.gd.obo.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Member;



@Mapper
public interface MemberMapper {
	//로그인용 회원 조회- 패스워드와 아이디를 받음
	Member selectMemberByLogin(Member member);
}
