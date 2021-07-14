package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Staff;

@Mapper
public interface StaffMapper {
	Staff selectStaffByLogin(Staff staff);
	int insertStaff(Staff staff);
	int updateStaff(Staff staff);
}