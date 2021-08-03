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
	
	//쉘터별 또는 전체 보호중인 동물의 수
	public List<Map<String, Object>> getAnimalSpeciesCount(int shelterId){
		log.debug("■■■■■■ 보호소아이디 getAnimalSpeciesCount param: "+ shelterId);
		
		return animalMapper.selectAnimalSpeciesCount(shelterId);
	}
	
	//보호중인 동물의 수, 달별 입양&안락사 동물
	public Map<String, Object> getAnimalStateCountByMonth(int month, int shelterId){
		Map<String, Object> result = new HashMap<>();
		//보호중인 동물의 수
		result.put("protect", animalMapper.selectAnimalCountByProtect(shelterId));
		
		log.debug("■■■■■■ getAnimalStateCountByMonth param: "+ month);
		log.debug("■■■■■■ getAnimalStateCountByMonth param: "+ shelterId);
		
		
		//파라미터
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("month", month);
		paramMap.put("shelterId", shelterId);
		
		//이번달 입양 동물
		result.put("adopt", animalMapper.selectAdoptAnimalCountByMonth(paramMap));
		//이번달 안락사 동물
		result.put("euthanasia", animalMapper.selectEuthanasiaAnimalCountByMonth(paramMap));
		
		log.debug("■■■■■■ 보호동물, 입양동물, 안락사 수 getAnimalStateCount: "+ result);
		
		return result;
	}
	
	//animal 안락사 실행
	public void modifyAnimalByEuthanasia(List<Integer> animalId) {
		log.debug("■■■■■■ animalId modifyAnimalByEuthanasia param : "+ animalId);
		
		animalMapper.updateAnimalByEuthanasia(animalId);
	}
	
	// animal 안락사 리스트 실행
	public List<Integer> getAnimalListByEuthanasia(){
		return animalMapper.selectAnimalListByEuthanasia();
	}

	// animal 수정
	public int modifyAnimal(AnimalForm animalForm) {
		Animal animal = animalForm.getAnimal();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> modifyAnimal animal: " + animal);
		
		animalMapper.updateAnimal(animal);
		
		List<AnimalFile> animalFileList = animalMapper.selectAnimalFileByAnimal(animal.getAnimalId());
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> modifyAnimal animalFileList: " + animalFileList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> modifyAnimal map: " + map);
		
		map.put("animalId", animal.getAnimalId());
		map.put("animalFile", animalForm.getAnimalFile());
		map.put("animalFileList", animalFileList);
		
		// File 불러오기
		MultipartFile list = animalForm.getAnimalFile();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal list: " + list);
		if(list != null) {
				int animalFileId = animalForm.getAnimalFileId();
				AnimalFile animalFile = new AnimalFile();
				log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal animalFile: " + animalFile);
				animalFile.setAnimalId(animal.getAnimalId());
				
				// 파일 이름
				String prename = UUID.randomUUID().toString().replace("-","");
				
				String filename = prename;
				animalFile.setAnimalFileName(filename); // 중복으로 인해 덮어쓰기 가능
				animalFile.setAnimalId(animal.getAnimalId());
				animalFile.setAnimalFileSize(list.getSize());
				animalFile.setAnimalFileExt(list.getContentType());
				
				log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal filename: " + filename);
				
				if(animalFileId == 0) {
					animalFileMapper.insertAnimalFile(animalFile);
				} else {
					animalFile.setAnimalFileId(animalFileId);
					animalFileMapper.updateAnimalFile(animalFile);
				}
				
				
				try {
					File temp = new File(""); // 프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath(); // 프로젝트필드
					list.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\animal\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
				}
						
		}
		return animal.getAnimalId();
	}
	
	
	
	

	// 작성자 : 남민정 
	// animal 추가
	public void addAnimal(AnimalForm animalForm) {
		// Animal 불러오기 
		Animal animal = animalForm.getAnimal();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal animal : " + animal);
		
		animalMapper.insertAnimal(animal);
	
		// File 불러오기
		MultipartFile list = animalForm.getAnimalFile();
		log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal list: " + list);
		if(list != null) {
				AnimalFile animalFile = new AnimalFile();
				log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal animalFile: " + animalFile);
				animalFile.setAnimalId(animal.getAnimalId());
				
				// 파일 이름
				String prename = UUID.randomUUID().toString().replace("-","");
				
				String filename = prename;
				animalFile.setAnimalFileName(filename); // 중복으로 인해 덮어쓰기 가능
				animalFile.setAnimalId(animal.getAnimalId());
				animalFile.setAnimalFileSize(list.getSize());
				animalFile.setAnimalFileExt(list.getContentType());
				log.debug("%>%>%>%>%>%>%>%>%> AnimalService-> addAnimal filename: " + filename);
				
				animalFileMapper.insertAnimalFile(animalFile);
				
				try {
					File temp = new File(""); // 프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath(); // 프로젝트필드
					list.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\animal\\"+filename));
				} catch (Exception e) {
					throw new RuntimeException();
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
	
	//회원 동물 좋아요
	public int addAnimalLike(String memberId, int animalId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("animalId", animalId);
		int row = animalMapper.insertAnimalLike(map);
		log.debug("===== 동물 좋아요 row:"+row);
		log.debug("===== 동물 좋아요 동물:"+animalId);
		return row;
	}
	
	//동물 좋아요 중복 확인
	public int getAnimalLikeByMember(String memberId, int animalId) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("animalId", animalId);
		int ck = animalMapper.selectAnimalLikeByMember(map);
		return ck;
	}
	
	//회원이 동물좋아요한 동물 리스트 보여주기
	public List<Map<String,Object>> getAnimalLikeListByMember(String memberId){
		List<Map<String,Object>> list = animalMapper.selectAnimalLikeListByMember(memberId);
		return list;
	}
}
