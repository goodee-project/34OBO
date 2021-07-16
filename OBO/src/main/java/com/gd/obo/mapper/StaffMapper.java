package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Staff;

@Mapper
public interface StaffMapper {
	Staff selectStaffByLogin(Staff staff);
	int selectStaffLoginCk(Staff staff);
	Staff selectStaffOne(String staffId);
	Staff selectStaffLevel0(int shelterId);
	int selectStaffIdCheck(String staffId);
	int insertStaff(Staff staff);
	int updateStaff(Staff staff);
	int updateStaffLevel(String staffId);
}
