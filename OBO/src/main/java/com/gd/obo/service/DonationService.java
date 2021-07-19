// 작성자 : 이윤정
// 수정자 : 손영현(2021.07.17) ; 카카오페이 결제준비, 결제승인 매소드

package com.gd.obo.service;

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

import com.gd.obo.mapper.DonationMapper;
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.PeriodicallyDonation;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class DonationService {
	@Autowired DonationMapper donationMapper;
	
	
	private DonationMoneyList donationML;//kakao 결제준비단계가 아닌 결제 승인단계에서 데이터베이스로 정보 넘기기위에 만들었습니다.	
	private String tid;//kakao 결제준비 -> 결제승인으로 갈때 필요한것... (get방식이라 보내기 힘들어서 위에 만들었습니다.)
	
	
	// 단기결제 데이터베이스에 결과 남기기!
	public void addDonationMoneyList() {
		donationMapper.insertDonationMoneyList(donationML);
	}
	
	// kakao 결제승인
	public Map<String, Object> confirmKakoPay(String pg_token) {
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "KakaoAK " + "5de9e80d86eb5dbafa13ba3128b18925");
		
		//http body
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("cid", "TC0ONETIME");//가맹점 코드 - 테스트 코드
		param.add("tid", tid);//상품명
		param.add("partner_order_id", "partner_order_id");//가맹점 주문번호: 결제준비 API 요청과 일치해야함
		param.add("partner_user_id", donationML.getMemberId());//가맹점 회원
		param.add("pg_token", pg_token);//pg_token
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(param, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v1/payment/approve", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		log.debug("■■■■■ response 결제승인 : " + response);
		log.debug("■■■■■ response bodybody 결제승인 : " + response.getBody());
		
		
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		log.debug("■■■■■ kakaoResponse 결제준비 결과: "+ kakaoResponse);
		
		
		return kakaoResponse;
	}
	
	// kakao 결제 준비!
	public Map<String,Object> readyKakaoPay(DonationMoneyList donationMoneyList, String url) {
		log.debug("■■■■■ donationByKakaoPay amount param : " + donationMoneyList);
		donationML = donationMoneyList;
		
		/*
		 * curl -v -X POST "https://kapi.kakao.com/v1/payment/ready" \
			-H "Authorization: KakaoAK {APP_ADMIN_KEY}" \
			--data-urlencode "cid=TC0ONETIME" \
			--data-urlencode "partner_order_id=partner_order_id" \
			--data-urlencode "partner_user_id=partner_user_id" \
			--data-urlencode "item_name=초코파이" \
			--data-urlencode "quantity=1" \
			--data-urlencode "total_amount=2200" \
			--data-urlencode "vat_amount=200" \
			--data-urlencode "tax_free_amount=0" \
			--data-urlencode "approval_url=https://developers.kakao.com/success" \
			--data-urlencode "fail_url=https://developers.kakao.com/fail" \
			--data-urlencode "cancel_url=https://developers.kakao.com/cancel"
		 * 
		 */
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "KakaoAK " + "5de9e80d86eb5dbafa13ba3128b18925");
		
		//http body
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("cid", "TC0ONETIME");//가맹점 코드 - 테스트 코드
		param.add("partner_order_id", "partner_order_id");//가맹점 주문번호 -> 쓸거없다...
		param.add("partner_user_id", donationMoneyList.getMemberId());//가맹점 회원
		param.add("item_name", "상품명");//상품명
		param.add("quantity", "1");//상품수량
		param.add("total_amount", Integer.toString(donationMoneyList.getAmount()));//상품 총액
		param.add("tax_free_amount", "0");//상품 비과세 금액
		param.add("approval_url", url);//결제 성공 시 redirect url
		param.add("cancel_url", "http://localhost/obo/");//결제 취소 시 redirect url
		param.add("fail_url", "http://localhost/obo/");//결제 실패 시 redirect url
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(param, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v1/payment/ready", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		log.debug("■■■■■ response 결제준비 : " + response);
		log.debug("■■■■■ response bodybody 결제준비 : " + response.getBody());
		
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		log.debug("■■■■■ kakaoResponse 결제준비 결과: "+ kakaoResponse);
		
		tid = (String)kakaoResponse.get("tid");
		
		return kakaoResponse;
	}
	
	// staff - 물품 후원 조회
	public List<DonationItemList> getDonationItemList(int shelterId){
		return donationMapper.selectDonationItemList(shelterId);
	}
	
	// staff - 돈 후원 조회
	public List<DonationMoneyList> getDonationMoneyNList(int shelterId){
		return donationMapper.selectDonationMoneyNList(shelterId);
	}
	
	// staff - 정기 후원 조회
	public List<PeriodicallyDonation> getDonationMoneyPList(int shelterId){
		return donationMapper.selectDonationMoneyPList(shelterId);
	}
}
