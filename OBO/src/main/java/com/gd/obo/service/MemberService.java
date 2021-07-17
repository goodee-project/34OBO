//작성자: 손영현
package com.gd.obo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

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
	
	
	//카카오 로그인
	public Member getMemberByKakaoLogin(Member member) {
		return memberMapper.selectMemberByKakaoLogin(member);
	}
	
	//카카오 로그인을 위한 회원목록 조회
	public List<Map<String, Object>> getMemberListByKakaoId(String kakaoId){
		return memberMapper.selectMemberListByKakaoId(kakaoId);
	}
	
	
	//데이터 베이스에 카카오 아이디 저장하기
	public void	modifyMemberByKakao(String memberId , String kakaoId) {
		log.debug("■■■■■ updateMemberByKakao code param : " + kakaoId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("kakaoId", kakaoId);
		
		memberMapper.updateMemberByKakao(map);
	}
	
	/*
	//리프레쉬 토큰으로 액세스 토큰 갱신하기 -> 로그인할때마다 새로 토큰을 갱신받아서 필요없음
	public void getRenewalToken(String refreshToken) {
		log.debug("■■■■■ refreshToken code param : " + refreshToken);
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		
		//http body 생성! ..MultiValueMap은 키 하나에 여러 Value를 가질수 있게 해주는 Map인데 put이 없다..
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("grant_type", "refresh_token");
		param.add("client_id", "535757159a398fe468b3ed3f2d2032e4");
		param.add("refresh_token", refreshToken);
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(param, headers);
		
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		log.debug("■■■■■ response bodybody 토큰 : " + response.getBody());
	}
	*/
	
	//카카오 사용자 정보 가져오기
	public String getKakaoId(String accesToken) {
		log.debug("■■■■■ getKakaoId code param : " + accesToken);
		
		String kakaoId = null;
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "Bearer " + accesToken);
		
		
		//http body 생성! ..MultiValueMap은 키 하나에 여러 Value를 가질수 있게 해주는 Map인데 put이 없다..
		//MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		
		//header 와 body값을 담아네요 restTemplate 라이브러리를 이용하여 전송
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(null, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		//http요청하기-post 방식 - response 변수의 응답 받음
		//exchange : HTTP 헤더를 새로 만들 수 있고 어떤 HTTP 메서드(post, get ...)도 사용가능하다
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		log.debug("■■■■■ response 사용자정보 : " + response);
		log.debug("■■■■■ response bodybody 사용자정보 : " + response.getBody());
		
		
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		log.debug("■■■■■ kakaoResponse 확인확인확인: "+ kakaoResponse);
		
		kakaoId =  kakaoResponse.get("id").toString();
		
		log.debug("■■■■■ kakaoId : " + kakaoId);
		
		return kakaoId;
	}
	
	//카카오 연결 토큰얻기
	public String getKakaoToken(String code, String url) {
		
		log.debug("■■■■■ getKakaoToken code param : " + code);
		
		/*
		 * POST /oauth/token HTTP/1.1
			Host: kauth.kakao.com
			Content-type: application/x-www-form-urlencoded;charset=utf-8
		 */
		
		//RestTemplate: spring 3.0 부터 지원한다. 스프링에서 제공하는 http 통신에 유용하게 쓸 수 있는 템플릿
		//HttpsURLConnection도 사용가능
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		
		//http body 생성! ..MultiValueMap은 키 하나에 여러 Value를 가질수 있게 해주는 Map인데 put이 없다..
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("grant_type", "authorization_code");
		param.add("client_id", "535757159a398fe468b3ed3f2d2032e4");
		param.add("redirect_uri", url);
		param.add("code", code);
		
		//header 와 body값을 담아네요 restTemplate 라이브러리를 이용하여 전송
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(param, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		//http요청하기-post 방식 - response 변수의 응답 받음
		//exchange : HTTP 헤더를 새로 만들 수 있고 어떤 HTTP 메서드(post, get ...)도 사용가능하다
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		
		log.debug("■■■■■ response 토큰 : " + response);
		log.debug("■■■■■ response bodybody 토큰 : " + response.getBody());
		//response는 json 형식이므로 고쳐야함!
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		log.debug("■■■■■ kakaoResponse 확인확인확인: "+ kakaoResponse);
		
		String accesToken = (String)kakaoResponse.get("access_token");
		
		log.debug("■■■■■ accessToken : " + accesToken);
		
		/* 리프레쉬 토큰으로 액세스 토큰 다시 받기
		MemberService m = new MemberService();
		m.getRenewalToken(refreshToken);
		*/
		
		return accesToken;
	}
	
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
