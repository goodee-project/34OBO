// 작성자 : 이윤정
// 수정자 : 손영현(2021.07.17) ; 카카오페이 결제준비, 결제승인 매소드, 후원 끊기 등..

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

import com.gd.obo.mapper.DonationMapper;
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.ItemCategory;
import com.gd.obo.vo.PeriodicallyDonation;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class DonationService {
	@Autowired DonationMapper donationMapper;
	
	
	private DonationMoneyList donationML;//kakao 결제준비단계가 아닌 결제 승인단계에서 데이터베이스로 정보 넘기기위에 만들었습니다.	
	private String tid;//kakao 결제준비 -> 결제승인으로 갈때 필요한것... (get방식이라 보내기 힘들어서 위에 만들었습니다.)
	private String sid;
	
	//년도의 달별 후원 받은 돈
	public List<Map<String, Object>> getFullDonationTotalByMonth(int year, int shelterId, String memberId) {
		log.debug("■■■■■ getFullDonationTotalByMonth year param : " + year);
		log.debug("■■■■■ getFullDonationTotalByMonth shelterId param : " + shelterId);
		log.debug("■■■■■ getFullDonationTotalByMonth memberId param : " + memberId);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("year", year);
		paramMap.put("shelterId", shelterId);
		paramMap.put("memberId", memberId);
		
		return donationMapper.selectFullDonationTotalByMonth(paramMap);
	}
	
	//main home에 달에 들어온 전체 후원금 구하기
	public long getTotalDonationByMonth(int month) {
		log.debug("■■■■■ getTotalDonationByMonth month param : " + month);
		
		Long totalDonation = donationMapper.selectTotalDonationByMonth(month);
		
		if(totalDonation == null) {
			totalDonation = 0L;
		}
		//이슈 이번달 후원금이 없으니까 null 이므로 error
		log.debug("■■■■■ getTotalDonationByMonth totalDonation : " + totalDonation);
		
		return totalDonation;
	}
	
	//내정보 물품내역 자세히 보기
	public Map<String, Object> getDonationItemOne(int donationItemListId){
		log.debug("■■■■■ getDonationItemOne param : " + donationItemListId);
		
		return donationMapper.selectDonationItemOne(donationItemListId);
	}
	
	
	//내정보 물품후원내역
	public Map<String, Object> getDonationItemByMemberId(int currentPage, int rowPerPage, String memberId){
		Map<String, Object> paramMap = new HashMap<>();
		int beginRow = (currentPage - 1)*rowPerPage;
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("memberId", memberId);
		
		int total = donationMapper.selectDonationItemByMemberIdTotal(memberId);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		
		log.debug("■■■■■ getDonationItemByMemberId total : "+total);
		log.debug("■■■■■ getDonationItemByMemberId lastPage : "+lastPage);
		
		List<Map<String, Object>> list = donationMapper.selectDonationItemByMemberId(paramMap);
		log.debug("■■■■■ getDonationItemByMemberId list : "+list);
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("list", list);
		returnMap.put("lastPage", lastPage);
		
		return returnMap;
	}
	
	
	//물품후원 insert
	public boolean addDonationItemList(DonationItemList donationItemList) {
		boolean result = false;
		
		log.debug("■■■■■ addDonationItemList param : "+donationItemList);
		if(donationMapper.insertDonationItemList(donationItemList) != 0) {
			result = true;
		}
		
		log.debug("■■■■■ addDonationItemList result : " + result);
		
		return result;
	}
	
	//물품카테고리 가져오기
	public List<ItemCategory> getItemCategoryList(){
		return donationMapper.selectItemCategoryList();
	}
	
	//내정보 -> 총 후원금액
	public int getTotalMoneyByMemberId(String memberId) {
		return donationMapper.selectTotalMoneyByMemberId(memberId);
	}
	
	//내정보 -> (정기+일반) 후원내역 목록
	public Map<String, Object> getFullMoneyDonationListByMemberId(int currentPage, int rowPerPage, String memberId){
		Map<String, Object> paramMap = new HashMap<>();
		int beginRow = (currentPage - 1)*rowPerPage;
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("memberId", memberId);
		
		int total = donationMapper.selectFullMoneyDonationListByMemberIdTotal(memberId);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		
		log.debug("■■■■■ getFullMoneyDonationListByMemberId total : "+total);
		log.debug("■■■■■ getFullMoneyDonationListByMemberId lastPage : "+lastPage);
		
		List<Map<String, Object>> list = donationMapper.selectFullMoneyDonationListByMemberId(paramMap);
		log.debug("■■■■■ getFullMoneyDonationListByMemberId list : "+list);
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("list", list);
		returnMap.put("lastPage", lastPage);
		
		return returnMap;		
	}
	
	//내정보 -> 정기후원
	public Map<String, Object> getPeriodicallyDonationByMemberId(int currentPage, int rowPerPage, String memberId){
		Map<String, Object> paramMap = new HashMap<>();
		int beginRow = (currentPage - 1)*rowPerPage;
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("memberId", memberId);
		
		int total = donationMapper.selectPeriodicallyDonationByMemberIdTotal(memberId);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		
		log.debug("■■■■■ selectPeriodicallyDonationByMemberId total : "+total);
		log.debug("■■■■■ selectPeriodicallyDonationByMemberId lastPage : "+lastPage);
		
		List<Map<String, Object>> list = donationMapper.selectPeriodicallyDonationByMemberId(paramMap);
		log.debug("■■■■■ selectPeriodicallyDonationByMemberId list : "+list);
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("list", list);
		returnMap.put("lastPage", lastPage);
		
		return returnMap;
		
	}
	
	/*
	//내정보-> 정기후원목록 , 총 후원목록 getMemberDonation 필요없을듯..?
	public Map<String, Object> getMemberDonation(String memberId){
	
		Map<String, Object> map = new HashMap<>();
		map.put("PeriodicallyDonationList", donationMapper.selectPeriodicallyDonationByMemberId(memberId));
		map.put("fullDonationList", donationMapper.selectFullMoneyDonationListByMemberId(memberId));
		
		return map;
	}
	*/
	
	//정기결제 끊기 구현!
	public void modifyPeriodicallyDonationListByKakaoPayStop(int periodicallyDonationId) {
		//sid 구하기
		String sid = donationMapper.selectPeriodicallyDonationByPeriodicallyDonationId(periodicallyDonationId);
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "KakaoAK " + "5de9e80d86eb5dbafa13ba3128b18925");
		
		//http body
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("cid", "TCSUBSCRIP");//가맹점 코드 - 테스트 코드
		param.add("sid", sid);//sid
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(param, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v1/payment/manage/subscription/inactive", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		log.debug("■■■■■ response 결제끊기 : " + response);
		log.debug("■■■■■ response bodybody 결제끊기 : " + response.getBody());
		
		
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		log.debug("■■■■■ kakaoResponse 정기결제끊기 updatePeriodicallyDonationListByKakaoPayStop 결과: "+ kakaoResponse);
		
		donationMapper.updatePeriodicallyDonationByEndDate(periodicallyDonationId);
	}
	
	
	// 정기후원 : 매월 카카오 정기결제
	public boolean addPeriodicallyDonationListByKakaoPay(PeriodicallyDonation periodicallyDonation) {
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "KakaoAK " + "5de9e80d86eb5dbafa13ba3128b18925");
		
		//http body
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("cid", "TCSUBSCRIP");//가맹점 코드 - 테스트 코드
		param.add("sid", periodicallyDonation.getSid());//sid
		param.add("partner_order_id", Integer.toString(periodicallyDonation.getShelterId()));//가맹점주문번호
		param.add("partner_user_id", periodicallyDonation.getMemberId());//가맹점 회원번호
		param.add("quantity", "1");//상품수량
		param.add("total_amount", Integer.toString(periodicallyDonation.getAmount()));//상품총액
		param.add("tax_free_amount", "0");//상품 비과세 금액
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(param, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v1/payment/subscription", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		log.debug("■■■■■ response 결제승인 : " + response);
		log.debug("■■■■■ response bodybody 결제승인 : " + response.getBody());
		
		
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		log.debug("■■■■■ kakaoResponse 정기결제 결과: "+ kakaoResponse);
		
		if(kakaoResponse.containsKey("msg")) {//msg를 포함하면 결제 실패 -> 이메일 보내기????
			
			return false;
		} else {//결제 성공! -> 데이터 베이스에 저장
			donationMapper.insertPeriodicallyDonationList(periodicallyDonation.getPeriodicallyDonationId());
			return true;
		}
	}
	
	//정기후원하기위한 리스트 출력
	public List<PeriodicallyDonation> getPeriodicallyDonationBYEndDateISNULL() {
		//정기결제 중인 리스트 출력
		return donationMapper.selectPeriodicallyDonationBYEndDateISNULL();		
	}
	
	//정기결제 데이터베이스에 결과 남기기! - 1회차일때는 무조건 0원으로하므로 정기결제 결제기록에 남길필요 없습니다.
	public void addPeriodicallyDonation() {
		PeriodicallyDonation periodicallyDonation = new PeriodicallyDonation();
		
		periodicallyDonation.setAmount(donationML.getAmount());
		periodicallyDonation.setMemberId(donationML.getMemberId());
		periodicallyDonation.setShelterId(donationML.getShelterId());
		periodicallyDonation.setSid(sid);
		//정기결제에 등록
		donationMapper.insertPeriodicallyDonation(periodicallyDonation);
		//정기결제 결제기록 - sid가 언제 들어갈 건지 확인할 필요가 있음...
		
	}
	
	
	// 단기결제 데이터베이스에 결과 남기기!
	public void addDonationMoneyList() {
		donationMapper.insertDonationMoneyList(donationML);
	}
	
	// kakao 결제승인
	public Map<String, Object> confirmKakoPay(String pg_token, String cid) {
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "KakaoAK " + "5de9e80d86eb5dbafa13ba3128b18925");
		
		//http body
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("cid", cid);//가맹점 코드 - 테스트 코드
		param.add("tid", tid);//결제 고유 번호, 20자 : 결제준비에서 받아와야함!
		param.add("partner_order_id", Integer.toString(donationML.getShelterId()));//가맹점 주문번호: 결제준비 API 요청과 일치해야함
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
		
		if(cid.equals("TCSUBSCRIP")) {
		sid = (String)kakaoResponse.get("sid");
		}
		
		return kakaoResponse;
	}
	
	// kakao 결제 준비! :cid -> 정기결제면 TCSUBSCRIP, 일반결제면 TC0ONETIME
	public Map<String,Object> readyKakaoPay(DonationMoneyList donationMoneyList, String url, String itemName, String cid) {
		log.debug("■■■■■ donationByKakaoPay amount param : " + donationMoneyList);
		donationML = donationMoneyList;
		
		String amount = Integer.toString(donationMoneyList.getAmount());
		
		//정기결제의 경우 sid 발급을 위해 첫 결제의 amount는 0으로 한다!
		if(cid.equals("TCSUBSCRIP")) {
			amount = "0";
		}
		
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Authorization", "KakaoAK " + "5de9e80d86eb5dbafa13ba3128b18925");
		
		//http body
		MultiValueMap<String, String> param = new LinkedMultiValueMap<>();
		param.add("cid", cid);//가맹점 코드 - 테스트 코드
		param.add("partner_order_id", Integer.toString(donationMoneyList.getShelterId()));//가맹점 주문번호 -> 보호소ID로 대체했음
		param.add("partner_user_id", donationMoneyList.getMemberId());//가맹점 회원
		param.add("item_name", itemName);//상품명
		param.add("quantity", "1");//상품수량
		param.add("total_amount", amount);//상품 총액
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
	public Map<String, Object> getDonationItemList(int shelterId, String searchWord, String searchSelect, String itemCategoryName, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		//list 얻기 위한 map setting
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("searchSelect", searchSelect);
		map.put("itemCategoryName", itemCategoryName);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 물품 후원 map-> "+map);
		
		List<Map<String, Object>> donationItemList = donationMapper.selectDonationItemList(map);
		List<ItemCategory> itemCategoryList = donationMapper.selectItemCategoryList();

		//lastPage 구하기
		int totalRow = 0;
		if(donationItemList.size() != 0) {
			totalRow = Integer.parseInt(donationItemList.get(0).get("totalRow").toString());
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("●●●●▶ totalRow: "+totalRow);
		log.debug("●●●●▶ lastPage: "+lastPage);
		
		//컨트롤러로 보낼 map
		Map<String, Object> setMap = new HashMap<>();
		setMap.put("donationItemList", donationItemList);
		setMap.put("itemCategoryList", itemCategoryList);
		setMap.put("lastPage", lastPage);
		setMap.put("totalRow", totalRow);
		
		return setMap;
	}
	
	// staff - 돈 후원 조회
	public List<Map<String, Object>> getDonationMoneyNList(int shelterId, String searchWord, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 일반 후원 map-> "+map);
		
		List<Map<String, Object>> list = donationMapper.selectDonationMoneyNList(map);
		log.debug("●●●●▶ 일반 후원 list-> "+list);
		
		return list;
	}
	
	// staff - 정기 후원 조회
	public List<Map<String, Object>> getDonationMoneyPList(int shelterId, String searchWord, int currentPage, int rowPerPage){
		//페이징 currentPage, rowPerPage, lastPage, beginRow, totalRow
		int beginRow = (currentPage - 1)*rowPerPage;
		
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		log.debug("●●●●▶ 정기 후원 map-> "+map);
		
		List<Map<String, Object>> list = donationMapper.selectDonationMoneyPList(map);
		log.debug("●●●●▶ 정기 후원 list-> "+list);
		
		return list;
	}
	
	// staff - 통계 - 이번달 후원 받은 금액
	public Map<String, Object> getDonationMoneyThisMonth(int shelterId){
		return donationMapper.selectDonationMoneyThisMonth(shelterId);
	}
	
	// staff - 통계 - 최근 물품후원 내역
	public List<Map<String, Object>> getDonationItemLast(int shelterId){
		return donationMapper.selectDonationItemLast(shelterId);
	}
	
	// staff - 통계 - 후원금액 기간 조회
	public List<Map<String, Object>> getDonationMoneyByPeriod(int shelterId, String startDate, String endDate){
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("endDate", endDate);
		map.put("startDate", startDate);
		log.debug("●●●●▶ 기간별 후원액 정보-> "+map);
		return donationMapper.selectDonationMoneyByPeriod(map);
	}
	
	// staff - 통계 - 후원금액 기간 조회
	public List<Map<String, Object>> getDonationItemByPeriod(int shelterId, String startDate, String endDate, String itemCategoryName){
		Map<String, Object> map = new HashMap<>();
		map.put("shelterId", shelterId);
		map.put("endDate", endDate);
		map.put("startDate", startDate);
		map.put("itemCategoryName", itemCategoryName);
		log.debug("●●●●▶ 기간별 후원물품 정보-> "+map);
		return donationMapper.selectDonationItemByPeriod(map);
	}
	
}
