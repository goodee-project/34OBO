package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Staff;

@Mapper
public interface StaffMapper {
	Staff selectStaffByLogin(Staff staff);
	int selectStaffLoginCk(Staff staff);
	Staff selectStaffOne(String staffId);
	List<Staff> selectStaffLevel0(int shelterId);
	List<Map<String, Object>> selectStaffListByMaster(int shelterId);
	int selectStaffIdCheck(String staffId, String staffPw);
	int insertStaff(Staff staff);
	int insertMasterStaff(Staff staff);
	int updateStaff(Staff staff);
	int updateStaffState(Map<String, Object> map);
}
