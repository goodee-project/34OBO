package com.gd.obo.mapper.staff;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Staff;

@Mapper
public interface StaffMapper {
	Staff selectStaffByLogin(Staff staff);
	int insertStaff();
}
