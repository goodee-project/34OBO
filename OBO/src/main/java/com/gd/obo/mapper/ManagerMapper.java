package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Manager;

@Mapper
public interface ManagerMapper {
	Manager selectManagerByLogin(Manager manager);
	List<String> selectQualificationApprovalList();
}
