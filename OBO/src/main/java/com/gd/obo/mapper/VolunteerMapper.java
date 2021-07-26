package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.PeriodVolunteerCheck;
import com.gd.obo.vo.PeriodVolunteerRecruit;
import com.gd.obo.vo.VolunteerCheck;
import com.gd.obo.vo.VolunteerRecruit;

@Mapper
public interface VolunteerMapper {
	List<Map<String, Object>> selectVolunteerNList(Map<String, Object> map);
	int selectVolunteerNTotal(Map<String, Object> map);
	List<String> selectVolunteerCategory();
	int insertVolunteerApplyByMember(Map<String, Object> map);
	String selectMemberIdForCheckApplying(Map<String, Object> map);
	List<Map<String, Object>> selectVolunteerPList(Map<String, Object> map);
	int selectVolunteerPTotal(Map<String, Object> map);
	int insertPeriocallyVolunteerApplyByMember(Map<String, Object> map);
	String selectMemberIdForCheckApplyingP(Map<String, Object> map); 
	String selectMemberQualification(Map<String, Object> map);
	
	List<Map<String, Object>> selectVolunteerRecruitListInStaff(Map<String, Object> map);
	List<Map<String, Object>> selectVolunteerApplyListInStaff(Map<String, Object> map);
	List<Map<String, Object>> selectVolunteerCheckListInStaff(Map<String, Object> map);
	List<Map<String, Object>> selectPeriodVolunteerRecruitListInStaff(Map<String, Object> map);
	List<Map<String, Object>> selectPeriodVolunteerApplyListInStaff(Map<String, Object> map);
	List<Map<String, Object>> selectPeriodVolunteerCheckListInStaff(Map<String, Object> map);
	List<Map<String, Object>> selectVolunteerCategoryList();
	List<Map<String, Object>> selectVolunteerRecruitOne(int volunteerRecruitId);
	List<Map<String, Object>> selectPeriodVolunteerRecruitOne(int periodVolunteerRecruitId);
	int insertVolunteerRecruit(VolunteerRecruit recruit);
	int insertPeriodVolunteerRecruit(PeriodVolunteerRecruit recruit);
	int insertVolunteerCheck(VolunteerCheck check);
	int insertPeriodVolunteerCheck(PeriodVolunteerCheck check);
}
