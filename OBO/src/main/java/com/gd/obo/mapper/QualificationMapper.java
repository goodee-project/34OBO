//작성자 : 남궁혜영
package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QualificationMapper {
	List<Map<String, Object>> selectQualificationApprovalList();
	List<Map<String, Object>> selectQualificationApplicationList();
	int InsertApproveQualificationApplication(Map<String,Object> map);
	int InsertRejectQualificationApplication(Map<String,Object> map);
}
