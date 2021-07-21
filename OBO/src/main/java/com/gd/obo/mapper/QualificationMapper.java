//작성자 : 남궁혜영
package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Page;
import com.gd.obo.vo.QualificationFile;
import com.gd.obo.vo.QualificationType;
import com.gd.obo.vo.QualificationVolunteerApplication;

@Mapper
public interface QualificationMapper {
	int insertQualificationVolunteerApplication(QualificationVolunteerApplication qualificationVolunteerApplication);
	int insertQualificationFile(QualificationFile qualificationFile);
	List<Map<String, Object>> selectVolunteerByQualificationTypeId(int qualificationTypeId);
	List<QualificationType> selectQualificationTypeList();
	List<Map<String, Object>> selectQualificationVolunterrList();
	List<Map<String, Object>> selectQualificationApprovalList(Page page);
	List<Map<String, Object>> selectQualificationApplicationList(Page page);
	int insertApproveQualificationApplication(Map<String,Object> map);
	int insertRejectQualificationApplication(Map<String,Object> map);
	int selectQualificationApplicationListTotal(Page page);
	int selectQualificationApprovalListTotal(Page page);
}
