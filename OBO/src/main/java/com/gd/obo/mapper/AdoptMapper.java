package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdoptMapper {
	List<Map<String, Object>> selectAdoptApplyList(Map<String, Object> map);
	List<Map<String, Object>> selectAdoptApprovalList(Map<String, Object> map);
	List<Map<String, Object>> selectAdoptRejectList(Map<String, Object> map);
	List<Map<String, Object>> selectAdoptList(Map<String, Object> map);
	int insertAdopt(Map<String, Object> map);
	int updateAdoptReject(int adoptApplyId);
	int insertAdoptForm(Map<String, Object> map);
	int insertAdoptByMember(Map<String, Object> map);
	Map<String, Object> selectAdoptDocumentByMember(String memberId);
	int insertAdoptDocument();
}
