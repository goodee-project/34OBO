package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Page;

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
}
