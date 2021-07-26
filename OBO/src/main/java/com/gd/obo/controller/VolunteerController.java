// 작성자 : 이윤정
// 수정자 : 남궁혜영(2021-07-19)

package com.gd.obo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.obo.service.VolunteerService;
import com.gd.obo.vo.Member;
import com.gd.obo.vo.PeriodVolunteerCheck;
import com.gd.obo.vo.PeriodVolunteerRecruit;
import com.gd.obo.vo.Staff;
import com.gd.obo.vo.VolunteerCheck;
import com.gd.obo.vo.VolunteerRecruit;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VolunteerController {
	@Autowired VolunteerService volunteerService;
	
	// 회원 봉사 메인페이지
	@GetMapping("/getVolunteer")
	public String getMemberVolunteer() {
		return "main/getVolunteer";
	}
	
	// 회원 일반봉사
	@GetMapping("/member/getVolunteerN")
	public String getVolunteerN(Model model,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
			@RequestParam(value="searchWord", required = false) String searchWord,
			@RequestParam(value="categoryName", required = false) String categoryName) {
		
		if(searchWord != null && searchWord.equals("")) {
			searchWord=null;
		}
		if(categoryName != null && categoryName.equals("")) {
			categoryName=null;
		}
		Map<String, Object> map = volunteerService.getVolunteerN(currentPage, rowPerPage, searchWord, categoryName);
		model.addAttribute("recruitList", map.get("recruitList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("total", map.get("recruitTotal"));
		model.addAttribute("categoryName",categoryName);
		model.addAttribute("categoryNameList", map.get("categoryNameList"));
		model.addAttribute("currentDate", map.get("currentDate"));
		model.addAttribute("searchWord",searchWord);
		log.debug("=====map:"+map);
		return "main/getVolunteerN";
	}
	
	// 회원 일반봉사 신청
	@GetMapping("/member/addVolunteerNApply")
	public String addVolunteerNApply(HttpSession session,
			@RequestParam(value="recruitId", required = true) int recruitId) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		int row = volunteerService.addVolunteerNApply(memberId, recruitId);
		log.debug("=====row:"+row);
		return "redirect:/member/getVolunteerN";
	}
	
	// 회원 정기봉사
	@GetMapping("/member/getVolunteerP")
	public String getVolunteerP(Model model,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage,
			@RequestParam(value="searchWord", required = false) String searchWord,
			@RequestParam(value="categoryName", required = false) String categoryName) {
		
		if(searchWord != null && searchWord.equals("")) {
			searchWord=null;
		}
		if(categoryName != null && categoryName.equals("")) {
			categoryName=null;
		}
		Map<String, Object> map = volunteerService.getVolunteerP(currentPage, rowPerPage, searchWord, categoryName);
		model.addAttribute("recruitList", map.get("recruitList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("total", map.get("recruitTotal"));
		model.addAttribute("categoryName",categoryName);
		model.addAttribute("categoryNameList", map.get("categoryNameList"));
		model.addAttribute("currentDate", map.get("currentDate"));
		model.addAttribute("searchWord",searchWord);
		log.debug("=====map:"+map);
		return "main/getVolunteerP";
	}
	// 회원 정기봉사 신청
	@GetMapping("/member/addVolunteerPApply")
	public String addVolunteerPApply(HttpSession session,
			@RequestParam(value="recruitId", required = true) int recruitId,
			@RequestParam(value="determination", required = true) String determination) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		int row = volunteerService.addVolunteerPApply(memberId, recruitId, determination);
		log.debug("=====row:"+row);
		return "redirect:/member/getVolunteerP";
	}
	
	
	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ staff @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	// staff 봉사
	@GetMapping("/staff/getVolunteerInStaff")
	public String getVolunteerInStaff() {
		return "staff/getVolunteerInStaff";
	}
	
	// staff 일반봉사 - 모집공고
	@GetMapping("/staff/getVolunteerRecruitN")
	public String getVolunteerRecruitN(HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "searchSelect", required = false) String searchSelect,
										@RequestParam(value = "categoryName", required = false) String categoryName) {
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		
		// null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		if(categoryName != null && categoryName.equals("")) {
			categoryName = null;
		}
		
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect = null;
		}
		
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶searchSelect-> "+searchSelect);
		log.debug("●●●●▶categoryName-> "+categoryName);	
		
		List<Map<String, Object>> volunteerRecruitN = volunteerService.getVolunteerRecruitListInStaff(shelterId, searchWord, searchSelect, categoryName);
		List<Map<String, Object>> categoryNameList = volunteerService.getVolunteerCategoryList();
		
		log.debug("●●●●▶volunteerRecruitN-> "+volunteerRecruitN);
		log.debug("●●●●▶categoryNameList-> "+categoryNameList);
		
		
		model.addAttribute("categoryNameList", categoryNameList);
		model.addAttribute("volunteerRecruitN", volunteerRecruitN);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		model.addAttribute("categoryName", categoryName);
		
		return "staff/getVolunteerRecruitN";
	}
	
	// staff 일반봉사 - 신청목록
	@GetMapping("/staff/getVolunteerApplyN")
	public String getVolunteerApplyN(HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "searchSelect", required = false) String searchSelect) {
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		
		// null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶searchSelect-> "+searchSelect);
		
		List<Map<String, Object>> volunteerApplyN = volunteerService.getVolunteerApplyListInStaff(shelterId, searchWord, searchSelect);

		log.debug("●●●●▶volunteerApplyN-> "+volunteerApplyN);
		
		model.addAttribute("volunteerApplyN", volunteerApplyN);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		
		return "staff/getVolunteerApplyN";
	}
	
	// staff 일반봉사 - 확인목록
	@GetMapping("/staff/getVolunteerCheckN")
	public String getVolunteerCheckN(HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "searchSelect", required = false) String searchSelect,
										@RequestParam(value = "categoryName", required = false) String categoryName) {
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		
		// null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		if(categoryName != null && categoryName.equals("")) {
			categoryName = null;
		}
		
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect = null;
		}
		
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶searchSelect-> "+searchSelect);
		log.debug("●●●●▶categoryName-> "+categoryName);
		
		List<Map<String, Object>> volunteerCheckN = volunteerService.getVolunteerCheckListInStaff(shelterId, searchWord, searchSelect, categoryName);
		List<Map<String, Object>> categoryNameList = volunteerService.getVolunteerCategoryList();

		log.debug("●●●●▶volunteerCheckN-> "+volunteerCheckN);
		log.debug("●●●●▶categoryNameList-> "+categoryNameList);
		
		model.addAttribute("volunteerCheckN", volunteerCheckN);
		model.addAttribute("categoryNameList", categoryNameList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		model.addAttribute("categoryName", categoryName);
		
		return "staff/getVolunteerCheckN";
	}
	
	// staff 정기봉사 - 모집공고
	@GetMapping("/staff/getVolunteerRecruitP")
	public String getVolunteerRecruitP(HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "searchSelect", required = false) String searchSelect,
										@RequestParam(value = "categoryName", required = false) String categoryName) {
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);

		// null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		if(categoryName != null && categoryName.equals("")) {
			categoryName = null;
		}
		
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect = null;
		}
		
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶searchSelect-> "+searchSelect);
		log.debug("●●●●▶categoryName-> "+categoryName);
		
		List<Map<String, Object>> volunteerRecruitP = volunteerService.getPeriodVolunteerRecruitListInStaff(shelterId, searchWord, searchSelect, categoryName);
		List<Map<String, Object>> categoryNameList = volunteerService.getVolunteerCategoryList();

		log.debug("●●●●▶volunteerRecruitP-> "+volunteerRecruitP);
		log.debug("●●●●▶categoryNameList-> "+categoryNameList);
		
		model.addAttribute("volunteerRecruitP", volunteerRecruitP);
		model.addAttribute("categoryNameList", categoryNameList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		model.addAttribute("categoryName", categoryName);
		
		return "staff/getVolunteerRecruitP";
	}
	
	// staff 정기봉사 - 신청목록
	@GetMapping("/staff/getVolunteerApplyP")
	public String getVolunteerApplyP(HttpSession session, Model model,
										@RequestParam(value = "searchWord", required = false) String searchWord,
										@RequestParam(value = "searchSelect", required = false) String searchSelect) {
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		
		// null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶searchSelect-> "+searchSelect);
		
		List<Map<String, Object>> volunteerApplyP = volunteerService.getPeriodVolunteerApplyListInStaff(shelterId, searchWord, searchSelect);
		List<Map<String, Object>> categoryNameList = volunteerService.getVolunteerCategoryList();

		log.debug("●●●●▶volunteerApplyP-> "+volunteerApplyP);
		log.debug("●●●●▶categoryNameList-> "+categoryNameList);
		
		model.addAttribute("volunteerApplyP", volunteerApplyP);
		model.addAttribute("categoryNameList", categoryNameList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		
		return "staff/getVolunteerApplyP";
	}
	
	// staff 정기봉사 - 확인목록
	@GetMapping("/staff/getVolunteerCheckP")
	public String getVolunteerCheckP(HttpSession session, Model model,
									@RequestParam(value = "searchWord", required = false) String searchWord,
									@RequestParam(value = "searchSelect", required = false) String searchSelect,
									@RequestParam(value = "categoryName", required = false) String categoryName) {
		
		int shelterId = ((Staff)(session.getAttribute("loginStaff"))).getShelterId();
		log.debug("●●●●▶shelterId-> "+shelterId);
		
		// null 처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		if(categoryName != null && categoryName.equals("")) {
			categoryName = null;
		}
		
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect = null;
		}
		
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶searchSelect-> "+searchSelect);
		log.debug("●●●●▶categoryName-> "+categoryName);	
		
		List<Map<String, Object>> volunteerCheckP = volunteerService.getPeriodVolunteerCheckListInStaff(shelterId, searchWord, searchSelect, categoryName);
		List<Map<String, Object>> categoryNameList = volunteerService.getVolunteerCategoryList();

		log.debug("●●●●▶volunteerCheckP-> "+volunteerCheckP);
		log.debug("●●●●▶categoryNameList-> "+categoryNameList);
		
		model.addAttribute("volunteerCheckP", volunteerCheckP);
		model.addAttribute("categoryNameList", categoryNameList);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		model.addAttribute("categoryName", categoryName);
		
		return "staff/getVolunteerCheckP";
	}
	
	// 일반봉사 등록
	@PostMapping("/staff/addVolunteerRecruitN")
	public String addVolunteerRecruitN(HttpSession session, VolunteerRecruit recruit) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶staffId-> "+staffId);
		recruit.setStaffId(staffId);
		log.debug("●●●●▶volunteerRecruit-> "+recruit);
		
		int cnt = volunteerService.addVolunteerRecruit(recruit);
		log.debug("●●●●▶일반봉사 모집공고 등록 갯수(실패 0)-> "+cnt);
		
		return "redirect:/staff/getVolunteerRecruitN";
	}
	
	
	// 정기봉사 등록
	@PostMapping("/staff/addVolunteerRecruitP")
	public String addVolunteerRecruitP(HttpSession session, PeriodVolunteerRecruit periodRecruit) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶staffId-> "+staffId);
		periodRecruit.setStaffId(staffId);
		log.debug("●●●●▶periodRecruit-> "+periodRecruit);
		
		int cnt = volunteerService.addPeriodVolunteerRecruit(periodRecruit);
		log.debug("●●●●▶정기봉사 모집공고 등록 갯수(실패 0)-> "+cnt);
		
		return "redirect:/staff/getVolunteerRecruitP";
	}
	
	// 일반봉사 확인
	@PostMapping("/staff/addVolunteerCheckN")
	public String addVolunteerCheckN(HttpSession session, VolunteerCheck check, String volunteerDate) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶staffId-> "+staffId);
		log.debug("●●●●▶volunteerDate-> "+volunteerDate);
		
		String startTime = check.getStartTime();
		String endTime = check.getEndTime();
		
		check.setStaffId(staffId);
		check.setStartTime(volunteerDate+" "+startTime);
		check.setEndTime(volunteerDate+" "+endTime);
		log.debug("●●●●▶check-> "+check);
		
		int cnt = volunteerService.addVolunteerCheck(check);
		log.debug("●●●●▶일반봉사 확인!!(실패 0)-> "+cnt);
		
		return "redirect:/staff/getVolunteerCheckN";
	}
	
	
	// 정기봉사 확인
	@PostMapping("/staff/addVolunteerCheckP")
	public String addVolunteerCheckP(HttpSession session, PeriodVolunteerCheck check) {
		String staffId = ((Staff)(session.getAttribute("loginStaff"))).getStaffId();
		log.debug("●●●●▶staffId-> "+staffId);
		check.setStaffId(staffId);
		log.debug("●●●●▶check-> "+check);
		
		int cnt = volunteerService.addPeriodVolunteerCheck(check);
		log.debug("●●●●▶정기봉사 확인!!(실패 0)-> "+cnt);
		
		return "redirect:/staff/getVolunteerCheckP";
	}
	
	
}
