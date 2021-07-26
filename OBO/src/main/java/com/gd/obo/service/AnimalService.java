package com.gd.obo.service;

import java.io.File;
import java.security.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.AnimalFileMapper;
import com.gd.obo.mapper.AnimalMapper;
import com.gd.obo.vo.Animal;
import com.gd.obo.vo.AnimalFile;
import com.gd.obo.vo.AnimalForm;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class AnimalService {
	@Autowired
	AnimalMapper animalMapper;
	@Autowired
	AnimalFileMapper animalFileMapper;
	
	/*
	// 작성자 : 남민정
	// animal 수정
	public int updateAnimal(Map<String, Object> map) {
		
		return ;
	}
	*/
	
	
	

	// 작성자 : 남민정 
	// animal 추가
	public void addAnimal(AnimalForm animalForm) {
		// Animal 불러오기 
		Animal animal = animalForm.getAnimal();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal-> animal animalId: " + animal.getAnimalId());
		
		animalMapper.insertAnimal(animal);
	
		// File 불러오기
		List<MultipartFile> list = animalForm.getAnimalFile();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal list: " + list);
		if(list != null) {
			for(MultipartFile f : list) {
				AnimalFile animalFile = new AnimalFile();
				log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal animalFile: " + animalFile);
				animalFile.setAnimalId(animal.getAnimalId());
				
				// 파일 이름
				String prename = UUID.randomUUID().toString().replace("-","");
				
				String filename = prename;
				animalFile.setAnimalFileName(filename); // 중복으로 인해 덮어쓰기 가능
				animalFile.setAnimalId(animal.getAnimalId());
				animalFile.setAnimalFileSize(f.getSize());
				animalFile.setAnimalFileExt(f.getContentType());
				log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal filename: " + filename);
				
				animalFileMapper.insertAnimalFile(animalFile);
				
				try {
					File temp = new File(""); // 프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath(); // 프로젝트필드
					f.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\animal\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
				}
			}			
		}
	}
		
	
	
	
	// 작성자 : 남민정
	// animal 상세 정보
	public Map<String, Object> getAnimalOne(int animalId) {
		Animal animal = new Animal();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne animalId: " + animalId);
		
		// 동물 상세보기
		Map<String, Object> animalMap = animalMapper.selectAnimalOne(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne animalMap: " + animalMap);
		
		// 동물 파일 목록
		List<AnimalFile> animalFileList = animalMapper.selectAnimalFileByAnimal(animalId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne animalFileList: " + animalFileList);
			
		// controller에서 사용할 수 있는 맵
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalOne map: " + map);
		
		Calendar cal = Calendar.getInstance();
		//날짜 형식 변경 --> 쿼리 만들어놔서 그걸로 해도 상관 없는데 한 번 해 봄.
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		
		//sql에서 timestamp 형식이라 timestamp형식으로 형변환
		java.sql.Timestamp animalEnterDate = (java.sql.Timestamp) animalMap.get("animalEnterDate");
		//포맷 지정
		sdf.format(animalEnterDate);
		//캘린더 함수에 입소 날짜 지정
		cal.setTime(animalEnterDate);
		//캘린더 함수에 저장 된 입소 날짜에 보호기간을 더한다.
		cal.add(Calendar.DATE, (int) animalMap.get("duration"));
		//보호 종료 날짜 계산
		String expectedDay = sdf.format(cal.getTime());
		log.debug("===== 입소 날짜:"+animalEnterDate);
		log.debug("===== 보호 종료 날짜:"+expectedDay);

		map.put("animalMap", animalMap);
		map.put("expectedDay", expectedDay);
		return map;
	}
	
	// 회원용 animal 리스트
		public Map<String, Object> getAnimalListM(int shelterId, String searchWord, String species,
												int currentPage, int rowPerPage) {
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList shelterId: " + shelterId);
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList searchWord: " + searchWord);
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList currentPage: " + currentPage);
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList rowPerPage: " + rowPerPage);
			
			// beginRow를 생성
			int beginRow = ((currentPage-1)*rowPerPage);
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList beginRow: " + beginRow);
			
			// map을 불러와서 파라미터 데이터를 넣어줌.
			Map<String, Object> map = new HashMap<>();
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList map: " + map);
			
			map.put("species", species);
			map.put("shelterId", shelterId);
			map.put("searchWord", searchWord);
			map.put("rowPerPage", rowPerPage);
			map.put("beginRow", beginRow);
			
			// selectAnimalTotal
			int selectAnimalTotal = animalMapper.selectAnimalTotal(map);
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList selectAnimalTotal: " + selectAnimalTotal);
			
			// lastPage 생성
			int lastPage = (int)(Math.ceil((double)selectAnimalTotal / rowPerPage)); // lastPage만드는 식
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList lastPage: " + lastPage);
			
			// animalList
			List<Map<String, Object>> animalList = animalMapper.selectMemberAnimalList(map);
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList animalList: " + animalList);
			
			// controller에서 사용할 수 있는 맵
			Map<String, Object> returnMap = new HashMap<>();
			log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList returnMap: " + returnMap);
			
			returnMap.put("animalList", animalList);
			returnMap.put("selectAnimalTotal", selectAnimalTotal);
			returnMap.put("lastPage", lastPage);
			returnMap.put("beginRow", beginRow);
			
			return returnMap;
			
		}
	
	// 작성자 : 남민정
	// animal 리스트 (보호소마다 다름)
	public Map<String, Object> getAnimalList(int shelterId, String searchWord, String species,
											int currentPage, int rowPerPage) {
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList shelterId: " + shelterId);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList searchWord: " + searchWord);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList currentPage: " + currentPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList rowPerPage: " + rowPerPage);
		
		// beginRow를 생성
		int beginRow = ((currentPage-1)*rowPerPage);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList beginRow: " + beginRow);
		
		// map을 불러와서 파라미터 데이터를 넣어줌.
		Map<String, Object> map = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList map: " + map);
		
		map.put("species", species);
		map.put("shelterId", shelterId);
		map.put("searchWord", searchWord);
		map.put("rowPerPage", rowPerPage);
		map.put("beginRow", beginRow);
		
		// selectAnimalTotal
		int selectAnimalTotal = animalMapper.selectAnimalTotal(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList selectAnimalTotal: " + selectAnimalTotal);
		
		// lastPage 생성
		int lastPage = (int)(Math.ceil((double)selectAnimalTotal / rowPerPage)); // lastPage만드는 식
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList lastPage: " + lastPage);
		
		// animalList
		List<Map<String, Object>> animalList = animalMapper.selectAnimalList(map);
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList animalList: " + animalList);
		
		// controller에서 사용할 수 있는 맵
		Map<String, Object> returnMap = new HashMap<>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> getAnimalList returnMap: " + returnMap);
		
		returnMap.put("animalList", animalList);
		returnMap.put("selectAnimalTotal", selectAnimalTotal);
		returnMap.put("lastPage", lastPage);
		returnMap.put("beginRow", beginRow);
		
		return returnMap;
		
	}
	
	// 사용자 : 이윤정 -> staff care info
	public List<Map<String,Object>> getAnimalCategoryList() {
		return animalMapper.selectAnimalCategoryList();
	}
}
