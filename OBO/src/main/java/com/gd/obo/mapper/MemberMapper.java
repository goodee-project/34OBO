//작성자 : 손영현
package com.gd.obo.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Member;



@Mapper
public interface MemberMapper {
	//비밀번호 수정
	int updateMemberPw(Map<String, Object> map);
	//member 정보수정
	int updateMemberOne(Member member);
	//회원 정보페이지
	Map<String,Object> selectMemeberOne(String memberId);
	//memeberId 중복검사
	String selectMemberIdByAddMember(String memberId);
	//member 회원가입
	int insertMember(Member member);
	//로그인용 회원 조회- 패스워드와 아이디를 받음
	Member selectMemberByLogin(Member member);
}
