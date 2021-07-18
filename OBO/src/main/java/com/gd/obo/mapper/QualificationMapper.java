//작성자 : 남궁혜영
package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Page;

@Mapper
public interface QualificationMapper {
	List<Map<String, Object>> selectQualificationApprovalList(Page page);
	List<Map<String, Object>> selectQualificationApplicationList(Page page);
	int InsertApproveQualificationApplication(Map<String,Object> map);
	int InsertRejectQualificationApplication(Map<String,Object> map);
	int selectQualificationApplicationListTotal(Page page);
	int selectQualificationApprovalListTotal(Page page);
}
