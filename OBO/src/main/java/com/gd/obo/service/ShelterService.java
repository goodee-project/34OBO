// 작성자: 김선유
// 수정자 : 남궁혜영(2021-07-16)
// 수정자 : 이윤정(2021-07-16) ; staff 회원가입시 -> 보호소 검색용
// 수정자 : 손영현(2021-07-17) ; 일반, 정기 후원시 -> 보호소 선택용, 카카오 로컬 사용해서 x, y 좌표 구함
package com.gd.obo.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.AddressMapper;
import com.gd.obo.mapper.ShelterFileMapper;
import com.gd.obo.mapper.ShelterMapper;
import com.gd.obo.vo.Address;
import com.gd.obo.vo.AnimalFile;
import com.gd.obo.vo.Page;
import com.gd.obo.vo.Shelter;
import com.gd.obo.vo.ShelterAddress;
import com.gd.obo.vo.ShelterFile;
import com.gd.obo.vo.ShelterForm;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ShelterService {
	@Autowired ShelterMapper shelterMapper;
	@Autowired AddressMapper addressMapper;
	@Autowired ShelterFileMapper shelterFileMapper;
	
	
	// 직원 보호소 수정
	public int modifyShelter(ShelterForm shelterForm) {
		Shelter shelter = shelterForm.getShelter();
		log.debug("%>%>%>%>%>%>%>%>%> ShelterService-> modifyShelter-> shelter shelterlId: " + shelter.getShelterId());
		
		shelterMapper.updateShelter(shelter);
		
		List<ShelterFile> shelterFileList = shelterMapper.selectShelterFileByShelter(shelter.getShelterId());
		log.debug("%>%>%>%>%>%>%>%>%> ShelterService-> modifyShelter shelterFileList: " + shelterFileList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		log.debug("%>%>%>%>%>%>%>%>%> ShelterService-> modifyShelter map: " + map);
		
		map.put("shelterId", shelter.getShelterId());
		map.put("shelterFile", shelterForm.getShelterFile());
		map.put("shelterFileList", shelterFileList);
		
		// File 불러오기
		List<MultipartFile> list = shelterForm.getShelterFile();
		log.debug("%>%>%>%>%>%>%>%>%> ShelterService-> modifyShelter list: " + list);
		if(list != null) {
			for(MultipartFile f : list) {
				ShelterFile shelterFile = new ShelterFile();
				log.debug("%>%>%>%>%>%>%>%>%> ShelterService-> modifyShelter shelterFile: " + shelterFile);
				shelterFile.setShelterId(shelter.getShelterId());
				
				// 파일 이름
				String prename = UUID.randomUUID().toString().replace("-","");
				
				String filename = prename;
				log.debug("%>%>%>%>%>%>%>%>%> ShelterService-> modifyShelter filename: " + filename);
				shelterFile.setShelterFileName(filename);
				shelterFile.setShelterId(shelter.getShelterId());
				shelterFile.setShelterFileSize(f.getSize());
				shelterFile.setShelterFileExt(f.getContentType());
				
				shelterFileMapper.insertShelterFile(shelterFile);
				
				try {
					File temp = new File(""); // 프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath(); // 프로젝트필드
					f.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\shelter\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}			
		}
		return shelter.getShelterId();
	}
	
	
	// 후원: 쉘터 선택용 리스트
	public List<Shelter> getShelterListByDonation(){
		return shelterMapper.selectShelterListByDonation();
	}
	// shelter 상세보기
	public Map<String, Object> getShelterOne(int shelterId) {
		// 상세보기
		Map<String, Object> shelterMap = shelterMapper.selectShelterOne(shelterId);
		log.debug("@@@@@shelterMap: "+shelterMap);
		
		
		//카카오 로컬으로x, y 좌표 구하기
		
		RestTemplate rt = new RestTemplate();
		
		//http 헤더 생성
		HttpHeaders headers = new HttpHeaders();
		//contents-type
		headers.add("Authorization", "KakaoAK 535757159a398fe468b3ed3f2d2032e4");
		
		//header 와 body값을 담아네요 restTemplate 라이브러리를 이용하여 전송
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(null, headers);
		
		log.debug("■■■■■ kakaoTokenRequest code param : " + kakaoTokenRequest);
		
		//http요청하기-post 방식 - response 변수의 응답 받음
		//exchange : HTTP 헤더를 새로 만들 수 있고 어떤 HTTP 메서드(post, get ...)도 사용가능하다
		ResponseEntity<String> response = rt.exchange("https://dapi.kakao.com/v2/local/search/address.json?query="+ (String)shelterMap.get("doro"), HttpMethod.GET, kakaoTokenRequest, String.class);
		
		
		//log.debug("■■■■■ response 로컬 : " + response);
		//log.debug("■■■■■ response bodybody 로컬 : " + response.getBody());
		
		//response는 json 형식이므로 고쳐야함!
		Map<String, Object> kakaoResponse = null;
		
		try {
			kakaoResponse = new JSONParser(response.getBody()).parseObject();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		log.debug("■■■■■ kakaoResponse 결과 잘 나오는지 확인: "+ kakaoResponse);
			
		//타입확인 - arrayList
		//log.debug(kakaoResponse.get("documents").getClass().getName());
		
		List list = (List)kakaoResponse.get("documents");
		
		/*
		for(Object o: list) {
			log.debug("ooooooo :" + o);
			log.debug(o.getClass().getName());
		}
		*/
		
		Map map = (Map)list.get(0);
		/* key, value 확인
		map.forEach((key, value)
			    -> log.debug("key: " + key + ", value: " + value));
		
		*/
		String x = (String)map.get("x");
		String y = (String)map.get("y");
		
		log.debug("■■■■■ x 결과 잘 나오는지 확인: "+ x);
		log.debug("■■■■■ y 결과 잘 나오는지 확인: "+ y);
		
		
		//결과를 담아서 return
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("shelterMap", shelterMap);
		
		returnMap.put("x", x);
		returnMap.put("y", y);
		
		return returnMap;
	}
	
	// shelter 리스트,  staff 회원가입 -> 보호소 선택
	public Map<String, Object> getShelterList(int currentPage, int rowPerPage, String shelterName, String searchAddress) {
		
		// shelter 개수
		Map<String, Object> totalMap = new HashMap<>();
		totalMap.put("shelterName", shelterName);
		totalMap.put("searchAddress", searchAddress);
		log.debug("===== totalMap: "+totalMap);
		
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
		paramMap.put("currentPage", currentPage);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("shelterName", shelterName);
		paramMap.put("searchAddress", searchAddress);
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
