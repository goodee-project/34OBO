//작성자 : 남궁혜영
package com.gd.obo.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.obo.mapper.QualificationMapper;
import com.gd.obo.vo.Page;
import com.gd.obo.vo.QualificationApplicationForm;
import com.gd.obo.vo.QualificationFile;
import com.gd.obo.vo.QualificationType;
import com.gd.obo.vo.QualificationVolunteerApplication;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Slf4j
public class QualificationService {
	@Autowired QualificationMapper qualificationMapper;
	
	
	//회원마다 자격승인목록
	public List<Map<String, Object>> getQualificationApprovalByMemberId(String memberId){
		return qualificationMapper.selectQualificationApprovalByMemberId(memberId);
	}
	
	//자격신청 중복되었는지 확인
	public String getQualificationApprovalForChecked(String memberId, int qualificationTypeId, int volunteerCategoryId){
		log.debug("■■■■■■■ getQAFC param :" + memberId);
		log.debug("■■■■■■■ getQAFC param :" + qualificationTypeId);
		log.debug("■■■■■■■ getQAFC param :" + volunteerCategoryId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("qualificationTypeId", qualificationTypeId);
		map.put("volunteerCategoryId", volunteerCategoryId);
		
		String approvalDate = qualificationMapper.selectQualificationApprovalChecked(map);
		log.debug("■■■■■■■■■■■■■ approvalDate : " + approvalDate);
		
		String approval = null; // null이면 자격신청 가능
		
		if(approvalDate != null) { //이미 승인된 경우 -> 날짜가 나온다.
			approval = approvalDate;
		} else if(qualificationMapper.selectQulificationApprovalByWating(map) != null) {
			//신청중이고 허가가 되지 않은 경우 "대기중"
			approval = "대기중";
		}
		
		
		
		return approval;
	}
	
	//자격 신청
	public void addQualificationVolunteerApplication(QualificationApplicationForm qualificationApplicationForm) {
		
		
		log.debug("■■■■■■■ addQVA :" + qualificationApplicationForm);
		
		MultipartFile m = qualificationApplicationForm.getQualificationFile();
		
		QualificationFile qualificationFile = new QualificationFile();
		
		String originalFileName = m.getOriginalFilename();
		int p = originalFileName.lastIndexOf(".");
		String ext = originalFileName.substring(p).toLowerCase();
		
		String prename = UUID.randomUUID().toString().replace("-", "");
		
		String fileName = prename+ext;
		qualificationFile.setQualificationFileName(fileName);
		qualificationFile.setQualificationFileSize(m.getSize());
		qualificationFile.setQualificationFileExt(m.getContentType());
		
		log.debug("qualificationFile : "+ qualificationFile);
		
		File temp = new File("");
		String path = temp.getAbsolutePath();
		
		String os = System.getProperty("os.name");
		
		try {	
			
			if(os.contains("Win")) { //windeow 배포전
				m.transferTo(new File(path+"\\src\\main\\webapp\\static\\img\\qualification\\"+fileName));
			} else {// 배포 후
				m.transferTo(new File(path+File.separator+Paths.get("webapps", "obo", "static", "img", "qualification")+File.separator+fileName));
			}	
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		//DB에 봉사자격파일 insert
		qualificationMapper.insertQualificationFile(qualificationFile);
		//봉사자격
		QualificationVolunteerApplication qualificationVolunteerApplication = qualificationApplicationForm.getQualificationVolunteerApplication();
		
		qualificationVolunteerApplication.setQualificationFileId(qualificationFile.getQualificationFileId());
		
		log.debug("■■■■■■■ addQualificationVolunteerApplication :" + qualificationVolunteerApplication);
		
		qualificationMapper.insertQualificationVolunteerApplication(qualificationVolunteerApplication);
	}
	
	//봉사타입이 가능한 봉사
	public List<Map<String, Object>> getVolunteerByQualificationTypeId(int qualificationTypeId){
		return qualificationMapper.selectVolunteerByQualificationTypeId(qualificationTypeId);
	}
	
	//자격 타입 목록
	public List<QualificationType> getQualificationTypeList(){
		return qualificationMapper.selectQualificationTypeList();
	}
	//자격 - 가능봉사 목록
	public List<Map<String, Object>> getQualificationVolunterrList(){
		return qualificationMapper.selectQualificationVolunterrList();
	}
	
	//자격 승인 내역
	public Map<String, Object> getQualificationApprovalList(int currentPage, int rowPerPage, String searchWord){
		
		Page page = new Page();
		int beginRow = (currentPage-1)*rowPerPage;
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		int total = qualificationMapper.selectQualificationApprovalListTotal(page);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("===== total 값 : "+total);
		log.debug("===== lastPage 값 : "+lastPage);
		log.debug("===== page 값 : "+page);
		
		List<Map<String, Object>> list = qualificationMapper.selectQualificationApprovalList(page);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("page", page);
		log.debug("======자격 승인 리스트 : "+list);
		return map;
	}
	
	//자격 신청 내역
	public Map<String, Object> getQualificationApplicationList(int currentPage, int rowPerPage, String searchWord){
		
		Page page = new Page();
		int beginRow = (currentPage-1)*rowPerPage;
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		int total = qualificationMapper.selectQualificationApplicationListTotal(page);
		int lastPage = (int)Math.ceil((double)total/rowPerPage);
		log.debug("===== total 값 : "+total);
		log.debug("===== lastPage 값 : "+lastPage);
		log.debug("===== page 값 : "+page);
		
		List<Map<String, Object>> list = qualificationMapper.selectQualificationApplicationList(page);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("lastPage", lastPage);
		map.put("page", page);
		log.debug("======자격 신청 리스트 : "+list);
		return map;
	}
	
	//자격 신청 승인
	public int addApproveApplication(String managerId, int applicationId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("managerId", managerId);
		paramMap.put("applicationId", applicationId);
		int row = qualificationMapper.insertApproveQualificationApplication(paramMap);
		log.debug("======자격 신청 승인 row : "+row);
		log.debug("======자격 신청 승인 param : "+paramMap);
		return row;
	}
	
	//자격 신청 거절
	public int addRejectApplication(String managerId, int applicationId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("managerId", managerId);
		paramMap.put("applicationId", applicationId);
		int row = qualificationMapper.insertRejectQualificationApplication(paramMap);
		log.debug("======자격 신청 거절 row : "+row);
		log.debug("======자격 신청 거절 param : "+paramMap);
		return row;
	}
	
}
